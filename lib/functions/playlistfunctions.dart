import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import '../database/model/playlistmodel.dart';

ValueNotifier<List<PlayListModel>> playlistnotifier = ValueNotifier([]);
bool createPlaylist(String name) {
  bool check = false;
  for (var element in playlistnotifier.value) {
    if (element.playListName == name) {
      check = true;
      return false;
    }
  }
  if (check == false) {
    PlayListModel item = PlayListModel(playListName: name);
    addToPlaylist(item);
  }
  return true;
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
  String? playlistName = playlistnotifier.value[index].playListName;
  final playlistDB = await Hive.openBox<PlayListModel>('playlist');
  for (PlayListModel elements in playlistDB.values) {
    if (elements.playListName == playlistName) {
      var key = elements.key;
      playlistDB.delete(key);
    }
  }
  playlistnotifier.value.removeAt(index);

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

Future<void> renamePlaylist(int index, String newname) async {
  String? playListname = playlistnotifier.value[index].playListName;
  final playListDB = await Hive.openBox<PlayListModel>('PlayList');
  for (PlayListModel element in playListDB.values) {
    if (element.playListName == playListname) {
      var key = element.key;
      element.playListName = newname;
      playListDB.put(key, element);
    }
  }
  playlistnotifier.value[index].playListName = newname;
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

addSongToPlaylist(AllSongModel song, String name, BuildContext context) {
  // ignore: unused_local_variable
  int indx = 0;
  bool check = false;
  List<AllSongModel> forThisPlayList = [];
  for (var element in playlistnotifier.value) {
    if (element.playListName == name) {
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
        PlayListModel(playListName: name, playlist: forThisPlayList);
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
    if (element.playListName == playListItem.playListName) {
      break;
    }
    index++;
  }
  playListDB.putAt(index, playListItem);
  getPlaylist();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

playlistRemoveSong(AllSongModel song, PlayListModel playlist) async {
  // ignore: unused_local_variable
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
      PlayListModel(playListName: playlist.playListName, playlist: songs);
  playlistSongAddDB(thisPlayList);
}
