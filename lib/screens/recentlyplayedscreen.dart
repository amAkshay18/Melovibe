import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/functions/recentlyplayedfunctions.dart';
import 'package:offlinemusicplayer/screens/nowplayingscreen.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';

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
                  return recentList.value.isEmpty
                      ? const Center(
                          child: Text('No favorite songs available'),
                        )
                      : ListView.builder(
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
                                        audioConverter(recentList.value, index);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NowPlayingScreen(
                                              music: recentList.value[index],
                                            ),
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
                                                const PopupMenuItem<String>(
                                                  value: 'playlist',
                                                  child:
                                                      Text('Add to playlist'),
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
