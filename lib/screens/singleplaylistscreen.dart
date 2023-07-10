import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/database/model/playlistmodel.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import 'package:offlinemusicplayer/functions/audioconverterfunctions.dart';
import 'package:offlinemusicplayer/functions/playlistfunctions.dart';
import 'package:offlinemusicplayer/screens/miniplayer.dart';
import 'package:offlinemusicplayer/screens/nowplayingscreen.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/favoritesfunctions.dart';

// ignore: must_be_immutable
class SinglePlayListScreen extends StatelessWidget {
  String playlistname;
  final int idx;
  final PlayListModel listIndex;
  SinglePlayListScreen(
      {required this.playlistname,
      required this.listIndex,
      required this.idx,
      super.key});
  AllSongModel music = allSongs[0];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 28,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: Text(
            playlistname,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: playlistnotifier,
          builder: (context, value, child) {
            return Row(
              children: [
                Expanded(
                  child: playlistnotifier.value[index].playlist?.isEmpty ?? true
                      ? const Center(
                          child: Text('please add some songs'),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: QueryArtworkWidget(
                                        artworkClipBehavior: Clip.none,
                                        artworkHeight: 70,
                                        artworkWidth: 70,
                                        nullArtworkWidget: Image.asset(
                                          'assets/images/dummySong.jpg',
                                          fit: BoxFit.cover,
                                          width: 70,
                                          height: 70,
                                        ),
                                        id: playlistnotifier
                                            .value[index].playlist![index].id!,
                                        type: ArtworkType.AUDIO),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        audioConverter(
                                            listIndex.playlist!, index);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const NowPlayingScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 70,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey),
                                        child: ListTile(
                                          title: Text(
                                            playlistnotifier.value[index]
                                                    .playlist![index].name ??
                                                "song name",
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            playlistnotifier.value[index]
                                                    .playlist![index].artist ??
                                                'unknown',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: PopupMenuButton<String>(
                                            icon: const Icon(
                                              Icons.more_vert,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                            itemBuilder:
                                                (BuildContext context) {
                                              return <PopupMenuEntry<String>>[
                                                PopupMenuItem<String>(
                                                  value: 'favorites',
                                                  child: fav.value.contains(
                                                          allSongs[index])
                                                      ? const Text(
                                                          'Remove from favorites')
                                                      : const Text(
                                                          'Add to favorites'),
                                                ),
                                                PopupMenuItem<String>(
                                                  onTap: () {
                                                    playlistRemoveSong(
                                                        listIndex.playlist?[
                                                                index] ??
                                                            music,
                                                        listIndex);
                                                  },
                                                  value: 'playlist',
                                                  child: const Text(
                                                      'Remove from playlist'),
                                                ),
                                                // const PopupMenuItem<String>(
                                                //   value: 'share',
                                                //   child: Text('Share'),
                                                // ),
                                                // const PopupMenuItem<String>(
                                                //   value: 'rename',
                                                //   child: Text('Rename'),
                                                // ),
                                                // const PopupMenuItem<String>(
                                                //   value: 'delete',
                                                //   child: Text('Delete'),
                                                // ),
                                              ];
                                            },
                                            onSelected: (String value) {
                                              if (value == 'favorites') {
                                                fav.value.contains(
                                                        allSongs[index])
                                                    ? removeFromFav(
                                                        allSongs[index].id!)
                                                    : addToFav(
                                                        allSongs[index].id!);
                                              } else if (value == 'playlist') {}
                                              //else if (value == 'share') {
                                              // } else if (value == 'rename') {}
                                              //else if (value == 'delete')
                                              // {}
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount:
                              playlistnotifier.value[index].playlist?.length),
                ),
              ],
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
        bottomSheet: const MiniPlayer(),
      ),
    );
  }
}
