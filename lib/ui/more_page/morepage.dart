

import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:VIDFLIX/widgets/appbarWidget.dart';
import 'package:flutter/material.dart';

class Morescreen extends StatefulWidget {
  const Morescreen({super.key});

  @override
  State<Morescreen> createState() => _MorescreenState();
}

class _MorescreenState extends State<Morescreen> {
  @override
  Widget build(BuildContext context) {
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
                                    fontSize: 18),
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
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
