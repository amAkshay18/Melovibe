import 'package:flutter/material.dart';
import 'package:offlinemusicplayer/database/model/song_model.dart';
import '../functions/playlistfunctions.dart';

class AddToPlaylistsScreen extends StatefulWidget {
  final AllSongModel music;
  AddToPlaylistsScreen({Key? key, required this.music}) : super(key: key);

  @override
  State<AddToPlaylistsScreen> createState() => _AddToPlaylistsScreenState();
}

class _AddToPlaylistsScreenState extends State<AddToPlaylistsScreen> {
  final TextEditingController _playlistNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      getPlaylist();
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
          // actions: [
          //   IconButton(
          //     color: Colors.black,
          //     onPressed: () {
          //       showDialog(
          //         context: context,
          //         builder: (context) {
          //           return Form(
          //             child: AlertDialog(
          //               title: const Text('Create Playlist'),
          //               content: TextFormField(
          //                 controller: _playlistNameController,
          //               ),
          //               actions: [
          //                 TextButton(
          //                   onPressed: () {
          //                     Navigator.pop(context);
          //                   },
          //                   child: const Text(
          //                     'Cancel',
          //                     style: TextStyle(color: Colors.black),
          //                   ),
          //                 ),
          //                 TextButton(
          //                   onPressed: () {
          //                     String playlistname =
          //                         _playlistNameController.text;
          //                     if (playlistname.isNotEmpty) {
          //                       createPlaylist(_playlistNameController.text);
          //                       Navigator.pop(context);
          //                     }
          //                   },
          //                   child: const Text(
          //                     'Add',
          //                     style: TextStyle(color: Colors.black),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           );
          //         },
          //       );
          //     },
          //     icon: const Icon(Icons.add),
          //   ),
          // ],
        ),
        body: ValueListenableBuilder(
          valueListenable: playlistnotifier,
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
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
                                return Form(
                                  child: AlertDialog(
                                    title: const Text('Create Playlist'),
                                    content: TextFormField(
                                      controller: _playlistNameController,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'cancel',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          String playlistname =
                                              _playlistNameController.text;
                                          if (playlistname.isNotEmpty) {
                                            createPlaylist(
                                                _playlistNameController.text);
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text(
                                          'add',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         SinglePlayListScreen(
                                    //             playlistname:
                                    //                 value[index].playlistName ??
                                    //                     'name'),
                                    //   ),
                                    // );
                                    addSongToPlaylist(widget.music,
                                        value[index].playlistName!, context);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey),
                                    child: ListTile(
                                      title: SizedBox(
                                        height: 20,
                                        child: Text(
                                          value[index].playlistName ?? 'name',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
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
                      itemCount: value.length)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // void editPlaylist(int index) {
  //   TextEditingController editplaylistcontroller = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Edit Playlist'),
  //         content: TextField(
  //           controller: _editplaylistcontroller,
  //           decoration: const InputDecoration(labelText: 'Playlist Name'),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 String newName = _editplaylistcontroller.text;

  //                 if (newName.isNotEmpty) {
  //                   playlistRename(index, newName);
  //                 }
  //                 Navigator.of(context).pop();
  //               });
  //             },
  //             child: const Text('Save'),
  //           ),
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Cancel'))
  //         ],
  //       );
  //     },
  //   );
  // }
}
