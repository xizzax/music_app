import 'package:flutter/material.dart';
import 'package:music_app/components/background_gradient.dart';
import 'package:music_app/state/state.dart';
import 'package:provider/provider.dart';

class CreatePlaylistButton extends StatefulWidget {
  const CreatePlaylistButton({super.key});

  @override
  State<CreatePlaylistButton> createState() => _CreatePlaylistButtonState();
}

class _CreatePlaylistButtonState extends State<CreatePlaylistButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffe6e7fd),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFD0D2F2),
              blurRadius: 8,
              offset: Offset(4, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0xFFF6F9FF),
              blurRadius: 8,
              offset: Offset(-4, -4),
              spreadRadius: 0,
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          splashColor: Colors.blueGrey,
          onTap: () {
            TextEditingController playlistNameController =
                TextEditingController();
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                        gradient: backgroundGradient,
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SearchBar(
                            controller: playlistNameController,
                            hintText: "Playlist Name",
                            hintStyle:
                                const MaterialStatePropertyAll<TextStyle>(
                              TextStyle(
                                color: Color.fromRGBO(59, 79, 125, 0.75),
                                fontFamily: 'SfProNormalDisplay',
                                fontSize: 15,
                              ),
                            ),
                            padding:
                                const MaterialStatePropertyAll(EdgeInsets.only(
                              right: 10,
                              left: 10,
                            )),
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            surfaceTintColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            textStyle:
                                const MaterialStatePropertyAll<TextStyle>(
                                    TextStyle(
                              color: Colors.black,
                              fontFamily: "SfProNormalDisplay",
                            )),
                            shadowColor: const MaterialStatePropertyAll<Color>(
                                Color(0xFFD0D2F2)),
                            elevation:
                                const MaterialStatePropertyAll<double>(0),
                            backgroundColor:
                                (const MaterialStatePropertyAll<Color>(
                                    Color(0xffe6e7fd))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffe6e7fd),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFFD0D2F2),
                                    blurRadius: 8,
                                    offset: Offset(4, 4),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: Color(0xFFF6F9FF),
                                    blurRadius: 8,
                                    offset: Offset(-4, -4),
                                    spreadRadius: 0,
                                  )
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                splashColor: Colors.blueGrey,
                                onTap: () async {
                                  await Provider.of<MusicPlayer>(context,
                                          listen: false)
                                      .audioQuery
                                      .createPlaylist(
                                          playlistNameController.text);

                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: const Center(
                                    child: Text(
                                      "Create",
                                      style: TextStyle(
                                        color: Color.fromRGBO(59, 79, 125, 1),
                                        fontFamily: 'SfProDisplay',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
            color: Colors.transparent,
            child: const Center(
              child: Text(
                "Create New Playlist",
                style: TextStyle(
                  color: Color.fromRGBO(59, 79, 125, 1),
                  fontFamily: 'SfProDisplay',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
