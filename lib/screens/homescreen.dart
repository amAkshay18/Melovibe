// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:marquee/marquee.dart';
// import 'package:offlinemusicplayer/database/model/song_model.dart';
// import 'package:offlinemusicplayer/functions/audioconverterfunctions.dart';
// import 'package:offlinemusicplayer/functions/favoritesfunctions.dart';
// import 'package:offlinemusicplayer/screens/miniplayer.dart';
// import 'package:offlinemusicplayer/functions/recentlyplayedfunctions.dart';
// import 'package:offlinemusicplayer/screens/mostlyplayedscreen.dart';
// import 'package:offlinemusicplayer/screens/recentlyplayedscreen.dart';
// import 'package:offlinemusicplayer/screens/settingsscreen.dart';
// import 'package:offlinemusicplayer/screens/splashscreen.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'melofinderscreen.dart';
// import 'myfavoritesscreen.dart';
// import 'nowplayingscreen.dart';

// class ScreenHome extends StatefulWidget {
//   const ScreenHome({super.key});

//   @override
//   State<ScreenHome> createState() => _ScreenHomeState();
// }

// class _ScreenHomeState extends State<ScreenHome> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final box = Hive.box<AllSongModel>('favorite');
//     List<AllSongModel> songs = box.values.toList();
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.grey,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(16),
//             ),
//           ),
//           title: const Text(
//             'Good evening',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           actions: [
//             IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const MelofinderScreen(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.content_paste_search),
//             ),
//             IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const MyFavoritesScreen(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.favorite_rounded),
//             ),
//             IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const SettingsScreen(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.settings_rounded),
//             ),
//           ],
//         ),
//         body: ListView(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(20.0),
//                         child: InkWell(
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const MostlyPlayedScreen(),
//                             ),
//                           ),
//                           child: Image.asset(
//                             'assets/images/mostly.jpg',
//                             width: 140,
//                             height: 140,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       const Text(
//                         'Mostly played',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(20.0),
//                         child: InkWell(
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   const RecentlyPlayedScreen(),
//                             ),
//                           ),
//                           child: Image.asset(
//                             'assets/images/recentlyplayed.jpg',
//                             width: 140,
//                             height: 140,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       const Text(
//                         'Recently played',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     'All Songs',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             ListView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(16),
//                           child: QueryArtworkWidget(
//                               artworkClipBehavior: Clip.none,
//                               artworkHeight: 70,
//                               artworkWidth: 70,
//                               nullArtworkWidget: Image.asset(
//                                 'assets/images/dummySong.jpg',
//                                 fit: BoxFit.cover,
//                                 width: 70,
//                                 height: 70,
//                               ),
//                               id: allSongs[index].id!,
//                               type: ArtworkType.AUDIO),
//                         ),
//                         const SizedBox(
//                           width: 8,
//                         ),
//                         Expanded(
//                           child: InkWell(
//                             onTap: () {
//                               recentadd(allSongs[index]);
//                               audioConverter(allSongs, index);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       NowPlayingScreen(music: allSongs[index]),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               height: 70,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: Colors.grey),
//                               child: ListTile(
//                                 title: SizedBox(
//                                   height: 15,
//                                   child: Marquee(
//                                     velocity: 25,
//                                     text: allSongs[index].name!,
//                                     blankSpace: 15,
//                                   ),
//                                 ),
//                                 subtitle: SizedBox(
//                                   height: 15,
//                                   child: Marquee(
//                                     velocity: 25,
//                                     text: allSongs[index].artist ?? 'unknown',
//                                     blankSpace: 30,
//                                   ),
//                                 ),
//                                 trailing: PopupMenuButton<String>(
//                                   icon: const Icon(
//                                     Icons.more_vert,
//                                     size: 20,
//                                     color: Colors.black,
//                                   ),
//                                   itemBuilder: (BuildContext context) {
//                                     return <PopupMenuEntry<String>>[
//                                       PopupMenuItem<String>(
//                                         value: 'favorites',
//                                         child: fav.value
//                                                 .contains(allSongs[index])
//                                             ? const Text(
//                                                 'Remove from favorites')
//                                             : const Text('Add to favorites'),
//                                       ),
//                                       const PopupMenuItem<String>(
//                                         value: 'playlist',
//                                         child: Text('Add to playlist'),
//                                       ),
//                                       // const PopupMenuItem<String>(
//                                       //   value: 'share',
//                                       //   child: Text('Share'),
//                                       // ),
//                                       // const PopupMenuItem<String>(
//                                       //   value: 'rename',
//                                       //   child: Text('Rename'),
//                                       // ),
//                                       // const PopupMenuItem<String>(
//                                       //   value: 'delete',
//                                       //   child: Text('Delete'),
//                                       // ),
//                                     ];
//                                   },
//                                   onSelected: (String value) {
//                                     if (value == 'favorites') {
//                                       fav.value.contains(allSongs[index])
//                                           ? removeFromFav(allSongs[index].id!)
//                                           : addToFav(allSongs[index].id!);
//                                     } else if (value == 'playlist') {}
//                                     //else if (value == 'share') {
//                                     // } else if (value == 'rename') {}
//                                     //else if (value == 'delete')
//                                     // {}
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 itemCount: allSongs.length),
//           ],
//         ),
//         bottomSheet: const MiniPlayer(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import 'package:offlinemusicplayer/functions/audioconverterfunctions.dart';
import 'package:offlinemusicplayer/functions/favoritesfunctions.dart';
import 'package:offlinemusicplayer/screens/miniplayer.dart';
import 'package:offlinemusicplayer/functions/recentlyplayedfunctions.dart';
import 'package:offlinemusicplayer/screens/mostlyplayedscreen.dart';
import 'package:offlinemusicplayer/screens/recentlyplayedscreen.dart';
import 'package:offlinemusicplayer/screens/settingsscreen.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'melofinderscreen.dart';
import 'myfavoritesscreen.dart';
import 'nowplayingscreen.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<AllSongModel>('favorite');
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
          title: const Text(
            'Good evening',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
        body: ListView(
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
                              builder: (context) => const MostlyPlayedScreen(),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
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
                                  builder: (context) =>
                                      NowPlayingScreen(music: allSongs[index]),
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
                                          fontWeight: FontWeight.bold),
                                    )
                                    // Marquee(
                                    //   pauseAfterRound: const Duration(seconds: 5),
                                    //   velocity: 25,
                                    //   text: allSongs[index].name!,
                                    //   blankSpace: 15,
                                    // ),
                                    ),
                                subtitle: SizedBox(
                                  height: 20,
                                  child: Text(
                                    allSongs[index].artist ?? 'unknown',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Marquee(
                                  //   velocity: 25,
                                  //   text: allSongs[index].artist ?? 'unknown',
                                  //   blankSpace: 30,
                                  // ),
                                ),
                                trailing: PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'favorites',
                                        child: fav.value
                                                .contains(allSongs[index])
                                            ? const Text(
                                                'Remove from favorites')
                                            : const Text('Add to favorites'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'playlist',
                                        child: Text('Add to playlist'),
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
                                      fav.value.contains(allSongs[index])
                                          ? removeFromFav(allSongs[index].id!)
                                          : addToFav(allSongs[index].id!);
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
                itemCount: allSongs.length),
          ],
        ),
        bottomSheet: const MiniPlayer(),
      ),
    );
  }
}
