// import 'package:flutter/material.dart';
// import '../screens/singleplaylistscreen.dart';

// // ignore: non_constant_identifier_names
// Widget PlaylistView(String title) {
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
//                     'assets/images/dummySong.jpg',
//                     width: 60,
//                     height: 60,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SinglePlayListScreen(
//                             playlistname: '$title${index + 1}',
//                             idx: index,
//                             listIndex: ,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       height: 60,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Colors.grey),
//                       child: ListTile(
//                         title: Text(
//                           '$title${index + 1}',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         trailing: PopupMenuButton<String>(
//                           icon: const Icon(
//                             Icons.more_vert,
//                             size: 20,
//                             color: Colors.black,
//                           ),
//                           itemBuilder: (BuildContext context) {
//                             return <PopupMenuEntry<String>>[
//                               // const PopupMenuItem<String>(
//                               //   value: 'add_playlist',
//                               //   child: Text('Add to playlist'),
//                               // ),
//                               const PopupMenuItem<String>(
//                                 value: 'rename',
//                                 child: Text('Rename'),
//                               ),
//                               const PopupMenuItem<String>(
//                                 value: 'delete',
//                                 child: Text('Delete'),
//                               ),
//                             ];
//                           },
//                           onSelected: (String value) {
//                             //if (value == 'add_playlist') {}else

//                             if (value == 'rename') {
//                             } else if (value == 'delete') {}
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
