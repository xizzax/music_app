import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/components/background_gradient.dart';
import 'package:music_app/components/create_playlist_button.dart';
import 'package:music_app/components/show_playlist.dart';
import 'package:music_app/state/state.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatefulWidget {
  final double height;
  final double width;
  const PlaylistPage({super.key, required this.width, required this.height});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();
    return Scaffold(
      body: Container(
        height: widget.height,
        width: widget.width,
        decoration: const BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: const Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 35.0),
                child: CreatePlaylistButton()),
            ShowAllPlaylists(),
          ],
        ),
      ),
    );
  }
}
