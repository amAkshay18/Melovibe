import 'package:on_audio_query/on_audio_query.dart';
import '../database/model/song_model.dart';

class SearchFunctions {
  // Method to fetch songs for search screen
  static Future<List<AllSongModel>> fetchSongs() async {
    final OnAudioQuery audioQuery = OnAudioQuery();
    List<SongModel> fetchSong = await audioQuery.querySongs();
    List<AllSongModel> songs = [];
    for (SongModel element in fetchSong) {
      if (element.fileExtension == 'mp3') {
        songs.add(
          AllSongModel(
            name: element.displayNameWOExt,
            artist: element.artist,
            duration: element.duration,
            id: element.id,
            uri: element.uri,
          ),
        );
      }
    }
    return songs;
  }
}
