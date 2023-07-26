//what do i need in the state?
//what do i need to manage across the app?

//audio plugin and play
//the song being played
// when a song is clicked
// chnage the page to now playing page
//the page we're on

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

// state management using provider here
class MusicPlayer extends ChangeNotifier {
  // only need the index of the page to be displayed
  int current = 0;
  // the onAudio plugin
  final OnAudioQuery audioQuery = OnAudioQuery();
  // the actual audio player
  final AudioPlayer audioPlayer = AudioPlayer();
  // playing or not
  bool playing = false;
  // currently playing song
  var currentlyPlaying;
  int currentlyPlayingIndex = 0;
  // all songs
  static List<SongModel> allSongs = [];
  // current playlist
  List<SongModel> currentPlaylist = [];

  //setting the page to be displayed
  void setPage(index) {
    current = index;
    notifyListeners();
  }

// for managing the state of the pause/play button
  void changePlaying() async {
    // playing = !playing;
    if (currentlyPlaying == null) {
      await audioPlayer.setAudioSource(createPlaylist(allSongs),
          initialIndex: 0);
      play(allSongs[0], 0);
    } else if (audioPlayer.playing) {
      audioPlayer.pause();
      playing = false;
    } else {
      audioPlayer.play();
      playing = true;
    }
    notifyListeners();
  }

// for initially playing the song
  void play(song, index) {
    currentlyPlayingIndex = index;
    currentlyPlaying = song;
    audioPlayer.play();
    playing = true;
    notifyListeners();
  }

  void shuffleAll() async {
    await audioPlayer.setShuffleModeEnabled(true);
    await audioPlayer.shuffle();
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    currentPlaylist.clear();
    currentPlaylist = [...songs];
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
    return ConcatenatingAudioSource(children: sources);
  }

  void updateCurrentPlayingDetails(int index) {
    if (currentPlaylist.isNotEmpty) {
      currentlyPlayingIndex = index;
      currentlyPlaying = currentPlaylist[index];
    } else {
      currentlyPlaying = null;
      playing = false;
      audioPlayer.dispose();
    }
    notifyListeners();
  }

  Stream<DurationState> get durationStateStream => Rx.combineLatest2(
      audioPlayer.positionStream,
      audioPlayer.durationStream,
      (position, duration) =>
          DurationState(position: position, total: duration ?? Duration.zero));
}

// for handling duration
class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
