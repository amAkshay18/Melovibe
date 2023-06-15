// import 'package:flutter/material.dart';
// import '../screens/nowplaying.dart';

// Widget listView(String title) {
//   return Expanded(
//     child: ListView.builder(
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Image.asset(
//                     'assets/images/song1.jpg',
//                     width: 70,
//                     height: 70,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 14,
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const NowPlayingScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       height: 70,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Colors.grey),
//                       child: ListTile(
//                         title: Text('$title${index + 1}'),
//                         trailing: PopupMenuButton<String>(
//                           icon: const Icon(
//                             Icons.more_vert,
//                             size: 20,
//                             color: Colors.black,
//                           ),
//                           itemBuilder: (BuildContext context) {
//                             return <PopupMenuEntry<String>>[
//                               const PopupMenuItem<String>(
//                                 value: 'favorites',
//                                 child: Text('Add to favorites'),
//                               ),
//                               const PopupMenuItem<String>(
//                                 value: 'playlist',
//                                 child: Text('Add to playlist'),
//                               ),
//                               const PopupMenuItem<String>(
//                                 value: 'share',
//                                 child: Text('Share'),
//                               ),
//                               const PopupMenuItem<String>(
//                                 value: 'rename',
//                                 child: Text('Rename'),
//                               ),
//                               // const PopupMenuItem<String>(
//                               //   value: 'delete',
//                               //   child: Text('Delete'),
//                               // ),
//                             ];
//                           },
//                           onSelected: (String value) {
//                             if (value == 'favorites') {
//                             } else if (value == 'playlist') {
//                             } else if (value == 'share') {
//                             } else if (value == 'rename') {}
//                             //else if (value == 'delete')
//                             {}
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//         itemCount: 10),
//   );
// }
import 'package:flutter/material.dart';
import '../screens/nowplaying.dart';
import '../screens/splashscreen.dart';

Widget listView() {
  return Expanded(
    child: ListView.builder(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NowPlayingScreen(),
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
                          listOfSongs[index].name!,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          listOfSongs[index].artist ?? 'unknown',
                          overflow: TextOverflow.ellipsis,
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
                              const PopupMenuItem<String>(
                                value: 'playlist',
                                child: Text('Add to playlist'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'share',
                                child: Text('Share'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'rename',
                                child: Text('Rename'),
                              ),
                              // const PopupMenuItem<String>(
                              //   value: 'delete',
                              //   child: Text('Delete'),
                              // ),
                            ];
                          },
                          onSelected: (String value) {
                            if (value == 'favorites') {
                            } else if (value == 'playlist') {
                            } else if (value == 'share') {
                            } else if (value == 'rename') {}
                            //else if (value == 'delete')
                            {}
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
        itemCount: listOfSongs.length),
  );
}
