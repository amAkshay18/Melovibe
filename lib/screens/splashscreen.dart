import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import 'package:offlinemusicplayer/functions/favoritesfunctions.dart';
import 'package:offlinemusicplayer/screens/bottomnavigationscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shimmer/shimmer.dart';
import '../functions/fetchfunctions.dart';
import '../functions/recentlyplayedfunctions.dart';

List<AllSongModel> allSongs = [];

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 19, 4, 3),
              Color.fromARGB(255, 223, 11, 11),
              Color.fromARGB(255, 187, 116, 9),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 110),
                child: SizedBox(
                  height: 150,
                  child: ClipRRect(
                    child: Image(
                      image: AssetImage(
                        'assets/images/melovibelogo.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Shimmer.fromColors(
                period: const Duration(milliseconds: 850),
                baseColor:
                    const Color.fromARGB(255, 64, 0, 255).withOpacity(0.9),
                highlightColor: Colors.deepOrange,
                child: const Text(
                  'Melovibe',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initializeApp() async {
    bool hasStoragePermission = false;
    await Future.delayed(const Duration(seconds: 1));
    hasStoragePermission = await CheckPermission.checkAndRequestPermissions();
    if (hasStoragePermission) {
      // ============================================SongFetch===========================================
      List<SongModel> fetchSong = await audioQuery.querySongs();
      for (SongModel element in fetchSong) {
        if (element.fileExtension == 'mp3') {
          allSongs.add(AllSongModel(
              name: element.displayNameWOExt,
              artist: element.artist,
              duration: element.duration,
              id: element.id,
              uri: element.uri));
        }
      }
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomNaviScreen(),
        ),
      );
    }
    await recentfetch();
    await favfetch();
  }
}

class CheckPermission {
  static Future<bool> checkAndRequestPermissions({bool retry = false}) async {
    bool hasPermission = false;
    hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    return hasPermission;
  }
}

recentfetch() async {
  Box<int> recentDb = await Hive.openBox('recent');
  List<AllSongModel> recenttemp = [];
  for (int element in recentDb.values) {
    for (AllSongModel song in allSongs) {
      if (element == song.id) {
        recenttemp.add(song);
        break;
      }
    }
  }
  recentList.value = recenttemp.reversed.toList();
}
