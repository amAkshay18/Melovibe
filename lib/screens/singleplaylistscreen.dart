import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/database/model/playlistmodel.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import 'package:offlinemusicplayer/functions/audioconverterfunctions.dart';
import 'package:offlinemusicplayer/functions/playlistfunctions.dart';
import 'package:offlinemusicplayer/screens/nowplayingscreen.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';

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
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const AllPlaylistScreen(),
                // ));
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 28,
                color: Colors.black,
              )),
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
        body: Row(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: playlistnotifier,
                builder: (context, value, child) {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'assets/images/dummySong.jpg',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    audioConverter(listIndex.playlist!, index);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const NowPlayingScreen(),
                                    ));
                                  },
                                  child: Container(
                                    height: 70,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey),
                                    child: ListTile(
                                      title: Text(
                                        listIndex.playlist?[index].name ??
                                            "song name",
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        allSongs[index].artist ?? 'unknown',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: PopupMenuButton<String>(
                                        icon: const Icon(
                                          Icons.more_vert,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        itemBuilder: (BuildContext context) {
                                          return <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: 'favorites',
                                              child: Text('Add to favorites'),
                                            ),
                                            PopupMenuItem<String>(
                                              onTap: () {
                                                playlistRemoveSong(
                                                    listIndex
                                                            .playlist?[index] ??
                                                        music,
                                                    listIndex);
                                              },
                                              value: 'playlist',
                                              child:
                                                  Text('Remove from playlist'),
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
                      itemCount: listIndex.playlist?.length);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
