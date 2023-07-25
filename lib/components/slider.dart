import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_app/state/state.dart';
import 'package:provider/provider.dart';

class SliderBar extends StatefulWidget {
  const SliderBar({super.key});

  @override
  State<SliderBar> createState() => _SliderBarState();
}

class _SliderBarState extends State<SliderBar> {
  bool placeholder = true;
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();
    // return const Placeholder();
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: StreamBuilder<DurationState>(
          stream: state.durationStateStream,
          builder: (context, snapshot) {
            final durationState = snapshot.data;
            final progress = durationState?.position ?? Duration.zero;
            final total = durationState?.total ?? Duration.zero;

            return ProgressBar(
              progress: progress,
              total: total,
              barHeight: 10,
              thumbRadius: 6,
              baseBarColor: const Color(0xffe6e7fd),
              progressBarColor: const Color.fromRGBO(126, 139, 238, 1),
              thumbColor: const Color.fromRGBO(126, 139, 238, 1),
              timeLabelTextStyle: const TextStyle(
                fontSize: 10,
                color: Color.fromRGBO(59, 79, 125, 1),
                fontFamily: 'SfProDisplay',
              ),
              onSeek: (duration) {
                state.audioPlayer.seek(duration);
              },
            );
          },
        ),
      ),
    );
  }
}
