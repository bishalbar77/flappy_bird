import 'dart:async';
import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdJump = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdJump;
  bool gameStarted = false;
  static double X1 = 1;
  double X2 = X1 + 1.3;
  int score = 0;
  int highScore = 0;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdJump;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdJump = 0;
      gameStarted = false;
      time = 0;
      initialHeight = birdJump;
      if(highScore < score) {
        highScore = score;
      }
      score = 0;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black38,
          title: Center(
            child: Text(
              "G A M E O V E R",
                  style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                    color: Colors.white,
                    child: Text(
                        "PLAY AGAIN",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }
    );
  }

  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        X1 -= 0.05;
        X2 -= 0.05;
        birdJump = initialHeight - height;
      });
      setState(() {
        if(X1 < -1.5) {
          score++;
          X1 += 3.0;
        } else {
          X1 -= 0.05;
        }
      });
      setState(() {
        if(X2 < -1.5) {
          score++;
          X2 += 3.0;
        } else {
          X2 -= 0.05;
        }
      });
      if(birdDead()) {
        timer.cancel();
        _showDialog();
      }

    });
  }

  bool birdDead() {
    if(birdJump > 1) return true;
    // if(birdJump ==  X1) return true;
    // if(birdJump == X2) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if(gameStarted) {
                        jump();
                      } else {
                        startGame();
                      }
                    },
                    child: AnimatedContainer(
                      alignment: Alignment(0,birdJump),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(
                        birdJump: birdJump,
                        birdHeight: 0.1,
                        birdWidth: 0.1,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0,-0.25),
                    child: gameStarted ? Text(" ") : Text("TAP TO START", style: TextStyle(fontSize: 20, color: Colors.white)) ,
                  ),
                  AnimatedContainer(
                      alignment: Alignment(X1,1.1),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(size: 150.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(X1,-1.1),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(size: 150.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(X2,-1.1),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(size: 130.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(X2,1.1),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(size: 170.0),
                  ),
                ],
              )
          ),
          Container(
            height: 15,
            color: Colors.lightGreen,
          ),
          Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("CURRENT SCORE", style: TextStyle(color: Colors.white, fontSize: 20),),
                      SizedBox(height: 20),
                      Text(score.toString(), style: TextStyle(color: Colors.white, fontSize: 40),),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("HIGH SCORE", style: TextStyle(color: Colors.white, fontSize: 20),),
                      SizedBox(height: 20),
                      Text(highScore.toString(), style: TextStyle(color: Colors.white, fontSize: 40),),
                    ],
                  ),
                ],
                ),
              )
          )
        ],
      ),
    );
  }
}
