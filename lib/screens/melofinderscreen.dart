import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class MelofinderScreen extends StatefulWidget {
  const MelofinderScreen({super.key, Key? keys});

  @override
  State<MelofinderScreen> createState() => _MelofinderScreenState();
}

class _MelofinderScreenState extends State<MelofinderScreen> {
  @override
  void initState() {
    super.initState();
  }

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
            'Melofinder',
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tap to MeloFind',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: AvatarGlow(
                glowColor: Colors.black,
                endRadius: 80.0,
                duration: const Duration(seconds: 2),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 60.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 190,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.content_paste_search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(14)),
              width: 250,
              height: 90,
              child: const Center(
                  child: Text(
                'Song1',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }
}
