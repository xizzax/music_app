import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:music_app/state/state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

// we're going to use this widget to display songs
class ShowSongs extends StatefulWidget {
  // final OnAudioQuery audioQuery;
  final double totalHeight;
  // final AudioPlayer audioPlayer;
  const ShowSongs({
    super.key,
    required this.totalHeight,
  });

  @override
  State<ShowSongs> createState() => _ShowSongsState();
}

class _ShowSongsState extends State<ShowSongs> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MusicPlayer>();
    return FutureBuilder<List<SongModel>>(
      future: state.audioQuery.querySongs(
        sortType: null,
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

        return ListView.builder(
            itemCount: item.data!.length,
            scrollDirection: Axis.vertical,
            // shrinkWrap: true,
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
                              color:
                                  const Color.fromRGBO(191, 202, 228, 0.75))),
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
                          item.data![index].artist! +
                              " | " +
                              item.data![index].album!,
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
                )));
      },
    );
  }
}

//  ListView.builder(
                 