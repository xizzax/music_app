import 'package:flutter/material.dart';
import 'package:music_app/home.dart';
import 'package:music_app/state/state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MusicPlayer(),
    child: const FirstPage(),
  ));
}

//this is the first page users see when they open the app
class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  final String topImage = "lib/assets/first_page.svg";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //image
              Container(
                  //contains the image
                  height: height / 2.1,
                  child: Image.asset("lib/assets/first_page.png")),
              //the text box
              Container(
                width: width - 50,
                height: height / 3,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(231, 238, 255, 0.8),
                      Color.fromRGBO(224, 234, 255, 0.9)
                    ]),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(234, 239, 255, 1),
                        blurRadius: 1.0,
                        offset: Offset(-10, -10),
                      ) //the white shadow
                      ,
                      BoxShadow(
                        color: Color.fromRGBO(194, 204, 235, 1),
                        blurRadius: 20,
                        offset: Offset(10, 10),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Welcome to Music Player",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(59, 79, 125, 1),
                          fontFamily: 'SfProDisplay',
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Listen to songs and albums offline",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(59, 79, 125, 0.75),
                          fontFamily: 'SfProDisplay',
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: width / 2,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(234, 239, 255, 1),
                            blurRadius: 1.0,
                            offset: Offset(-2, -2),
                          ) //the white shadow
                          ,
                          BoxShadow(
                            color: Color.fromRGBO(194, 204, 235, 1),
                            blurRadius: 20,
                            offset: Offset(2, 2),
                          )
                        ],
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(81, 99, 224, 1),
                              Color.fromRGBO(136, 147, 240, 1)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(0, 255, 255, 255),
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const HomeScreen())));
                        },
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Tap to continue",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'SfProDisplay'),
                              ),
                              Icon(Icons.arrow_right_alt_rounded,
                                  color: Colors.white)
                            ])),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
