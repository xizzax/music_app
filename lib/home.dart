import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/foundation.dart';

import 'package:music_app/now_playing.dart';
import 'package:music_app/playlists.dart';
import 'package:music_app/search.dart';
import 'package:music_app/state/state.dart';
import 'package:provider/provider.dart';
import 'all_files.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () {
  //     requestStoragePermission();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //variable from state
    var state = context.watch<MusicPlayer>();
    //screen width and height
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //list of pages we can cycle through
    //index controlled by ephemeral state
    final List pages = [
      AllFiles(
        width: width,
        height: height,
      ),
      NowPlaying(
        width: width,
        height: height,
      ),
      SearchPage(
        height: height,
        width: width,
      ),
      PlaylistPage(
        width: width,
        height: height,
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
              tileMode: TileMode.clamp,
              center: Alignment(-1.1, -0.5),
              colors: [
                // Color.fromRGBO(98, 132, 255, 0.2),
                Color.fromRGBO(255, 114, 182, 0.05),
                // Color.fromRGBO(249, 229, 232, 0.4),
                Color.fromRGBO(151, 225, 212, 0.2),
              ],
              radius: 0.3),
        ),
        child: pages[state.current],
      ),
      bottomNavigationBar: Container(
        height: height * 0.085,
        width: double.infinity,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: Color.fromRGBO(191, 202, 228, 1),
                  offset: Offset(-5, -5),
                  inset: true),
              BoxShadow(
                  blurRadius: 5,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  offset: Offset(5, 5),
                  inset: true)
            ],
            gradient: LinearGradient(colors: [
              Color.fromRGBO(218, 227, 255, 1),
              Color.fromRGBO(224, 232, 255, 1),
              Color.fromRGBO(244, 245, 254, 1)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: state.current //index controlled by ephemeral state
          ,
          onTap: (index) => state.setPage(index),
          unselectedItemColor: const Color.fromRGBO(59, 79, 125, 0.5),
          selectedItemColor: const Color.fromRGBO(59, 79, 125, 1),
          // selectedIconTheme: const IconThemeData(
          //   size: 24,
          //   opticalSize: 10,
          // ),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_music_rounded,
                  shadows: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 3,
                      color: Color.fromRGBO(191, 202, 228, 1),
                      offset: Offset(3, 3),
                    ),
                    BoxShadow(
                      blurRadius: 3,
                      color: Color.fromRGBO(226, 233, 255, 1),
                      offset: Offset(-3, -3),
                    )
                  ],
                ),
                label: "Now Playing"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.play_arrow_rounded,
                  shadows: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 3,
                      color: Color.fromRGBO(191, 202, 228, 1),
                      offset: Offset(3, 3),
                    ),
                    BoxShadow(
                      blurRadius: 3,
                      color: Color.fromRGBO(226, 233, 255, 1),
                      offset: Offset(-3, -3),
                    )
                  ],
                ),
                label: "Now Playing"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_rounded,
                  shadows: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 3,
                      color: Color.fromRGBO(191, 202, 228, 1),
                      offset: Offset(3, 3),
                    ),
                    BoxShadow(
                      blurRadius: 3,
                      color: Color.fromRGBO(226, 233, 255, 1),
                      offset: Offset(-3, -3),
                    )
                  ],
                ),
                label: "My Playlist"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.supervised_user_circle,
                  shadows: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 3,
                      color: Color.fromRGBO(191, 202, 228, 1),
                      offset: Offset(3, 3),
                    ),
                    BoxShadow(
                      blurRadius: 3,
                      color: Color.fromRGBO(226, 233, 255, 1),
                      offset: Offset(-3, -3),
                    )
                  ],
                ),
                label: "Profile")
          ],
        ),
      ),
    );
  }

  // void requestStoragePermission() async {
  //   if (!kIsWeb) {
  //     bool permissionStatus =
  //         await Provider.of<MusicPlayer>(context, listen: false)
  //             .audioQuery
  //             .permissionsStatus();
  //     if (!permissionStatus) {
  //       await Provider.of<MusicPlayer>(context, listen: false)
  //           .audioQuery
  //           .permissionsRequest();
  //     }
  //     // to ensure the build method is called
  //     setState(() {});
  //   }
  // }
}
