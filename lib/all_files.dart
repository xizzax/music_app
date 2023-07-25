import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:music_app/components/show_songs.dart';
import 'package:music_app/state/state.dart';
import 'package:provider/provider.dart';
import 'components/background_gradient.dart';

class AllFiles extends StatefulWidget {
  final double width;
  final double height;
  const AllFiles({super.key, required this.width, required this.height});

  @override
  State<AllFiles> createState() => _AllFilesState();
}

class _AllFilesState extends State<AllFiles> {
  // //defining an onAudio plugin
  // final OnAudioQuery _audioQuery = OnAudioQuery();
  // //defining the player
  // final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      requestStoragePermission();
    });
  }

//disposing the player once we're
  @override
  void dispose() {
    // Future.delayed(Duration.zero, () {
    //   Provider.of(context, listen: false).audioPlayer.dispose();
    // });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();

    return Scaffold(
      body: Container(
        width: widget.width,
        decoration: const BoxDecoration(gradient: backgroundGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: widget.height * 0.05,
            ),
            Center(
              child: Container(
                width: widget.height * 0.3,
                height: widget.height * 0.3,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(222, 219, 249, 0.2),
                      Color.fromRGBO(210, 222, 253, 0.2),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          color: Color.fromRGBO(191, 202, 228, 1),
                          offset: Offset(10, 10),
                          inset: true),
                      BoxShadow(
                          blurRadius: 20,
                          color: Color.fromRGBO(226, 233, 255, 1),
                          offset: Offset(-10, -10),
                          inset: true)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.asset("lib/assets/first_page.png",
                      fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(
              height: widget.height * 0.06,
              child: Padding(
                padding: EdgeInsets.only(
                    left: widget.height * 0.02, top: widget.height * 0.02),
                child: Text(
                  "Device Files",
                  style: TextStyle(
                    color: Color.fromRGBO(59, 79, 125, 1),
                    fontFamily: 'SfProDisplay',
                    fontSize: widget.height * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
              height: widget.height * 0.5,
              child: ShowSongs(
                // audioQuery: state.audioQuery,
                totalHeight: widget.height,
                // audioPlayer: state.audioPlayer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus =
          await Provider.of<MusicPlayer>(context, listen: false)
              .audioQuery
              .permissionsStatus();
      if (!permissionStatus) {
        await Provider.of<MusicPlayer>(context, listen: false)
            .audioQuery
            .permissionsRequest();
      }
      // to ensure the build method is called
      setState(() {});
    }
  }
}
