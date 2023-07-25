import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/state/state.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({super.key});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();
    return Container(
      height: 80,
      width: 80,
      child: GestureDetector(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(126, 139, 238, 1),
                      Color.fromRGBO(94, 111, 228, 1),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              ),
            ),
            Positioned(
              left: 5,
              top: 5,
              child: Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(81, 99, 224, 1),
                        Color.fromRGBO(136, 147, 240, 1),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: Center(
                      child: state.playing
                          ? const Icon(
                              Icons.pause,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ))),
            ),
          ],
        ),
        onTap: () {
          state.changePlaying();
        },
      ),
    );
  }
}

class PreviousButton extends StatefulWidget {
  const PreviousButton({super.key});

  @override
  State<PreviousButton> createState() => _PreviousButtonState();
}

class _PreviousButtonState extends State<PreviousButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();

    return GestureDetector(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: Color(0xffe6e7fd),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xFFD0D2F2),
                blurRadius: 8,
                offset: Offset(4, 4),
                spreadRadius: 0,
                inset: _isPressed,
              ),
              BoxShadow(
                color: Color(0xFFF6F9FF),
                blurRadius: 8,
                offset: Offset(-4, -4),
                spreadRadius: 0,
                inset: _isPressed,
              )
            ]),
        child: const Icon(
          Icons.skip_previous,
          color: Color(0xff3b4f7d),
        ),
      ),
      onTap: () async {
        setState(() {
          _isPressed = true;
        });
        Fluttertoast.showToast(msg: "previous");
        // state.audioPlayer.previousIndex;
        state.audioPlayer.seekToPrevious();
        await Future.delayed(Duration(milliseconds: 75));
        setState(() {
          _isPressed = false;
        });
      },
    );
  }
}

class NextButton extends StatefulWidget {
  const NextButton({super.key});

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();

    return GestureDetector(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: Color(0xffe6e7fd),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xFFD0D2F2),
                blurRadius: 8,
                offset: Offset(4, 4),
                spreadRadius: 0,
                inset: _isPressed,
              ),
              BoxShadow(
                color: Color(0xFFF6F9FF),
                blurRadius: 8,
                offset: Offset(-4, -4),
                spreadRadius: 0,
                inset: _isPressed,
              )
            ]),
        child: const Icon(
          Icons.skip_next,
          color: Color(0xff3b4f7d),
        ),
      ),
      onTap: () async {
        setState(() {
          _isPressed = true;
        });
        Fluttertoast.showToast(msg: "next");
        Fluttertoast.showToast(msg: state.audioPlayer.nextIndex.toString());
        state.audioPlayer.seekToNext();
        await Future.delayed(Duration(milliseconds: 75));
        setState(() {
          _isPressed = false;
        });
      },
    );
  }
}
