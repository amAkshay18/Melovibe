import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/DataBase/Model/songdetails.dart';
import 'package:offlinemusicplayer/functions/splashfunctions.dart';

import '../functions/fetchfunctions.dart';

List<SongDetails> listOfSongs = [];

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    SongFetch fetch = SongFetch();
    fetch.fetching();
    start(context);
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
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: const Column(
            children: [
              Padding(
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
              Text('Melovibe',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
