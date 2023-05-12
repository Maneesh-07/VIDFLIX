import 'dart:developer';

import 'package:VIDFLIX/model/model_file.dart';
import 'package:VIDFLIX/ui/video_playing/video_play_screen.dart';
import 'package:VIDFLIX/widgets/appbarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:flutter_video_info/flutter_video_info.dart';

import '../ui/setting_page_screen/setting_page.dart';

ValueNotifier<List> allVideos = ValueNotifier([]);

ValueNotifier<List<String>> favoritesVideoNotify = ValueNotifier([]);

Map<String, List<String>> playlist = {};

List<String> playlistKey = [];

ValueNotifier<List<String>> VideoHistoryListNotifier = ValueNotifier([]);

//for getting the name of video or folder from path
String getVideoName(String path) {
  var temp = path.split('/');
  String name = temp.removeLast();
  return name;
}

//creating playlist
addplaylist(String playlistName) {
  playlist[playlistName] = [];
  playlistKey.add(playlistName);
}

//show from videolist dialouge add playlist and playlist hive
Future<dynamic> showDialougeOfPlaylist(BuildContext context,
    {required int videoIndex, required List listFrom}) {
  return Future.delayed(
    Duration(seconds: 0),
    () => showDialog(
      context: context,
      builder: (context) {
        //hive open box
        final playlistBox = Hive.box<PlayList>('playlist_video'); //hive
        final playlistController = TextEditingController();
        return Center(
            child: SizedBox(
          height: MediaQuery.of(context).size.height * .50,
          width: MediaQuery.of(context).size.height * .40,
          child: Card(
            color: mainBGColor,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: playlistController,
                    decoration: const InputDecoration(
                        labelText: 'Playlist Name',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 217, 14, 0)),
                        border: OutlineInputBorder()),
                    style: TextStyle(color: allTextColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //add playlist name to hive
                        if (playlistController.text.trim() != '' &&
                            !playlistKey
                                .contains(playlistController.text.trim())) {
                          final playlistModel = PlayList(
                              playlistName: playlistController.text,
                              videosList: []);

                          playlistBox.add(playlistModel); //hive
                          addplaylist(playlistController.text);

                          isListView.notifyListeners();
                        }
                      },
                      child: const Text('add')),
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: isListView,
                        builder: (context, value, child) => playlist.isEmpty
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.mood_bad_sharp,
                                    color: Color.fromARGB(255, 218, 15, 0),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'No Playlist',
                                    style: TextStyle(
                                        fontSize: 20, color: mainBGColor),
                                  ),
                                ],
                              ))
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    tileColor: Colors.grey,
                                    onTap: () {
                                      if (!playlist[playlistKey[index]]!
                                          .contains(listFrom[videoIndex])) {
                                        //add video and playlist to hive
                                        playlist[playlistKey[index]]!
                                            .add(listFrom[videoIndex]);
                                        final playlistModel = PlayList(
                                            playlistName: playlistKey[index],
                                            videosList:
                                                playlist[playlistKey[index]]!);
                                        playlistBox.putAt(
                                            index, playlistModel); //hive
                                        log(
                                          'Successfully Added To "${playlistKey[index]}"',
                                        );
                                        snackBarMessage(
                                          context,
                                          'Successfully Added To "${playlistKey[index]}"',
                                        );
                                      } else {
                                        log('Already Contains');
                                        snackBarMessage(
                                            context, 'Already Contains');
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    leading: const Icon(
                                      Icons.playlist_play,
                                      color: Colors.black54,
                                      size: 50,
                                    ),
                                    title: Text(
                                      playlistKey[index],
                                      style: TextStyle(color: allTextColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: allTextColor,
                                  );
                                },
                                itemCount: playlist.length)),
                  )
                ],
              ),
            ),
          ),
        ));
      },
    ),
  );
}

//snackbar message
void snackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      width: 230,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      content: Center(
        child: Text(
          message,
          style: TextStyle(
              color: Color.fromARGB(255, 217, 14, 0),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: mainBGColor,
      elevation: 5,
    ));
}

//get everthing from hive

getEverthing() async {
  final likedBox = Hive.box<FavoritesVideo>('liked_video');
  final playlistBox = Hive.box<PlayList>('playlist_video');
  final videoHistorybox = Hive.box<VideoHistory>('video_History');
  favoritesVideoNotify.value.clear();
  playlist.clear();
  playlistKey.clear();
  VideoHistoryListNotifier.value.clear();

//get liked videos
  final List<FavoritesVideo> likedModelList = likedBox.values.toList();
  favoritesVideoNotify.value =
      likedModelList.map((element) => element.video).toList();

//get play list
  final List<PlayList> playlistModel = playlistBox.values.toList();
  playlistKey = playlistModel.map((element) => element.playlistName).toList();
  var listOfList = playlistModel.map((element) => element.videosList).toList();
  playlist = {
    for (var element in playlistKey)
      element: listOfList[playlistKey.indexOf(element)]
  };

  //get played history
  final List<VideoHistory> videoHistoryModelList =
      videoHistorybox.values.toList();
  VideoHistoryListNotifier.value =
      videoHistoryModelList.map((element) => element.video).toList();
}

//add Liked Videos

void addLikedVideo(BuildContext context, String video) async {
  if (!favoritesVideoNotify.value.contains(video)) {
    final likedModel = FavoritesVideo(video: video);
    final likedBox = Hive.box<FavoritesVideo>('liked_video');
    await likedBox.add(likedModel);
    favoritesVideoNotify.value.add(video);

    log('Successfully added to liked videos');
    snackBarMessage(context, 'Successfully Added To Favorites Videos');
    favoritesVideoNotify.notifyListeners();

    return;
  } else {
    log('already contains');
    snackBarMessage(context, 'Already Contains');
    return;
  }
}

//remove liked videos

void removeLikedVideo(int index, BuildContext context) {
  final likedBox = Hive.box<FavoritesVideo>('liked_video');
  favoritesVideoNotify.value.removeAt(index);
  likedBox.deleteAt(index);
  favoritesVideoNotify.notifyListeners();
  log('Removed From Liked');
  snackBarMessage(context, 'Removed From Liked');
  return;
}

//video duration

class VideoDuration extends StatelessWidget {
  VideoDuration({Key? key, required this.videoPath}) : super(key: key);
  String videoPath;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getVideoDuration(videoPath),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!,
              style: const TextStyle(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  fontSize: 12));
        } else {
          return Text('Error: ${snapshot.error}',
              style: const TextStyle(
                  backgroundColor: Colors.black, color: Colors.white));
        }
      },
    );
  }

  Future<String> getVideoDuration(videoPath) async {
    final videoInfo = FlutterVideoInfo();
    var info = await videoInfo.getVideoInfo(videoPath);

    return convertMillisecondsToTime(info!.duration!.toInt());
  }
}

convertMillisecondsToTime(int milliseconds) {
  int seconds = (milliseconds / 1000).truncate();
  int minutes = (seconds / 60).truncate();
  int hours = (minutes / 60).truncate();
  String hourText = '${hours.toString().padLeft(2, '')}:';
  if (hours == 0) {
    hourText = '';
  }

  String formattedTime =
      '$hourText${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  return formattedTime;
}

//delete Playlist Hive

void deletePlaylistHive(int index) {
  final playlistBox = Hive.box<PlayList>('playlist_video');
  playlist.remove(playlistKey[index]);
  playlistBox.deleteAt(index);
  playlistKey.removeAt(index);
  isListView.notifyListeners();
}

//delete a video from playlist

void deleteVideoFromPlaylist(int index, String playlistName) {
  final playlistBox = Hive.box<PlayList>('playlist_video');
  List<String> videoList = [];
  videoList.addAll(playlistBox.values
      .elementAt(playlistKey.indexOf(playlistName))
      .videosList);
  videoList.removeAt(index);
  PlayList playlistModel =
      PlayList(playlistName: playlistName, videosList: videoList);
  playlistBox.putAt(playlistKey.indexOf(playlistName), playlistModel);
  playlist[playlistName]!.removeAt(index);
  isListView.notifyListeners();
}

//rename playlist

void renamePlaylist(int index, BuildContext context) {
  final playlistController = TextEditingController(text: playlistKey[index]);
  Future.delayed(
    const Duration(seconds: 0),
    () => showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: SizedBox(
          height: MediaQuery.of(context).size.height * .25,
          width: MediaQuery.of(context).size.height * .40,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                        labelText: 'Playlist Name',
                        border: OutlineInputBorder()),
                    controller: playlistController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            playlistController.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text('cancel')),
                      ElevatedButton(
                          onPressed: () {
                            //playlist hive rename
                            if (playlistController.text.trim() != '' &&
                                !playlistKey
                                    .contains(playlistController.text.trim())) {
                              final playlistBox =
                                  Hive.box<PlayList>('playlist_video');
                              playlist[playlistController.text] =
                                  playlist[playlistKey[index]]!;

                              playlist.remove(playlistKey[index]);

                              playlistKey[index] = playlistController.text;
                              final playlistModel = PlayList(
                                  playlistName: playlistKey[index],
                                  videosList: playlist[playlistKey[index]]!);
                              playlistBox.putAt(index, playlistModel);

                              isListView.notifyListeners();
                              playlistController.clear();
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('add')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
      },
    ),
  );
}

//add to played history
addToPlayedHistory(String video, int position, int durations) async {
  final videoHistoryBox = Hive.box<VideoHistory>('video_History');
  final videoHistoryModel =
      VideoHistory(video: video, position: position, duration: durations);
  if (VideoHistoryListNotifier.value.contains(video)) {
    videoHistoryBox.deleteAt(VideoHistoryListNotifier.value.indexOf(video));
    VideoHistoryListNotifier.value.remove(video);
  }
  videoHistoryBox.add(videoHistoryModel);
  VideoHistoryListNotifier.value.add(video);
  SchedulerBinding.instance.addPostFrameCallback((_) {
    VideoHistoryListNotifier.notifyListeners();
  });
}

//resume button
class ResumeButton extends StatelessWidget {
  const ResumeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 216, 14, 0),
      onPressed: () {
        final lastPlayedBox = Hive.box<LastPlayed>('last_played');
        if (lastPlayedBox.isNotEmpty) {
          LastPlayed lastPlayedModel = lastPlayedBox.values.first;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VideoShowingPage(
                  index: 0,
                  fromList: [lastPlayedModel.video],
                  seekFrom: lastPlayedModel.position)));
        } else {
          snackBarMessage(context, 'No Videos Played Yet.');
        }
      },
      child: const Icon(
        Icons.play_arrow_rounded,
        size: 35,
        color: Colors.black,
      ),
    );
  }
}
