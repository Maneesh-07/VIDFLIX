import 'package:VIDFLIX/functions/all_functions.dart';
import 'package:VIDFLIX/ui/search_page/searchpage.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:flutter/material.dart';

ValueNotifier<bool> isListView = ValueNotifier(true);

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppBarColor,
      // leading: Padding(
      //   padding: const EdgeInsets.only(top: 10, left: 20),
      //   child: SizedBox(
      //     height: 30,
      //     width: 50,
      //     child: Image.asset(
      //       'assets/images/vidflix.png',
      //     ),
      //   ),
      // ),
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Image.asset(
          "assets/images/vidflix.png",
          scale: 9,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (isListView.value == true) {
                        isListView.value = false;
                      } else {
                        isListView.value = true;
                      }
                    });
                  },
                  icon: isListView.value == true
                      ? const Icon(Icons.grid_view_sharp)
                      : const Icon(Icons.format_list_numbered_sharp)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Searchscreen(),
                    ));
                  },
                  icon: Icon(Icons.search)),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                color: mainBGColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child:
                        Text('Refresh', style: TextStyle(color: allTextColor)),
                    onTap: () {
                      favoritesVideoNotify.value.clear();
                      playlist.clear();
                      playlistKey.clear();
                      isListView.notifyListeners();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class NewappbarWidgets extends StatefulWidget {
  const NewappbarWidgets({super.key});

  @override
  State<NewappbarWidgets> createState() => _NewappbarWidgetsState();
}

class _NewappbarWidgetsState extends State<NewappbarWidgets> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppBarColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          "Favorites",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                color: mainBGColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child:
                        Text('Refresh', style: TextStyle(color: allTextColor)),
                    onTap: () {
                      favoritesVideoNotify.value.clear();
                      playlist.clear();
                      playlistKey.clear();
                      isListView.notifyListeners();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class NewappbarWidgets01 extends StatefulWidget {
  const NewappbarWidgets01({super.key});

  @override
  State<NewappbarWidgets01> createState() => _NewappbarWidgetsState01();
}

class _NewappbarWidgetsState01 extends State<NewappbarWidgets01> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppBarColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Image.asset(
          "assets/images/vidflix.png",
          scale: 9,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                color: mainBGColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child:
                        Text('Refresh', style: TextStyle(color: allTextColor)),
                    onTap: () {
                      favoritesVideoNotify.value.clear();
                      playlist.clear();
                      playlistKey.clear();
                      isListView.notifyListeners();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class NewappbarWidgets02 extends StatefulWidget {
  const NewappbarWidgets02({super.key});

  @override
  State<NewappbarWidgets02> createState() => _NewappbarWidgetsState02();
}

class _NewappbarWidgetsState02 extends State<NewappbarWidgets02> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppBarColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          "Playlist",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                color: mainBGColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child:
                        Text('Refresh', style: TextStyle(color: allTextColor)),
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}


class MovieListAppbar extends StatefulWidget {
  const MovieListAppbar({super.key});

  @override
  State<MovieListAppbar> createState() => _MovieListAppbar();
}

class _MovieListAppbar extends State<MovieListAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppBarColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          "Movie List",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                color: mainBGColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child:
                        Text('Refresh', style: TextStyle(color: allTextColor)),
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
