

import 'package:VIDFLIX/ui/browse_page/favoriteslist.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:VIDFLIX/widgets/appbarWidget.dart';
import 'package:flutter/material.dart';

class BrowseFavoritepage extends StatefulWidget {
  const BrowseFavoritepage({super.key});

  @override
  State<BrowseFavoritepage> createState() => _BrowseFavoritepageState();
}

class _BrowseFavoritepageState extends State<BrowseFavoritepage> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: mainBGColor,
            appBar: PreferredSize(
                child: NewappbarWidgets(), preferredSize: Size.fromHeight(70)),
            body: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FavoritesScreen(),
            ),
          );
        });
  }
}
