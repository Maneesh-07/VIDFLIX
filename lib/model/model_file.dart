import 'package:hive_flutter/hive_flutter.dart';
part 'model_file.g.dart';

@HiveType(typeId: 0)
class FavoritesVideo {
  @HiveField(0)
  final String video;

  FavoritesVideo({required this.video});
}

@HiveType(typeId: 1)
class PlayList extends HiveObject {
  @HiveField(0)
  final String playlistName;
  @HiveField(1)
  final List<String> videosList;

  PlayList({required this.playlistName, required this.videosList});
}

@HiveType(typeId: 2)
class LastPlayed extends HiveObject {
  @HiveField(0)
  final String video;

  @HiveField(1)
  final int position;

  LastPlayed({required this.video, required this.position});
}

@HiveType(typeId: 3)
class VideoHistory extends HiveObject {
  @HiveField(0)
  final String video;

  @HiveField(1)
  final int position;

  @HiveField(2)
  final int duration;

  VideoHistory(
      {required this.video, required this.position, required this.duration});
}
