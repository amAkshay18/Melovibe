import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:offlinemusicplayer/DataBase/Model/songdetails.dart';

ValueNotifier<List<SongDetails>> allSongNotifier = ValueNotifier([]);
Future<void> addToAllSongs(SongDetails song) async {
  final allSongDB = await Hive.openBox<SongDetails>('all_song_db');
  allSongDB.add(song);
  allSongNotifier.value.add(song);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  allSongNotifier.notifyListeners();
}

Future<void> get() async {
  final allSongDB = await Hive.openBox<SongDetails>('all_song_db');
  allSongNotifier.value.clear();
  allSongNotifier.value.addAll(allSongDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  allSongNotifier.notifyListeners();
}

ValueNotifier<List<SongDetails>> allsongBodyNotifier = ValueNotifier([]);

addSongs(SongDetails allSongs) async {
  allsongBodyNotifier.value.insert(
      0,
      SongDetails(
          name: allSongs.name,
          artist: allSongs.artist,
          duration: allSongs.duration,
          id: allSongs.id,
          url: allSongs.url));
  final allDBd = await Hive.openBox<SongDetails>('allsongs');
  SongDetails temp = SongDetails(
      artist: allSongs.artist,
      name: allSongs.name,
      id: allSongs.id,
      url: allSongs.url,
      duration: allSongs.duration);
  await allDBd.put(allSongs.id, temp);
}

Future<void> getSongs() async {
  // ignore: unused_local_variable
  final db = await Hive.openBox('name');
}
