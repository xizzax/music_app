import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:music_app/components/background_gradient.dart';

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
    return Scaffold(
      body: Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(gradient: backgroundGradient),
        child: Column(children: [
          //now playing
          SizedBox(
            height: widget.height * 0.1,
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
              child: Image.asset("lib/assets/music_page.png",
                  fit: BoxFit.fitHeight),
            ),
          ),

          //name and artist
          SizedBox(
              height: widget.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fighting ft. Lee Young Ji",
                    style: TextStyle(
                      color: Color.fromRGBO(59, 79, 125, 1),
                      fontFamily: 'SfProDisplay',
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "BooSeokSoon",
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
            height: widget.height * 0.3,
          ),
        ]),
      ),
    );
  }
}
