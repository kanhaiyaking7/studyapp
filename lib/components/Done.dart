import 'package:flutter/material.dart';
import 'package:hi/components/Card.dart';
import 'package:hi/components/Choice.dart';
import 'package:hi/components/Conversation.dart';
import 'package:hi/components/Front.dart';
import 'package:hi/components/Match.dart';
import 'package:hi/components/Mean.dart';
import 'package:hi/components/Result.dart';
import 'package:hi/components/Robot.dart';
import 'package:hi/components/Simplespeak.dart';
import 'package:hi/components/Smtence.dart';
import 'package:hi/components/Speaking_english.dart';
import 'package:hi/components/Yescom.dart';





class Pro extends StatefulWidget {
  @override
  _ProState createState() => _ProState();
}

class _ProState extends State<Pro> {
  int layer = 0;

  // List of widgets for each step
  final List<Widget Function(VoidCallback onNext)> steps = [
        (onNext) => Front(onNext: onNext),
        (onNext) => Mean(onNext: onNext),

  // (onNext)=> Conversation(onNext: onNext),
        (onNext) => Sentence(onNext: onNext),
        (onNext) => YesNoQuiz(onNext: onNext),
        (onNext) => Cardp(onNext: onNext),
        (onNext) => SimpleSpeak(onNext: onNext),
        (onNext)=>Result(onNext: onNext),
        // (onNext) => Speaking_english(onNext:onNext),
        //
        // (onNext) => Choice(onNext: onNext),
        // // (onNext) => Robot(onNext: onNext),
        // (onNext) => Matcha(onNext: onNext),
  ];

  void goToNextLayer() {
    if (layer < steps.length - 1) {
      print(layer);
      setState(() {
        layer++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: steps[layer](goToNextLayer),
    );
  }
}
