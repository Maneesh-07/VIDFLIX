import 'package:VIDFLIX/functions/all_functions.dart';
import 'package:VIDFLIX/functions/thumbnail.dart';
import 'package:VIDFLIX/model/model_file.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:VIDFLIX/ui/video_playing/video_play_screen.dart';
import 'package:VIDFLIX/widgets/appbarWidget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Morescreen extends StatefulWidget {
  const Morescreen({super.key});

  @override
  State<Morescreen> createState() => _MorescreenState();
}

class _MorescreenState extends State<Morescreen> {
  @override
  Widget build(BuildContext context) {
    final playedHistoryBox = Hive.box<VideoHistory>('video_History');

    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: mainBGColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0), // here the desired height
              child: NewappbarWidgets01(),
            ),
            body: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Card(
                        color: mainBGColor,
                        margin: const EdgeInsets.all(20),
                        child: MediaQuery(
                          data: MediaQueryData(),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4 / 1,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 1.5,
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SettingScreen(),
                                ));
                              },
                              leading: Icon(
                                Icons.settings,
                                size: 35,
                                color: allTextColor,
                              ),
                              title: Text(
                                "Settings",
                                style: TextStyle(
                                    color: allTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: mainBGColor,
                        margin: const EdgeInsets.only(left: 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4 / 0.9,
                          height:
                              MediaQuery.of(context).size.height * 0.1 / 1.5,
                          child: ListTile(
                            onTap: () {
                              showAboutDialog(
                                  context: context,
                                  applicationIcon: Image.asset(
                                    "assets/images/vidflix.png",
                                    height: 40,
                                    width: 50,
                                  ),
                                  applicationVersion: "1.0.1",
                                  children: [
                                    const Text(
                                        "VIDFLIX is an offline Video player app which allows use to Play Video from their local storage and also do functions like add to favorites , create playlists , recently played  etc."),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("App developed by Maneesh M.")
                                  ]);
                            },
                            leading: Icon(
                              Icons.person,
                              size: 35,
                              color: allTextColor,
                            ),
                            title: Text(
                              "About",
                              style: TextStyle(
                                  color: allTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 230, left: 15),
                        child: Text(
                          'Recent',
                          style: TextStyle(
                              color: allTextColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: playedHistoryBox.isEmpty
                        ? Center(
                            child: Text(
                              'No History',
                              style:
                                  TextStyle(fontSize: 20, color: allTextColor),
                            ),
                          )
                        : ValueListenableBuilder(
                            valueListenable: VideoHistoryListNotifier,
                            builder: (context, value, child) => Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: ListView.builder(
                                itemCount: playedHistoryBox.length,
                                shrinkWrap: false,
                                scrollDirection:
                                    Axis.vertical, // Changed to vertical
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 1),
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      // color: containerColor,
                                    ),
                                    child: Center(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                VideoShowingPage(
                                              index: 0,
                                              fromList: [
                                                playedHistoryBox.values
                                                    .elementAt(playedHistoryBox
                                                            .length -
                                                        1 -
                                                        index)
                                                    .video
                                              ],
                                              seekFrom: playedHistoryBox.values
                                                  .elementAt(
                                                      playedHistoryBox.length -
                                                          1 -
                                                          index)
                                                  .position,
                                            ),
                                          ));
                                        },
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          child: Stack(
                                            children: [
                                              Container(
                                                color: Colors.black,
                                                height: 110,
                                                width: 100,
                                                child: ThumbnailWidget(
                                                  videoPath: playedHistoryBox
                                                      .values
                                                      .elementAt(
                                                          playedHistoryBox
                                                                  .length -
                                                              1 -
                                                              index)
                                                      .video,
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: 5,
                                                  right: 5,
                                                  child: VideoDuration(
                                                    videoPath: playedHistoryBox
                                                        .values
                                                        .elementAt(
                                                            playedHistoryBox
                                                                    .length -
                                                                1 -
                                                                index)
                                                        .video,
                                                  )),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: SliderTheme(
                                                  data: SliderTheme.of(context)
                                                      .copyWith(
                                                    trackHeight: 4.0,
                                                    overlayShape:
                                                        RoundSliderOverlayShape(
                                                            overlayRadius: 0),
                                                    thumbShape:
                                                        RoundSliderThumbShape(
                                                            enabledThumbRadius:
                                                                0),
                                                    activeTrackColor:
                                                        Color.fromARGB(
                                                            255, 213, 14, 0),
                                                  ),
                                                  child: Slider(
                                                    value: playedHistoryBox
                                                        .values
                                                        .elementAt(
                                                            playedHistoryBox
                                                                    .length -
                                                                1 -
                                                                index)
                                                        .position
                                                        .toDouble(),
                                                    min: 0.0,
                                                    max: playedHistoryBox.values
                                                        .elementAt(
                                                            playedHistoryBox
                                                                    .length -
                                                                1 -
                                                                index)
                                                        .duration
                                                        .toDouble(),
                                                    onChanged: (value) => {},
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        title: Text(
                                          getVideoName(playedHistoryBox.values
                                              .elementAt(
                                                  playedHistoryBox.length -
                                                      1 -
                                                      index)
                                              .video),
                                          style: TextStyle(color: allTextColor),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
