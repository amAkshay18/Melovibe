import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/functions/audioconverterfunctions.dart';
import 'package:offlinemusicplayer/functions/favoritesfunctions.dart';
import 'nowplayingscreen.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({super.key});

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
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
            ),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: fav,
          builder: (context, value, child) {
            return Row(
              children: [
                Expanded(
                  child: fav.value.isEmpty
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
                                    width: 14,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        audioConverter(fav.value, index);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NowPlayingScreen(
                                                    music: fav.value[index]),
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
                                            fav.value[index].name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                          ),
                                          subtitle: Text(
                                              fav.value[index].artist ??
                                                  'unknown',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1),
                                          trailing: PopupMenuButton<String>(
                                            icon: const Icon(
                                              Icons.favorite,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                            itemBuilder:
                                                (BuildContext context) {
                                              return <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                  value: 'favorites',
                                                  child: Text(
                                                      'Remove from favorites'),
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
                                                removeFromFav(
                                                    fav.value[index].id!);
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
                          itemCount: fav.value.length),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
