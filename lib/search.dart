import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/components/background_gradient.dart';
import 'package:music_app/state/state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  final double height;
  final double width;
  const SearchPage({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  List<SongModel> foundSongs = [];
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();
    return Scaffold(
      body: Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 35.0,
          ),
          child: Column(
            children: [
              SearchBar(
                controller: _searchController,
                padding: const MaterialStatePropertyAll(EdgeInsets.only(
                  right: 10,
                  left: 10,
                )),
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                surfaceTintColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
                  color: Colors.black,
                  fontFamily: "SfProNormalDisplay",
                )),
                shadowColor:
                    const MaterialStatePropertyAll<Color>(Color(0xFFD0D2F2)),
                elevation: const MaterialStatePropertyAll<double>(0),
                backgroundColor:
                    (const MaterialStatePropertyAll<Color>(Color(0xffe6e7fd))),
                trailing: [
                  GestureDetector(
                    onTap: () {
                      searchQuery = _searchController.text;
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        foundSongs = findSongs(searchQuery.toLowerCase());
                      });
                    },
                    child: Container(
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
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.search_rounded,
                          size: 24,
                          color: Color.fromRGBO(59, 79, 125, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              foundSongs.isEmpty
                  ? SizedBox(
                      height: widget.height * 0.75,
                      child: const Center(
                        child: Text(
                          "Search",
                          style: TextStyle(
                            fontFamily: 'SfProDisplay',
                            color: Color.fromRGBO(59, 79, 125, 1),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: widget.height * 0.75,
                      child: ListView.builder(
                          itemCount: foundSongs.length,
                          // shrinkWrap: true,
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
                                            color: Color.fromRGBO(
                                                191, 202, 228, 1),
                                            offset: Offset(2, 2),
                                            inset: true,
                                          ),
                                          BoxShadow(
                                            blurRadius: 3,
                                            color: Color.fromRGBO(
                                                226, 233, 255, 1),
                                            offset: Offset(-2, -2),
                                            inset: true,
                                          )
                                        ],
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                191, 202, 228, 0.75))),
                                    child: ListTile(
                                      visualDensity:
                                          const VisualDensity(vertical: -4),
                                      contentPadding: EdgeInsets.only(
                                          left: widget.height * 0.02,
                                          right: widget.height * 0.02),
                                      leading: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              color: Color.fromRGBO(
                                                  191, 202, 228, 1),
                                              offset: Offset(2, 2),
                                            ),
                                            BoxShadow(
                                              blurRadius: 1,
                                              color: Color.fromRGBO(
                                                  226, 233, 255, 1),
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
                                        foundSongs[index].title,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(59, 79, 125, 1),
                                          fontFamily: 'SfProDisplay',
                                          fontSize: 15,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${foundSongs[index].artist!} | ${foundSongs[index].album!}",
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(59, 79, 125, 0.75),
                                          fontFamily: 'SfProNormalDisplay',
                                          fontSize: 11,
                                        ),
                                      ),
                                      onTap: () async {
                                        // String? uri = item.data![index].uri;
                                        await state.audioPlayer.setAudioSource(
                                            state.createPlaylist(foundSongs),
                                            initialIndex: index);
                                        state.play(foundSongs[index], index);
                                      },
                                    ),
                                  ),
                                ),
                              ))),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  List<SongModel> findSongs(searchQuery) {
    //store found songs in this
    List<SongModel> songs = [];
    List<SongModel> allSongs = MusicPlayer.allSongs;
    for (SongModel song in allSongs) {
      if (song.title.toLowerCase().contains(searchQuery)) {
        songs.add(song);
      } else if (song.album != null) {
        if (song.album!.toLowerCase().contains(searchQuery)) {
          songs.add(song);
        }
      } else if (song.artist != null) {
        if (song.artist!.toLowerCase().contains(searchQuery)) {
          songs.add(song);
        }
      }
    }
    return songs;
  }
}
