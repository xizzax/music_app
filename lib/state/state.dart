//what do i need in the state?
//what do i need to manage across the app?

//audio plugin and play
//the song being played
// when a song is clicked
// chnage the page to now playing page
//the page we're on

import 'package:flutter/material.dart';

// state management using provider here
class MusicPlayer extends ChangeNotifier {
  // only need the index of the page to be displayed
  int current = 0;

  //setting the page to be displayed
  void setPage(index) {
    current = index;
    notifyListeners();
  }
}
