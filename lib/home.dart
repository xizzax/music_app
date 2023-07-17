import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'all_files.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // index of the current tab
  int _currentTab = 0;
  // list of pages to be displayed
  // final List _pages = [
  //   AllFiles(width: widget.width, height: widget.height,),
  //   const Center(child: Text('Now Playing')),
  //   const Center(child: Text('Profile')),
  // ];
  // function to change the current tab (we change the state)
  _changeTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //screen width and height

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final List pages = [
      AllFiles(
        width: width,
        height: height,
      ),
      const Center(child: Text("Now Playing")),
      const Center(child: Text('Search')),
      const Center(child: Text('Profile')),
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
        child: pages[_currentTab],
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
          currentIndex: _currentTab,
          onTap: (index) => _changeTab(index),
          unselectedItemColor: const Color.fromRGBO(59, 79, 125, 0.5),
          selectedItemColor: const Color.fromRGBO(59, 79, 125, 1),
          // selectedIconTheme: const IconThemeData(
          //   size: 24,
          //   opticalSize: 10,
          // ),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: [
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
}
