import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({Key? key}) : super(key: key);

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  String selectedChoice = 'Music';

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Now Playing',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
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
          actions: [
            IconButton(
              color: Colors.black,
              onPressed: () {},
              icon: const Icon(Icons.playlist_add),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          ChoiceChip(
                            label: const Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Text('Music'),
                            ),
                            selected: selectedChoice == 'Music',
                            onSelected: (isSelected) {
                              setState(
                                () {
                                  selectedChoice = 'Music';
                                },
                              );
                            },
                            labelStyle: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 8),
                          ChoiceChip(
                            label: const Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Text('Lyrics'),
                            ),
                            selected: selectedChoice == 'Lyrics',
                            onSelected: (isSelected) {
                              setState(
                                () {
                                  selectedChoice = 'Lyrics';
                                },
                              );
                            },
                            labelStyle: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.replay_10))),
                  // const SizedBox(
                  //   width: 6,
                  // ),
                  Container(
                    width: 250,
                    height: 250,
                    color: Colors.blue,
                    child: Image.asset(
                      'assets/images/Nowplaying.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // const SizedBox(
                  //   width: 6,
                  // ),
                  Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.forward_10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.lock_open),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Song1',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '1X',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  ProgressBar(
                    progress: const Duration(seconds: 70),
                    // buffered: const Duration(seconds: 2000),
                    total: const Duration(seconds: 280),
                    onSeek: (duration) {},
                    progressBarColor: const Color.fromARGB(255, 118, 117, 117),
                    baseBarColor: const Color.fromARGB(255, 205, 199, 199),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shuffle,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.play_arrow,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_next,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.repeat,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
