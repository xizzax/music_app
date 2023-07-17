import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';

// we're going to use this widget to display songs
class ShowSongs extends StatefulWidget {
  final OnAudioQuery audioQuery;
  final double totalHeight;
  const ShowSongs(
      {super.key, required this.audioQuery, required this.totalHeight});

  @override
  State<ShowSongs> createState() => _ShowSongsState();
}

class _ShowSongsState extends State<ShowSongs> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: widget.audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: (context, item) {
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
        return ListView.builder(
            itemCount: item.data!.length,
            scrollDirection: Axis.vertical,
            // shrinkWrap: true,
            itemBuilder: ((context, index) => Container(
                  height: widget.totalHeight * 0.1,
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
                          border: Border.all(
                              color: Color.fromRGBO(191, 202, 228, 0.75))),
                      child: ListTile(
                        visualDensity: VisualDensity(vertical: -4),
                        contentPadding: EdgeInsets.only(
                            left: widget.totalHeight * 0.02,
                            right: widget.totalHeight * 0.02),
                        leading: Container(
                          decoration: BoxDecoration(
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
                          child: Icon(
                            Icons.play_arrow,
                            size: 25,
                            color: Color.fromRGBO(59, 79, 125, 1),
                          ),
                        ),
                        title: Text(
                          item.data![index].title,
                          style: TextStyle(
                            color: Color.fromRGBO(59, 79, 125, 1),
                            fontFamily: 'SfProDisplay',
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                          item.data![index].artist! +
                              " | " +
                              item.data![index].album!,
                          style: TextStyle(
                            color: Color.fromRGBO(59, 79, 125, 0.75),
                            fontFamily: 'SfProNormalDisplay',
                            fontSize: 11,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Favorited!");
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: Color.fromRGBO(191, 202, 228, 1),
                                  offset: Offset(2, 2),
                                ),
                                BoxShadow(
                                  blurRadius: 2,
                                  color: Color.fromRGBO(226, 233, 255, 1),
                                  offset: Offset(-2, -2),
                                )
                              ],
                            ),
                            child: Icon(
                              Icons.favorite_outline_rounded,
                              size: 22,
                              color: Color.fromRGBO(59, 79, 125, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )));
      },
    );
  }
}

//  ListView.builder(
                 