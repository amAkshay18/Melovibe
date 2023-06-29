import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/functions/recentlyplayedfunctions.dart';
import 'package:offlinemusicplayer/screens/nowplayingscreen.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../functions/audioconverterfunctions.dart';
import '../functions/favoritesfunctions.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({super.key});

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
            'Recently Played',
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
            ),
          ),
        ),
        body: Row(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: recentList,
                builder: (context, value, child) {
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
                                    id: recentList.value[index].id!,
                                    type: ArtworkType.AUDIO),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    audioConverter(recentList.value, index);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NowPlayingScreen(
                                          music: recentList.value[index],
                                        ),
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
                                      title: Text(
                                        recentList.value[index].name!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                      ),
                                      subtitle: Text(
                                          recentList.value[index].artist ??
                                              'unknown',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1),
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
                                                  : const Text(
                                                      'Add to favorites'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'playlist',
                                              child: Text('Add to playlist'),
                                            ),
                                          ];
                                        },
                                        onSelected: (String value) {
                                          if (value == 'favorites') {
                                            fav.value.contains(allSongs[index])
                                                ? removeFromFav(
                                                    allSongs[index].id!)
                                                : addToFav(allSongs[index].id!);
                                          } else if (value == 'playlist') {}
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
                      itemCount: recentList.value.length);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//------------------------------------------------------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:offlinemusicplayer/functions/recentlyplayedfunctions.dart';
// import 'package:offlinemusicplayer/screens/nowplayingscreen.dart';
// import 'package:offlinemusicplayer/screens/splashscreen.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import '../functions/audioconverterfunctions.dart';
// import '../functions/favoritesfunctions.dart';
// import 'addtoplaylistscreen.dart';

// class RecentlyPlayedScreen extends StatelessWidget {
//   const RecentlyPlayedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.grey,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(16),
//             ),
//           ),
//           title: const Text(
//             'Recently Played',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               size: 28,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         body: Row(
//           children: [
//             Expanded(
//               child: ValueListenableBuilder(
//                 valueListenable: recentList,
//                 builder: (context, value, child) {
//                   return recentList.value.isEmpty
//                       ? const Center(
//                           child: Text('No favorite songs available'),
//                         )
//                       : ListView.builder(
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(16),
//                                     child: QueryArtworkWidget(
//                                         artworkClipBehavior: Clip.none,
//                                         artworkHeight: 70,
//                                         artworkWidth: 70,
//                                         nullArtworkWidget: Image.asset(
//                                           'assets/images/dummySong.jpg',
//                                           fit: BoxFit.cover,
//                                           width: 70,
//                                           height: 70,
//                                         ),
//                                         id: recentList.value[index].id!,
//                                         type: ArtworkType.AUDIO),
//                                   ),
//                                   const SizedBox(
//                                     width: 8,
//                                   ),
//                                   Expanded(
//                                     child: InkWell(
//                                       onTap: () {
//                                         audioConverter(recentList.value, index);
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 NowPlayingScreen(
//                                               music: recentList.value[index],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       child: Container(
//                                         height: 70,
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             color: Colors.grey),
//                                         child: ListTile(
//                                           title: Text(
//                                             recentList.value[index].name!,
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold),
//                                             maxLines: 1,
//                                           ),
//                                           subtitle: Text(
//                                               recentList.value[index].artist ??
//                                                   'unknown',
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.bold),
//                                               maxLines: 1),
//                                           trailing: PopupMenuButton(
//                                             icon: const Icon(
//                                               Icons.more_vert,
//                                               size: 20,
//                                               color: Colors.black,
//                                             ),
//                                             itemBuilder:
//                                                 (BuildContext context) {
//                                               return [
//                                                 PopupMenuItem(
//                                                   value: 'favorites',
//                                                   child: fav.value.contains(
//                                                           allSongs[index])
//                                                       ? const Text(
//                                                           'Remove from favorites')
//                                                       : const Text(
//                                                           'Add to favorites'),
//                                                 ),
//                                                 const PopupMenuItem(
//                                                   value: 'playlist',
//                                                   child:
//                                                       Text('Add to playlist'),
//                                                 ),
//                                               ];
//                                             },
//                                             onSelected: (String value) {
//                                               if (value == 'favorites') {
//                                                 if (fav.value.contains(
//                                                     allSongs[index])) {
//                                                   showDialog(
//                                                     context: context,
//                                                     builder:
//                                                         (BuildContext context) {
//                                                       return AlertDialog(
//                                                         title: const Text(
//                                                             'Confirmation'),
//                                                         content: const Text(
//                                                             'Are you sure you want to remove the song from favorites?'),
//                                                         actions: [
//                                                           TextButton(
//                                                             onPressed: () {
//                                                               Navigator.of(
//                                                                       context)
//                                                                   .pop();
//                                                             },
//                                                             child: const Text(
//                                                                 'Cancel'),
//                                                           ),
//                                                           TextButton(
//                                                             onPressed: () {
//                                                               removeFromFav(
//                                                                   allSongs[
//                                                                           index]
//                                                                       .id!);
//                                                               Navigator.of(
//                                                                       context)
//                                                                   .pop();
//                                                               ScaffoldMessenger
//                                                                       .of(context)
//                                                                   .showSnackBar(
//                                                                 const SnackBar(
//                                                                   content: Text(
//                                                                     'Song is removed from favorites successfully',
//                                                                   ),
//                                                                   backgroundColor:
//                                                                       Colors
//                                                                           .red,
//                                                                 ),
//                                                               );
//                                                             },
//                                                             child: const Text(
//                                                                 'Remove'),
//                                                           ),
//                                                         ],
//                                                       );
//                                                     },
//                                                   );
//                                                 } else {
//                                                   addToFav(allSongs[index].id!);
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(
//                                                     const SnackBar(
//                                                       content: Text(
//                                                         'Song added to favorites successfully',
//                                                       ),
//                                                       backgroundColor:
//                                                           Colors.green,
//                                                     ),
//                                                   );
//                                                 }
//                                               } else if (value == 'playlist') {
//                                                 Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         AddToPlaylistsScreen(
//                                                       music: allSongs[index],
//                                                     ),
//                                                   ),
//                                                 );
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                           itemCount: recentList.value.length);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
