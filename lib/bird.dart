import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final birdJump;
  final double birdWidth;
  final double birdHeight;

  MyBird({this.birdJump, required this.birdWidth, required this.birdHeight});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdJump + birdWidth) / (2 - birdHeight)),
      child: Image.asset(
          'assets/images/flappy.png',
        width: MediaQuery.of(context).size.height * birdWidth / 2,
        height: MediaQuery.of(context).size.height * birdHeight / 2,
      ),
    );
  }
}
