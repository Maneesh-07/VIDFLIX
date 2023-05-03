
import 'package:VIDFLIX/functions/all_functions.dart';
import 'package:VIDFLIX/ui/home_page/homescreen.dart';
import 'package:VIDFLIX/ui/home_video_list/videolist.dart';
import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    getVideos();

    super.initState();
  }

  getVideos() async {
    await Future.delayed(Duration(seconds: 5));
    FetchAllVideos obj = FetchAllVideos();
    videos = await obj.getAllVideos();
    allVideos.value.addAll(videos);

    print(videos);

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Homescreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/vidflix.png',
                width: 270,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Color.fromARGB(255, 232, 15, 0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
