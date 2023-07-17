import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
// import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:music_app/login.dart';

class SignUpScreen extends StatefulWidget {
  final double width;
  final double height;

  const SignUpScreen({super.key, required this.width, required this.height});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widget.width,
        height: widget.height,
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
        child: Column(children: [
          SizedBox(
            height: widget.height * 0.05,
          ),
          Container(
            width: widget.height * 0.4,
            height: widget.height * 0.4,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(222, 219, 249, 0.2),
                  Color.fromRGBO(210, 222, 253, 0.2),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      color: Color.fromRGBO(191, 202, 228, 1),
                      offset: Offset(10, 10),
                      inset: true),
                  BoxShadow(
                      blurRadius: 20,
                      color: Color.fromRGBO(226, 233, 255, 1),
                      offset: Offset(-10, -10),
                      inset: true)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child:
                  Image.asset("lib/assets/first_page.png", fit: BoxFit.contain),
            ),
          ),
          SizedBox(
            height: widget.height * 0.05,
          ),
          Container(
            width: widget.width * 0.8,
            height: widget.height * 0.4,
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(194, 204, 235, 1),
                              Color.fromRGBO(234, 239, 255, 1),
                            ],
                          )),
                      child: TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(27.0),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(59, 79, 125, 0.75),
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(59, 79, 125, 0.75),
                              ),
                              borderRadius: BorderRadius.circular(27)),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(59, 79, 125, 0.75),
                            fontFamily: 'SfProNormalDisplay',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.height * 0.01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(194, 204, 235, 1),
                              Color.fromRGBO(234, 239, 255, 1),
                            ],
                          )),
                      child: TextFormField(
                        obscureText: _isPasswordHidden,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(27.0),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(59, 79, 125, 0.75),
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(59, 79, 125, 0.75),
                              ),
                              borderRadius: BorderRadius.circular(27)),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(59, 79, 125, 0.75),
                            fontFamily: 'SfProNormalDisplay',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
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
                              onPressed: () {},
                              child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'SfProDisplay'),
                                    ),
                                    Icon(Icons.arrow_right_alt_rounded,
                                        color: Colors.white)
                                  ])),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
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
                                        builder: (context) => LoginScreen(
                                            width: widget.width,
                                            height: widget.height)));
                              },
                              child: const Text(
                                "Login Instead",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'SfProDisplay'),
                              )),
                        ),
                      ],
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
