import 'package:VIDFLIX/functions/all_functions.dart';
import 'package:VIDFLIX/ui/browse_page/browsefavoritepage.dart';
import 'package:VIDFLIX/ui/home_video_list/videolist.dart';
import 'package:VIDFLIX/ui/more_page/morepage.dart';
import 'package:VIDFLIX/ui/playlist_page/playlistmain.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  List page = [
    HomeVideolist(),
    BrowseFavoritepage(),
    PlaylistScreen(),
    Morescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, value, child) {
        return Scaffold(
            body: page.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: bottomNavColor,
              selectedIconTheme: IconThemeData(color: Colors.white),
              unselectedIconTheme:
                  IconThemeData(color: Color.fromARGB(255, 199, 199, 199)),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              currentIndex: _selectedIndex,
              onTap: onTapIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.video_collection_rounded,
                  ),
                  label: 'Video',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_sharp,
                  ),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.playlist_play_rounded,
                  ),
                  label: 'Platlists',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.more_vert_outlined,
                  ),
                  label: 'More',
                ),
              ],
              
            ),
            floatingActionButton: ResumeButton(),
            );
      },
    );
  }

  onTapIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
