import 'package:VIDFLIX/functions/all_functions.dart';
import 'package:VIDFLIX/functions/thumbnail.dart';
import 'package:VIDFLIX/model/model_file.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:VIDFLIX/ui/video_playing/video_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScreenHistory extends StatelessWidget {
  const ScreenHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final playedHistoryBox = Hive.box<VideoHistory>('video_History');
    return Scaffold(
      backgroundColor: mainBGColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            title: Text('History'),
            actions: [
              PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                color: mainBGColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('Clear History',
                        style: TextStyle(color: allTextColor)),
                    onTap: () {
                      VideoHistoryListNotifier.value.clear();
                      playedHistoryBox.clear();
                      // SchedulerBinding.instance.addPostFrameCallback((_) {
                      VideoHistoryListNotifier.notifyListeners();
                      // });
                    },
                  )
                ],
              )
            ],
          )),
      body: playedHistoryBox.isEmpty
          ? Center(
              child: Text(
              'No History',
              style: TextStyle(fontSize: 20),
            ))
          : Padding(
              padding: EdgeInsets.all(10),
              child: ValueListenableBuilder(
                valueListenable: VideoHistoryListNotifier,
                builder: (context, value, child) => GridView.builder(
                  itemCount: playedHistoryBox.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => VideoShowingPage(
                                        index: 0,
                                        fromList: [
                                          playedHistoryBox.values
                                              .elementAt(
                                                  playedHistoryBox.length -
                                                      1 -
                                                      index)
                                              .video
                                        ],
                                        seekFrom: playedHistoryBox.values
                                            .elementAt(playedHistoryBox.length -
                                                1 -
                                                index)
                                            .position),
                                  ));
                                },
                                child: Container(
                                  color: Colors.black,
                                  height: 95,
                                  width: 150,
                                  child: ThumbnailWidget(
                                      videoPath: playedHistoryBox.values
                                          .elementAt(playedHistoryBox.length -
                                              1 -
                                              index)
                                          .video),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: VideoDuration(
                                    videoPath: playedHistoryBox.values
                                        .elementAt(
                                            playedHistoryBox.length - 1 - index)
                                        .video,
                                  )),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 4.0,
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 0),
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 0),
                                    activeTrackColor:
                                        Color.fromARGB(255, 213, 14, 0),
                                  ),
                                  child: Slider(
                                    value: playedHistoryBox.values
                                        .elementAt(
                                            playedHistoryBox.length - 1 - index)
                                        .position
                                        .toDouble(),
                                    min: 0.0,
                                    max: playedHistoryBox.values
                                        .elementAt(
                                            playedHistoryBox.length - 1 - index)
                                        .duration
                                        .toDouble(),
                                    onChanged: (value) => {},
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            getVideoName(playedHistoryBox.values
                                .elementAt(playedHistoryBox.length - 1 - index)
                                .video),
                            style: TextStyle(color: allTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
