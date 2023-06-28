import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import '../database/model/playlistmodel.dart';

ValueNotifier<List<PlayListModel>> playlistnotifier = ValueNotifier([]);
createPlaylist(String name) {
  bool check = false;
  for (var element in playlistnotifier.value) {
    if (element.playlistName == name) {
      check = true;
      break;
    }
  }
  if (check == false) {
    PlayListModel item = PlayListModel(playlistName: name);
    addToPlaylist(item);
  }
}

addToPlaylist(PlayListModel item) async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist');
  playlistDB.add(item);
  getPlaylist();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

Future<void> getPlaylist() async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist');

  playlistnotifier.value.clear();
  playlistnotifier.value.addAll(playlistDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

deletePlaylist(int index) async {
  String? playlistName = playlistnotifier.value[index].playlistName;
  final playlistDB = await Hive.openBox<PlayListModel>('playlist');
  for (PlayListModel elements in playlistDB.values) {
    if (elements.playlistName == playlistName) {
      var key = elements.key;
      playlistDB.delete(key);
    }
  }
  playlistnotifier.value.removeAt(index);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

Future<void> renamePlaylist(int index, String newname) async {
  String? playListname = playlistnotifier.value[index].playlistName;
  final playListDB = await Hive.openBox<PlayListModel>('PlayList');
  for (PlayListModel element in playListDB.values) {
    if (element.playlistName == playListname) {
      var key = element.key;
      element.playlistName = newname;
      playListDB.put(key, element);
    }
  }
  playlistnotifier.value[index].playlistName = newname;
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

addSongToPlaylist(AllSongModel song, String name, BuildContext context) {
  int indx = 0;
  bool check = false;
  List<AllSongModel> forThisPlayList = [];
  for (var element in playlistnotifier.value) {
    if (element.playlistName == name) {
      forThisPlayList = element.playlist ?? forThisPlayList;
      break;
    }
    indx++;
  }
  for (var element in forThisPlayList) {
    if (element.id == song.id) {
      check = true;
      break;
    }
  }
  if (check == false) {
    forThisPlayList.add(song);
    PlayListModel thisPlaylist =
        PlayListModel(playlistName: name, playlist: forThisPlayList);
    playlistSongAddDB(thisPlaylist);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("The song is already exist"),
      ),
    );
  }
}

playlistSongAddDB(PlayListModel playListItem) async {
  final playListDB = await Hive.openBox<PlayListModel>('PlayList');
  int index = 0;
  for (var element in playListDB.values) {
    if (element.playlistName == playListItem.playlistName) {
      break;
    }
    index++;
  }
  playListDB.putAt(index, playListItem);
  getPlaylist();
  playlistnotifier.notifyListeners();
}

playlistRemoveSong(AllSongModel song, PlayListModel playlist) async {
  final playlistDB = await Hive.openBox<PlayListModel>('PlayList');
  List<AllSongModel> songs = [];
  songs = playlist.playlist ?? songs;
  int indx = 0;
  for (var element in songs) {
    if (element.id == song.id) {
      break;
    }
    indx++;
  }
  songs.removeAt(indx);
  PlayListModel thisPlayList =
      PlayListModel(playlistName: playlist.playlistName, playlist: songs);
  playlistSongAddDB(thisPlayList);
}
