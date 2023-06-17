import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:offlinemusicplayer/DataBase/Model/songdetails.dart';

List<Audio> audioList = [];
AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
bool notification = true;
audioConverter(List<SongDetails> songs, int index) async {
  assetsAudioPlayer.stop();
  audioList.clear();
  for (int i = 0; i < songs.length; i++) {
    audioList.add(
      Audio.file(
        songs[i].url!,
        metas: Metas(
            title: songs[i].name,
            artist: songs[i].artist,
            id: songs[i].id.toString()),
      ),
    );
  }
  await assetsAudioPlayer.open(
    Playlist(audios: audioList, startIndex: index),
    showNotification: notification,
    notificationSettings: const NotificationSettings(stopEnabled: false),
  );
  assetsAudioPlayer.setLoopMode(LoopMode.playlist);
}
