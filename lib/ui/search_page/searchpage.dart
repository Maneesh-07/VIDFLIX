
import 'package:VIDFLIX/functions/all_functions.dart';
import 'package:VIDFLIX/functions/thumbnail.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:VIDFLIX/ui/video_playing/video_play_screen.dart';
import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController searchController = TextEditingController();

  List searchList = List<String>.from(allVideos.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bottomNavColor,
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(child: Text('Search')),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search for a Video",
              style: TextStyle(
                  color: allTextColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  searchList = allVideos.value
                      .where((element) => getVideoName(element)
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              controller: searchController,
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                hintText: "eg: The Dark Side",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: searchList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mood_bad_sharp,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "No Results Found",
                              style:
                                  TextStyle(fontSize: 20, color: allTextColor),
                            )
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VideoShowingPage(
                                    index: index,
                                    fromList: searchList,
                                    seekFrom: 0),
                              ));
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Stack(
                                children: [
                                  Container(
                                    color: Colors.black,
                                    height: 95,
                                    width: 100,
                                    child: ThumbnailWidget(
                                        videoPath: searchList[index]),
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: VideoDuration(
                                        videoPath: searchList[index],
                                      ))
                                ],
                              ),
                            ),
                            title: Text(
                              getVideoName(searchList[index]),
                              style: TextStyle(color: allTextColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: PopupMenuButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.grey,
                              ),
                              color: mainBGColor,
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    child: Text('Add to Favorites videos',
                                        style: TextStyle(color: allTextColor)),
                                    onTap: () {
                                      addLikedVideo(context, searchList[index]);
                                    }),
                                PopupMenuItem(
                                  child: Text('Add to Playlist',
                                      style: TextStyle(color: allTextColor)),
                                  onTap: () {
                                    showDialougeOfPlaylist(context,
                                        videoIndex: index,
                                        listFrom: searchList);
                                  },
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: allTextColor,
                          );
                        },
                        itemCount: searchList.length))
          ],
        ),
      ),
    );
  }
}
