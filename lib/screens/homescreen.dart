import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import 'package:offlinemusicplayer/functions/audioconverterfunctions.dart';
import 'package:offlinemusicplayer/functions/favoritesfunctions.dart';
import 'package:offlinemusicplayer/functions/recentlyplayedfunctions.dart';
import 'package:offlinemusicplayer/screens/addtoplaylistscreen.dart';
import 'package:offlinemusicplayer/screens/melofinderscreen.dart';
import 'package:offlinemusicplayer/screens/mostlyplayedscreen.dart';
import 'package:offlinemusicplayer/screens/recentlyplayedscreen.dart';
import 'package:offlinemusicplayer/screens/settingsscreen.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shimmer/shimmer.dart';
import 'myfavoritesscreen.dart';
import 'nowplayingscreen.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<AllSongModel>('favorite');
    // ignore: unused_local_variable
    List<AllSongModel> songs = box.values.toList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: AnimatedBuilder(
            animation: const AlwaysStoppedAnimation(0),
            builder: (BuildContext context, Widget? child) {
              return Shimmer.fromColors(
                period: const Duration(seconds: 55),
                baseColor:
                    const Color.fromARGB(255, 64, 0, 255).withOpacity(0.9),
                highlightColor: Colors.deepOrange,
                child: const Text(
                  'MeloVibe',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MelofinderScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.content_paste_search),
            ),
            IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyFavoritesScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.favorite_rounded),
            ),
            IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.settings_rounded),
            ),
          ],
        ),
        body: Scrollbar(
          controller: controller,
          thickness: 6,
          thumbVisibility: false,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MostlyPlayedScreen(),
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/mostlyPlayed.jpg',
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Mostly played',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RecentlyPlayedScreen(),
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/recentlyplayed.jpg',
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Recently played',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'All Songs',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
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
                                id: allSongs[index].id!,
                                type: ArtworkType.AUDIO),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                recentadd(allSongs[index]);
                                audioConverter(allSongs, index);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NowPlayingScreen(
                                        music: allSongs[index]),
                                  ),
                                );
                              },
                              child: Container(
                                height: 70,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey),
                                child: ListTile(
                                  title: SizedBox(
                                    height: 20,
                                    child: Text(
                                      allSongs[index].name!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  subtitle: SizedBox(
                                    height: 20,
                                    child: Text(
                                      allSongs[index].artist ?? 'unknown',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                    ),
                                  ),
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
                                          child: fav.value
                                                  .contains(allSongs[index])
                                              ? const Text(
                                                  'Remove from favorites')
                                              : const Text('Add to favorites'),
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
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Confirmation'),
                                                content: const Text(
                                                    'Are you sure you want to remove the song from favorites?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      removeFromFav(
                                                          allSongs[index].id!);
                                                      Navigator.of(context)
                                                          .pop();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: const Text(
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
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          addToFav(allSongs[index].id!);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                'Song added to favorites successfully',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              backgroundColor: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   SnackBar(
                                        //     content: const Text(
                                        //       'Song added to playlist successfully',
                                        //       style: TextStyle(
                                        //           color: Colors.black),
                                        //     ),
                                        //     backgroundColor: Colors.green,
                                        //     shape: RoundedRectangleBorder(
                                        //       borderRadius:
                                        //           BorderRadius.circular(8),
                                        //     ),
                                        //   ),
                                        // );
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
                  itemCount: allSongs.length),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }
}
