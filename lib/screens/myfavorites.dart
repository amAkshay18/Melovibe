import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';

import 'nowplaying.dart';

class MyFavoritesScreen extends StatelessWidget {
  const MyFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'My favorites',
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
                                  title: Text(
                                    listOfSongs[index].name!,
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                      listOfSongs[index].artist ?? 'unknown',
                                      maxLines: 1),
                                  trailing: PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.favorite,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        const PopupMenuItem<String>(
                                          value: 'favorites',
                                          child: Text('Remove from favorites'),
                                        ),
                                        // const PopupMenuItem<String>(
                                        //   value: 'playlist',
                                        //   child: Text('Add to playlist'),
                                        // ),
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
                  itemCount: listOfSongs.length),
            ),
            // listView()
          ],
        ),
      ),
    );
  }
}
