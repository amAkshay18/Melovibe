import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';
import '../database/model/fav_model.dart';

ValueNotifier<List<AllSongModel>> fav = ValueNotifier([]);

addToFav(int id) async {
  final favDB = await Hive.openBox<FavourModel>('fav_DB');
  await favDB.put(id, FavourModel(id: id));
  for (var elements in allSongs) {
    if (elements.id == id) {
      fav.value.add(elements);
    }
  }
}

Future<void> removeFromFav(int id) async {
  final favDB = await Hive.openBox<FavourModel>('fav_DB');
  await favDB.delete(id);
  for (var element in allSongs) {
    if (element.id == id) {
      fav.value.remove(element);
    }
  }
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  fav.notifyListeners();
}

favfetch() async {
  List<FavourModel> favsongcheck = [];
  Box<FavourModel> favdb = await Hive.openBox('fav_DB');
  favsongcheck.addAll(favdb.values);
  for (var favs in favsongcheck) {
    int count = 0;
    for (var songs in allSongs) {
      if (favs.id == songs.id) {
        fav.value.insert(0, songs);
        break;
      } else {
        count++;
      }
    }
    if (count == allSongs.length) {
      var key = favs.key;
      favdb.delete(key);
    }
  }
}
