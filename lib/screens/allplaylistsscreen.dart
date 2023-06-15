import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/widgets/playlistview.dart';

class AllPlaylistScreen extends StatelessWidget {
  const AllPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'PlayLists',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Row(
          children: [
            PlaylistView('Playlist'),
          ],
        ),
      ),
    );
  }
}
