import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../DataBase/Model/songdetails.dart';

final OnAudioQuery audioQuery = OnAudioQuery();
List<SongDetails> allSongs = [];

class SongFetch {
  permissionRequest() async {
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  fetching() async {
    bool status = await permissionRequest();
    if (status) {
      List<SongModel> fetchSong = await audioQuery.querySongs();
      for (SongModel element in fetchSong) {
        if (element.fileExtension == 'mp3') {
          allSongs.add(
            SongDetails(
                name: element.displayNameWOExt,
                artist: element.artist,
                duration: element.duration,
                id: element.id,
                url: element.uri),
          );
        }
      }
    }
  }
}
