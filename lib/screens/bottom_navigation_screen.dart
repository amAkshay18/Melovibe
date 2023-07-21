import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/screens/playlist/playlist_screen.dart';
import 'package:offlinemusicplayer/screens/search_screen.dart';
import 'home_screen.dart';
import 'mini_player.dart';

final ValueNotifier<int> _currentIndex = ValueNotifier(0);

class BottomNaviScreen extends StatelessWidget {
  BottomNaviScreen({super.key});

  final screen = [
    const ScreenHome(),
    const SearchScreen(),
    const PlaylistScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, updatedIndex, child) {
            return screen[updatedIndex];
          },
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (BuildContext context, int updatedindex, child) {
            return BottomNavigationBar(
              selectedItemColor: Colors.black54,
              unselectedItemColor: Colors.black,
              currentIndex: updatedindex,
              backgroundColor: Colors.grey,
              onTap: (index) {
                _currentIndex.value = index;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 28,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      size: 28,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.playlist_add,
                      size: 28,
                    ),
                    label: ''),
              ],
            );
          },
        ),
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}
