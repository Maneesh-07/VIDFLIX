
import 'package:VIDFLIX/functions/all_functions.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:VIDFLIX/widgets/appbarWidget.dart';
import 'package:VIDFLIX/widgets/list_view.dart';
import 'package:flutter/material.dart';

class Playlistpage extends StatelessWidget {
  Playlistpage({super.key, required this.playlistIndex});

  int playlistIndex;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: mainBGColor,
            // appBar: 
            body: ListViewWidgetForInnerPlaylist(
                fromPlaylistName: playlistKey[playlistIndex]),
          );
        });
  }
}
