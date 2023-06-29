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
    super.initState();
  }

  // ignore: prefer_final_fields
  TextEditingController _playlistEditingController = TextEditingController();
  // ignore: unused_element
  _showAddPlaylist() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Playlist'),
          content: TextFormField(
            controller: _playlistEditingController,
            decoration: const InputDecoration(labelText: 'playlist name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                String addPlaylistName = _playlistEditingController.text;
                if (addPlaylistName.isNotEmpty) {
                  bool iscreated = createPlaylist(
                    _playlistEditingController.text,
                  );
                  if (!iscreated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('name already exist'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
                Navigator.of(context).pop();
              },
              child: const Text('create'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('cancel'),
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
          title: const Text(
            'Rename Playlist',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: _editplaylistcontroller,
            decoration: const InputDecoration(
              labelText: 'Playlist Name',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
            ),
            style: const TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                String newName = _editplaylistcontroller.text;

                if (newName.isNotEmpty) {
                  renamePlaylist(index, newName);
                }
                Navigator.of(context).pop();
              },
              child: const Text(
                'Rename',
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
  }

  void deletePlaylist1(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure you want to delete this playlist?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                setState(() {
                  deletePlaylist(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            actions: [
              IconButton(
                onPressed: () {
                  _showAddPlaylist();
                },
                icon: const Icon(Icons.add),
                color: Colors.black,
                iconSize: 28,
              )
            ],
          ),
          body: ValueListenableBuilder(
            valueListenable: playlistnotifier,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: playlistnotifier.value.isEmpty
                          ? const Center(
                              child: Text('No playlists available'),
                            )
                          : ListView.separated(
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
                                          builder: (context) =>
                                              SinglePlayListScreen(
                                                  playlistname: value[index]
                                                      .playListName!,
                                                  listIndex: playlistnotifier
                                                      .value[index],
                                                  idx: index),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
                                        child: Text(
                                          playlistnotifier
                                                  .value[index].playListName ??
                                              "playlist name",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      trailing: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
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
                                return const SizedBox(height: 8.0);
                              },
                              itemCount: playlistnotifier.value.length),
                    )
                  ],
                ),
              );
            },
          ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: Colors.grey,
          //   child: const Icon(Icons.add, color: Colors.black),
          //   onPressed: () {
          //     _showAddPlaylist();
          //   },
          // ),
        );
      },
    );
  }
}
