

import 'dart:async';

import 'package:flutter/material.dart';

class Videotimer extends StatefulWidget {
  const Videotimer({super.key});

  @override
  State<Videotimer> createState() => _VideotimerState();
}

class _VideotimerState extends State<Videotimer> {

  // int timeLeft = 60;

   Timer? _timer;
  int timeLeft = 1;

  @override
  void initState() {
    super.initState();
    startTimer();
  }



  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft++;
      });

      if (timeLeft >= 59) {
        print("endji");
        print(timeLeft);
        print("OOOOOOOO");
        _timer?.cancel();
      }
    });

  }
  //


  @override
  Widget build(BuildContext context) {

    return


     Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Display the countdown value.
          Text(
            '0 :$timeLeft',
            style: const TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),
          ),

        ],

    );

  }
}
