import 'package:hive_flutter/adapters.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
part 'playlistmodel.g.dart';

@HiveType(typeId: 3)
class PlayListModel extends HiveObject {
  @HiveField(0)
  String? playlistName;
  @HiveField(1)
  List<AllSongModel>? playlist = [];
  PlayListModel({required this.playlistName, this.playlist});
}