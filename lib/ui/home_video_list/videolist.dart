

import 'package:VIDFLIX/functions/all_functions.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:VIDFLIX/widgets/appbarWidget.dart';
import 'package:VIDFLIX/widgets/girdview.dart';
import 'package:VIDFLIX/widgets/list_view.dart';
import 'package:flutter/material.dart';

List videos = [];
// ValueNotifier<bool> isListview = ValueNotifier(true);

class HomeVideolist extends StatefulWidget {
  const HomeVideolist({Key? key}) : super(key: key);

  @override
  State<HomeVideolist> createState() => _HomeVideolistState();
}

class _HomeVideolistState extends State<HomeVideolist> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isListView,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: mainBGColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0), // here the desired height
            child: AppBarWidget(),
          ),
          body: isListView.value == true
              ? Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: ListViewWidgetForAllVideos(),
                )
              : GridViewWidgetForAllVideos(),
          floatingActionButton: ResumeButton(),
        );
      },
    );
  }
}
