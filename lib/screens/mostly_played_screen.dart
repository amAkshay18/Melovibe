import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/screens/playlist/add_to_playlists_screen.dart';
import 'package:offlinemusicplayer/screens/splash_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../functions/audio_converter_functions.dart';
import '../functions/favorites_functions.dart';
import '../functions/mostly_played_functions.dart';
import 'mini_player.dart';
import 'nowplaying_screen.dart';

class MostlyPlayedScreen extends StatelessWidget {
  const MostlyPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'Mostly played',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 28,
                color: Colors.black,
              )),
        ),
        body: Row(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: mostPlayedList,
                builder: (context, value, child) {
                  if (mostPlayedList.value.isEmpty) {
                    return Center(
                      child: Text('please play some songs...'),
                    );
                  } else {
                    return ListView.builder(
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
                                      id: mostPlayedList.value[index].id!,
                                      type: ArtworkType.AUDIO),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      audioConverter(
                                          mostPlayedList.value, index);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NowPlayingScreen(
                                                  music: mostPlayedList
                                                      .value[index]),
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
                                          mostPlayedList.value[index].name!,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            mostPlayedList
                                                    .value[index].artist ??
                                                'unknown',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1),
                                        trailing: PopupMenuButton(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              PopupMenuItem(
                                                value: 'favorites',
                                                child: fav.value.contains(
                                                        allSongs[index])
                                                    ? const Text(
                                                        'Remove from favorites')
                                                    : const Text(
                                                        'Add to favorites'),
                                              ),
                                              const PopupMenuItem(
                                                value: 'playlist',
                                                child: Text('Add to playlist'),
                                              ),
                                            ];
                                          },
                                          onSelected: (String value) {
                                            if (value == 'favorites') {
                                              if (fav.value
                                                  .contains(allSongs[index])) {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Confirmation'),
                                                      content: const Text(
                                                          'Are you sure you want to remove the song from favorites?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            removeFromFav(
                                                                allSongs[index]
                                                                    .id!);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content:
                                                                    const Text(
                                                                  'Song is removed from favorites successfully',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                backgroundColor:
                                                                    Colors.red,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: const Text(
                                                            'Remove',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                addToFavorites(
                                                    allSongs[index].id!);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: const Text(
                                                      'Song added to favorites successfully',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                );
                                              }
                                            } else if (value == 'playlist') {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddToPlaylistsScreen(
                                                    music: allSongs[index],
                                                  ),
                                                ),
                                              );
                                            }
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
                        itemCount: mostPlayedList.value.length);
                  }
                },
              ),
            ),
          ],
        ),
        bottomSheet: const MiniPlayer(),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }
}
