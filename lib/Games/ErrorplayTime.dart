import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hi/Games/ErrorplayResult.dart';

class Errorplaytime extends StatefulWidget {
  const Errorplaytime({super.key});

  @override
  State<Errorplaytime> createState() => _ErrorplaytimeState();
}

class _ErrorplaytimeState extends State<Errorplaytime> {

  int timeLeft = 60;
  var gameTimer;


  void startTimer() {
    gameTimer?.cancel();
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft--;
      });

      if (timeLeft <= 0) {
        gameTimer?.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>
            ErrorplayResult(
                timeInMinutes: 20,
                accuracy: 40,
                coins: 10,
                correctAnswers: 56,
                totalQuestions: 100)
        ));
        print("end game");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gameTimer?.cancel();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: timeLeft / 60,
                  strokeWidth: 6,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    timeLeft > 20 ? Color(0xFF00b894) : Color(0xFFe74c3c),
                  ),
                ),
              ),
              Text(
                '$timeLeft',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Time',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      )

    );
  }
}
