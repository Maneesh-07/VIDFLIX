
import 'package:VIDFLIX/functions/all_functions.dart';
import 'package:VIDFLIX/model/model_file.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:VIDFLIX/ui/splash_page/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FavoritesVideoAdapter().typeId)) {
    Hive.registerAdapter(FavoritesVideoAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListAdapter().typeId)) {
    Hive.registerAdapter(PlayListAdapter());
  }
  if (!Hive.isAdapterRegistered(LastPlayedAdapter().typeId)) {
    Hive.registerAdapter(LastPlayedAdapter());
  }
  if (!Hive.isAdapterRegistered(VideoHistoryAdapter().typeId)) {
    Hive.registerAdapter(VideoHistoryAdapter());
  }

  await Hive.openBox<FavoritesVideo>('liked_video');
  await Hive.openBox<PlayList>('playlist_video');
  await Hive.openBox<LastPlayed>('last_played');
  await Hive.openBox<VideoHistory>('video_History');
  getEverthing();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, isDarkModevalue, child) {
        return MaterialApp(
            // color: mainBGColor,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: AppBarColor,
              // appBarTheme: AppBarTheme(
              //   color: isDarkMode.value
              //       ? Color.fromARGB(255, 6, 3, 17)
              //       : mainBGColor,
              // ),
            ),
            home: const Splashscreen());
      },
    );
  }
}
