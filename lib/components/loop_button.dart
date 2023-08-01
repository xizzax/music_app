import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/state/state.dart';
import 'package:provider/provider.dart';

class LoopBtn extends StatefulWidget {
  const LoopBtn({super.key});

  @override
  State<LoopBtn> createState() => _LoopBtnState();
}

class _LoopBtnState extends State<LoopBtn> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();

    return GestureDetector(
      child: Container(
        height: 50,
        width: 50,
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
          Icons.loop_rounded,
          color: Color(0xff3b4f7d),
        ),
      ),
      onTap: () async {
        if (state.audioPlayer.loopMode == LoopMode.all) {
          await state.audioPlayer.setLoopMode(LoopMode.off);
          setState(() {
            _isPressed = false;
          });
        } else {
          await state.audioPlayer.setLoopMode(LoopMode.all);

          setState(() {
            _isPressed = true;
          });
        }
      },
    );
  }
}
