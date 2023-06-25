import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';

List<Audio> audioList = [];
AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
bool notification = true;
audioConverter(List<AllSongModel> songs, int index) async {
  audioList.clear();
  assetsAudioPlayer.stop();

  for (int i = 0; i < songs.length; i++) {
    audioList.add(
      Audio.file(
        songs[i].uri!,
        metas: Metas(
          title: songs[i].name,
          artist: songs[i].artist,
          id: songs[i].id.toString(),
        ),
      ),
    );
  }
  await assetsAudioPlayer.open(
    Playlist(audios: audioList, startIndex: index),
    showNotification: notification,
    notificationSettings: const NotificationSettings(
      stopEnabled: false,
    ),
    headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
  );
  assetsAudioPlayer.setLoopMode(LoopMode.playlist);
}

findCurrentSong(int playingId) {
  for (var element in allSongs) {
    if (element.id == playingId) {
      song = element;
      break;
    }
  }
}

AllSongModel? song;
