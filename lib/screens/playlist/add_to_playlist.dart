import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import 'package:offlinemusicplayer/functions/playlist.dart';
import 'package:offlinemusicplayer/shared/widgets/mini_player.dart';

class AddToPlaylistsScreen extends StatefulWidget {
  final AllSongModel music;
  const AddToPlaylistsScreen({Key? key, required this.music}) : super(key: key);

  @override
  State<AddToPlaylistsScreen> createState() => _AddToPlaylistsScreenState();
}

class _AddToPlaylistsScreenState extends State<AddToPlaylistsScreen> {
  final TextEditingController _playlistNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      retrieveAllPlaylists();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'Add To Playlist',
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
          valueListenable: playlistnotifier,
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'Create Playlist',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Form(
                                  child: TextFormField(
                                    controller: _playlistNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Playlist name',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1),
                                      ),
                                    ),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      String playlistname =
                                          _playlistNameController.text;
                                      if (playlistname.isNotEmpty) {
                                        createNewPlaylist(
                                            _playlistNameController.text);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text(
                                      'Create',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Create Playlist',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // Call addSongToPlaylist function when playlist is tapped
                                  addSongToPlaylistAndShowSnackbar(widget.music,
                                      value[index].playListName!, context);
                                },
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey,
                                  ),
                                  child: ListTile(
                                    title: SizedBox(
                                      height: 20,
                                      child: Text(
                                        value[index].playListName ?? 'name',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: value.length,
                  ),
                ],
              ),
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
        bottomSheet: const MiniPlayer(),
      ),
    );
  }
}
