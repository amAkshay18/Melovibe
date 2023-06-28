import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/functions/playlistfunctions.dart';
import 'package:offlinemusicplayer/screens/singleplaylistscreen.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    setState(() {
      getPlaylist();
    });
    // TODO: implement initState
    super.initState();
  }

  // ignore: prefer_final_fields
  TextEditingController _playlistEditingController = TextEditingController();
  _showAddPlaylist() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Playlist'),
          content: TextFormField(
            controller: _playlistEditingController,
            decoration: const InputDecoration(labelText: 'Playlist Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                String addPlaylistName = _playlistEditingController.text;
                if (addPlaylistName.isNotEmpty) {
                  createPlaylist(
                    _playlistEditingController.text,
                  );
                }

                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _editPlaylist(int index) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _editplaylistcontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Playlist'),
          content: TextField(
            controller: _editplaylistcontroller,
            decoration: const InputDecoration(labelText: 'Playlist Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                String newName = _editplaylistcontroller.text;

                if (newName.isNotEmpty) {
                  renamePlaylist(index, newName);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'))
          ],
        );
      },
    );
  }

  void deletePlaylist1(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you Sure you want to delete this playlist'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  deletePlaylist(index);
                });

                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getPlaylist();
    return ValueListenableBuilder(
      valueListenable: playlistnotifier,
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            backgroundColor: Colors.grey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            title: const Text(
              'Playlists',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon: const Icon(
            //     Icons.arrow_back,
            //     size: 28,
            //     color: Colors.black,
            //   ),
            // ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder(
              valueListenable: playlistnotifier,
              builder: (context, value, child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey),
                        height: 70,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SinglePlayListScreen(
                                    playlistname: value[index].playlistName!,
                                    listIndex: playlistnotifier.value[index],
                                    idx: index),
                              ),
                            );
                          },
                          child: ListTile(
                            // leading: const Padding(
                            //   padding: EdgeInsets.only(top: 9.0),
                            //   child: Icon(
                            //     Icons.playlist_play_rounded,
                            //     size: 45,
                            //   ),
                            // ),
                            title: Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Text(
                                playlistnotifier.value[index].playlistName ??
                                    "playlist name",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _editPlaylist(index);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deletePlaylist1(context, index);
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16.0);
                    },
                    itemCount: playlistnotifier.value.length);
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey,
            child: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              _showAddPlaylist();
            },
          ),
        );
      },
    );
  }
}
