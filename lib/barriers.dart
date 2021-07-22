import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {

  final size;
  Barrier({this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      height: size,
      decoration: BoxDecoration(
          color: Colors.lightGreen,
          border: Border.all(width: 2, color: Colors.black38),
          borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
