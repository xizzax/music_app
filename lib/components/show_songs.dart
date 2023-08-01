import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:music_app/all_files.dart';
import 'package:music_app/state/state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// we're going to use this widget to display songs
class ShowSongs extends StatefulWidget {
  // final OnAudioQuery audioQuery;
  final double totalHeight;
  final SongSortType sortBy;
  // final AudioPlayer audioPlayer;
  const ShowSongs({
    super.key,
    required this.totalHeight,
    required this.sortBy,
  });

  @override
  State<ShowSongs> createState() => _ShowSongsState();
}

class _ShowSongsState extends State<ShowSongs> {
  final ItemScrollController _scrollController = ItemScrollController();
  // final GroupedItemScrollController _scrollController = GroupedItemScrollController();
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();
    return FutureBuilder<List<SongModel>>(
      future: state.audioQuery.querySongs(
        sortType: widget.sortBy,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: (context, item) {
        MusicPlayer.allSongs.clear();
        //show loading for the time being
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // in case no songs are found
        if (item.data!.isEmpty) {
          return const Center(
            child: Text("No Songs Found"),
          );
        }
        //once the songs are fetched and are ready to be shown
        MusicPlayer.allSongs = [...item.data!];
        List<String> alphabets = getLetters();

        return Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemCount: item.data!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) => Container(
                        // height: widget.totalHeight * 0.1,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          // borderRadius:
                          //     BorderRadius.all(Radius.circular(30))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color.fromRGBO(191, 202, 228, 1),
                                    offset: Offset(2, 2),
                                    inset: true,
                                  ),
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color.fromRGBO(226, 233, 255, 1),
                                    offset: Offset(-2, -2),
                                    inset: true,
                                  )
                                ],
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        191, 202, 228, 0.75))),
                            child: ListTile(
                              visualDensity: const VisualDensity(vertical: -4),
                              contentPadding: EdgeInsets.only(
                                  left: widget.totalHeight * 0.02,
                                  right: widget.totalHeight * 0.02),
                              leading: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 1,
                                      color: Color.fromRGBO(191, 202, 228, 1),
                                      offset: Offset(2, 2),
                                    ),
                                    BoxShadow(
                                      blurRadius: 1,
                                      color: Color.fromRGBO(226, 233, 255, 1),
                                      offset: Offset(-2, -2),
                                    )
                                  ],
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  size: 25,
                                  color: Color.fromRGBO(59, 79, 125, 1),
                                ),
                              ),
                              title: Text(
                                item.data![index].title,
                                style: const TextStyle(
                                  color: Color.fromRGBO(59, 79, 125, 1),
                                  fontFamily: 'SfProDisplay',
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                "${item.data![index].artist!} | ${item.data![index].album!}",
                                style: const TextStyle(
                                  color: Color.fromRGBO(59, 79, 125, 0.75),
                                  fontFamily: 'SfProNormalDisplay',
                                  fontSize: 11,
                                ),
                              ),
                              onTap: () async {
                                // String? uri = item.data![index].uri;
                                await state.audioPlayer.setAudioSource(
                                    state.createPlaylist(item.data!),
                                    initialIndex: index);
                                state.play(item.data![index], index);
                              },
                            ),
                          ),
                        ),
                      ))),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
              child: StreamBuilder(builder: ((context, snapshot) {
                if (alphabets.isNotEmpty) {
                  // print(MusicPlayer.allSongs.last.title[0]);
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: alphabets.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // print(alphabets);
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: GestureDetector(
                            onTap: () {
                              var song;
                              if (widget.sortBy == SongSortType.TITLE) {
                                song = MusicPlayer.allSongs.firstWhere((song) =>
                                    song.title[0].toUpperCase() ==
                                    alphabets[index]);
                              } else if (widget.sortBy == SongSortType.ALBUM) {
                                song = MusicPlayer.allSongs.firstWhere((song) =>
                                    song.album![0].toUpperCase() ==
                                    alphabets[index]);
                              } else if (widget.sortBy == SongSortType.ARTIST) {
                                song = MusicPlayer.allSongs.firstWhere((song) =>
                                    song.artist![0].toUpperCase() ==
                                    alphabets[index]);
                              }

                              print(song.title);
                              int i = MusicPlayer.allSongs.indexOf(song);
                              print(i);
                              // _scrollController.animateTo(i,
                              //     duration: Duration(seconds: 1),
                              //     curve: Curves.bounceIn);
                              _scrollController.jumpTo(index: i);
                            },
                            child: Text(
                              alphabets[index],
                              style: TextStyle(
                                color: Color.fromRGBO(59, 79, 125, 0.75),
                                fontFamily: 'SfProNormalDisplay',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      });
                }
                return Text("*");
              })),
            ),
          ],
        );
      },
    );
  }

  List<String> getLetters() {
    List<String> letters = [];
    for (var song in MusicPlayer.allSongs) {
      if (widget.sortBy == SongSortType.TITLE) {
        if (letters.contains(song.title[0].toUpperCase()) == false) {
          letters.add(song.title[0].toUpperCase());
        }
      } else if (widget.sortBy == SongSortType.ARTIST) {
        if (letters.contains(song.artist![0].toUpperCase()) == false) {
          letters.add(song.artist![0].toUpperCase());
        }
      } else if (widget.sortBy == SongSortType.ALBUM) {
        if (letters.contains(song.album![0].toUpperCase()) == false) {
          letters.add(song.album![0].toUpperCase());
        }
      }
    }
    return letters;
  }
}

//  ListView.builder(
                 