import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/functions/audioconverterfunctions.dart';
import 'package:offlinemusicplayer/screens/mostlyplayedscreen.dart';
import 'package:offlinemusicplayer/screens/recentlyplayed.dart';
import 'package:offlinemusicplayer/screens/settingsscreen.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';
import '../DataBase/Model/allsongsdbfunctions.dart';
import 'melofinder.dart';
import 'myfavorites.dart';
import 'nowplaying.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Good evening',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
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
                            'assets/images/mostly.jpg',
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
            ValueListenableBuilder(
              valueListenable: allsongBodyNotifier,
              builder: (context, value, child) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                'assets/images/song1.jpg',
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  audioConverter(listOfSongs, index);
                                  Navigator.push(
                                    context,
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
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey),
                                  child: ListTile(
                                    title: Text(listOfSongs[index].name!,
                                        maxLines: 1),
                                    subtitle: Text(
                                        listOfSongs[index].artist ?? 'unknown',
                                        maxLines: 1),
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
                    itemCount: listOfSongs.length);
              },
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:offlinemusicplayer/screens/mostlyplayedscreen.dart';
// import 'package:offlinemusicplayer/screens/recentlyplayed.dart';
// import 'package:offlinemusicplayer/screens/settingsscreen.dart';
// import 'package:offlinemusicplayer/screens/splashscreen.dart';
// import 'melofinder.dart';
// import 'myfavorites.dart';
// import 'nowplaying.dart';

// class ScreenHome extends StatelessWidget {
//   const ScreenHome({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.grey,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text(
//             'Good evening',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           actions: [
//             MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: IconButton(
//                 color: Colors.black,
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const MelofinderScreen(),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.content_paste_search),
//               ),
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
//             // listView(),
//             Expanded(
//               child: ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: Image.asset(
//                               'assets/images/song1.jpg',
//                               width: 70,
//                               height: 70,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 14,
//                           ),
//                           Expanded(
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         const NowPlayingScreen(),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 height: 70,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                     color: Colors.grey),
//                                 child: ListTile(
//                                   title: Text(listOfSongs[index].name!,
//                                       maxLines: 1),
//                                   subtitle: Text(
//                                       listOfSongs[index].artist ?? 'unknown',
//                                       maxLines: 1),
//                                   trailing: PopupMenuButton<String>(
//                                     icon: const Icon(
//                                       Icons.more_vert,
//                                       size: 20,
//                                       color: Colors.black,
//                                     ),
//                                     itemBuilder: (BuildContext context) {
//                                       return <PopupMenuEntry<String>>[
//                                         const PopupMenuItem<String>(
//                                           value: 'favorites',
//                                           child: Text('Add to favorites'),
//                                         ),
//                                         const PopupMenuItem<String>(
//                                           value: 'playlist',
//                                           child: Text('Add to playlist'),
//                                         ),
//                                         // const PopupMenuItem<String>(
//                                         //   value: 'share',
//                                         //   child: Text('Share'),
//                                         // ),
//                                         // const PopupMenuItem<String>(
//                                         //   value: 'rename',
//                                         //   child: Text('Rename'),
//                                         // ),
//                                         // const PopupMenuItem<String>(
//                                         //   value: 'delete',
//                                         //   child: Text('Delete'),
//                                         // ),
//                                       ];
//                                     },
//                                     onSelected: (String value) {
//                                       if (value == 'favorites') {
//                                       } else if (value == 'playlist') {}
//                                       //else if (value == 'share') {
//                                       // } else if (value == 'rename') {}
//                                       //else if (value == 'delete')
//                                       // {}
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   itemCount: listOfSongs.length),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
