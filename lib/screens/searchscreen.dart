import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/screens/splashscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'nowplayingscreen.dart';

class SearchScreeen extends StatelessWidget {
  const SearchScreeen({super.key});

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
            'Search',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 214, 210, 210),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                                  id: allSongs[index].id!,
                                  type: ArtworkType.AUDIO),
                            ),
                            const SizedBox(
                              width: 8,
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
                                    title: Text(allSongs[index].name!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1),
                                    subtitle: Text(
                                        allSongs[index].artist ?? 'unknown',
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
                                          const PopupMenuItem<String>(
                                            value: 'favorites',
                                            child: Text('Add to favorites'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'playlist',
                                            child: Text('Add to playlist'),
                                          ),
                                        ];
                                      },
                                      onSelected: (String value) {
                                        if (value == 'favorites') {
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
                    itemCount: allSongs.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
