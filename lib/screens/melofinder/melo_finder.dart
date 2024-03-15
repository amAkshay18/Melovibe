import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';

class MelofinderScreen extends StatefulWidget {
  const MelofinderScreen({super.key});

  @override
  State<MelofinderScreen> createState() => _MelofinderScreenState();
}

class _MelofinderScreenState extends State<MelofinderScreen> {
  @override
  void initState() {
    ACRCloud.setUp(
      const ACRCloudConfig(
          '064c6e57ef7413d91d92efb7426f06a8',
          'KDf722QjIVyNajjdtaAmevorH9eRlh4rfw4rqNfu',
          'identify-ap-southeast-1.acrcloud.com'),
    );
    super.initState();
  }

  ACRCloudResponseMusicItem? music;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        children: [
          Padding(
            padding: const EdgeInsets.all(22),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    music = null;
                  });
                  final session = ACRCloud.startSession();
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      title: const Text('finding song...'),
                      content: StreamBuilder(
                        stream: session.volumeStream,
                        initialData: 0,
                        builder: (_, snapshot) =>
                            Text(snapshot.data.toString()),
                      ),
                      actions: [
                        TextButton(
                          onPressed: session.cancel,
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  );
                  final result = await session.result;
                  Navigator.pop(context);
                  if (result == null) {
                    return;
                  } else if (result.metadata == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No result found.'),
                      ),
                    );
                    return;
                  }
                  setState(() {
                    music = result.metadata!.music.first;
                  });
                },
                child: AvatarGlow(
                  glowColor: Colors.blue,
                  endRadius: 130.0,
                  duration: const Duration(seconds: 2),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  child: Material(
                    elevation: 15.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage(
                        'assets/images/melovibelogo.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          (music?.title == null)
              ? const Text('Tap the Melofinder')
              : Text(
                  music!.title,
                  style: const TextStyle(fontSize: 18),
                )
        ],
      ),
    );
  }
}
