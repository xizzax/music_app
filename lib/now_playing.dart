import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:music_app/components/background_gradient.dart';
import 'package:music_app/components/buttons.dart';
import 'package:music_app/components/slider.dart';
import 'package:music_app/state/state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatefulWidget {
  final double width;
  final double height;
  const NowPlaying({super.key, required this.width, required this.height});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();

    state.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        if (index != state.currentlyPlayingIndex) {
          state.updateCurrentPlayingDetails(index);
        }
      }
    });

    return Scaffold(
      body: Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(gradient: backgroundGradient),
        child: Column(children: [
          //now playing
          SizedBox(
            height: widget.height * 0.13,
            child: const Center(
                child: Text(
              "Now Playing",
              style: TextStyle(
                color: Color.fromRGBO(59, 79, 125, 1),
                fontFamily: 'SfProDisplay',
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
          //artwork
          SizedBox(
            height: widget.height * 0.3,
            child: Container(
                width: widget.height * 0.3,
                height: widget.height * 0.3,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(231, 238, 255, 0.9),
                      Color.fromRGBO(224, 234, 255, 0.8)
                    ]),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(250, 250, 255, 1),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: Offset(-5, -5),
                      ) //the white shadow
                      ,
                      BoxShadow(
                        color: Color.fromRGBO(194, 204, 235, 0.75),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(7, 7),
                      )
                    ]),
                child: state.currentlyPlaying == null
                    ? const Center()
                    : QueryArtworkWidget(
                        size: 500,
                        artworkBorder: BorderRadius.circular(150),
                        artworkQuality: FilterQuality.high,
                        id: state.currentlyPlaying.id,
                        type: ArtworkType.AUDIO)),
          ),

          //name and artist
          SizedBox(
              height: widget.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state.currentlyPlaying == null
                      ? Center()
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              state.currentlyPlaying.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromRGBO(59, 79, 125, 1),
                                fontFamily: 'SfProDisplay',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                  state.currentlyPlaying == null
                      ? Center()
                      : Text(
                          state.currentlyPlaying.artist,
                          style: TextStyle(
                            color: Color.fromRGBO(59, 79, 125, 0.75),
                            fontFamily: 'SfProNormalDisplay',
                            fontSize: 15,
                          ),
                        )
                ],
              )),
          //slider and buttons
          SizedBox(
            height: widget.height * 0.25,
            child: Column(children: [
              SizedBox(
                height: widget.height * 0.1,
                child: const SliderBar(),
              ),
              SizedBox(
                height: widget.height * 0.15,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PreviousButton(),
                    PlayButton(),
                    NextButton(),
                  ],
                ),
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
