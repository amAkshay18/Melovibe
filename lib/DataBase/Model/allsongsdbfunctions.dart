import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:offlinemusicplayer/DataBase/Model/songdetails.dart';

ValueNotifier<List<SongDetails>> allSongNotifier = ValueNotifier([]);
Future<void> addToAllSongs(SongDetails song) async {
  final allSongDB = await Hive.openBox<SongDetails>('all_song_db');
  allSongDB.add(song);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  allSongNotifier.notifyListeners();
}

Future<void> get() async {
  final allSongDB = await Hive.openBox<SongDetails>('all_song_db');
  allSongNotifier.value.clear();
  allSongNotifier.value.addAll(allSongDB.values);
}
