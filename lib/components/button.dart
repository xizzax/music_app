import 'package:flutter/material.dart';

//makin my own button widget to be used everywhere
class MyButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Gradient gradient;

  const MyButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.gradient});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
