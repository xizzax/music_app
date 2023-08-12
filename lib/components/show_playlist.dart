import 'dart:io';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:music_app/state/state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'background_gradient.dart';

class ShowAllPlaylists extends StatefulWidget {
  const ShowAllPlaylists({super.key});

  @override
  State<ShowAllPlaylists> createState() => _ShowAllPlaylistsState();
}

class _ShowAllPlaylistsState extends State<ShowAllPlaylists> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();
    final double totalHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<List<PlaylistModel>>(
        future: state.audioQuery.queryPlaylists(
          sortType: PlaylistSortType.DATE_ADDED,
          orderType: OrderType.ASC_OR_SMALLER,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(50.0),
              child: Center(
                child: Text("No Playlists Found"),
              ),
            );
          }
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: item.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: InkWell(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      elevation: 15,
                                      shadowColor: const Color.fromRGBO(
                                          191, 202, 228, 1),
                                      child: InkWell(
                                        onTap: () {
                                          state.audioQuery.removePlaylist(
                                              item.data![index].id);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              gradient: backgroundGradient,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20,
                                                  bottom: 20,
                                                  left: 10,
                                                  right: 10),
                                              child: Text(
                                                "Delete Playlist",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      59, 79, 125, 1),
                                                  fontFamily: 'SfProDisplay',
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )),
                                      ),
                                    );
                                  });
                            },
                            onTap: () async {
                              state.audioPlayer.dispose();

                              String path = item.data![index].getMap["_data"];
                              final file = await File(path).readAsString();
                              // print(file);
                              final List<M3uGenericEntry> playlist =
                                  await parseFile(file);
                              // print(playlist);

                              //     .then((value) {
                              //   print(value);
                              //   // state.audioPlayer.setAudioSource(
                              //   //     state.createPlaylist(value),
                              //   //     initialIndex: 0);
                              //   // state.play(value[0], 0);
                              // });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color.fromRGBO(191, 202, 228, 1),
                                        offset: Offset(2, 2),
                                        inset: true,
                                      ),
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color.fromRGBO(226, 233, 255, 1),
                                        offset: Offset(-2, -2),
                                        inset: true,
                                      )
                                    ],
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            191, 202, 228, 0.75))),
                                child: ListTile(
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
                                  contentPadding: EdgeInsets.only(
                                      left: totalHeight * 0.02,
                                      right: totalHeight * 0.02),
                                  leading: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 1,
                                          color:
                                              Color.fromRGBO(191, 202, 228, 1),
                                          offset: Offset(2, 2),
                                        ),
                                        BoxShadow(
                                          blurRadius: 1,
                                          color:
                                              Color.fromRGBO(226, 233, 255, 1),
                                          offset: Offset(-2, -2),
                                        )
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.play_arrow,
                                      size: 25,
                                      color: Color.fromRGBO(59, 79, 125, 1),
                                    ),
                                  ),
                                  title: Text(
                                    item.data![index].playlist,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(59, 79, 125, 1),
                                      fontFamily: 'SfProDisplay',
                                      fontSize: 15,
                                    ),
                                  ),
                                )),
                          ),
                        )));
              });
        });
  }
}
