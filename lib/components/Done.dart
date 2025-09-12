import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hi/components/Card.dart';
import 'package:hi/components/Conversation.dart';
import 'package:hi/components/Front.dart';
import 'package:hi/components/GrammerTwo.dart';
import 'package:hi/components/Mean.dart';
import 'package:hi/components/Result.dart';
import 'package:hi/components/Simplespeak.dart';
import 'package:hi/components/Smtence.dart';
import 'package:hi/components/WinStreak.dart';
import 'package:hi/components/Yescom.dart';

class Pro extends StatefulWidget {
  final data;
  Pro({required this.data});

  @override
  _ProState createState() => _ProState();
}

class _ProState extends State<Pro> {
  int layer = 0;
  Random random = Random();
  int progress = 0;
  int wronganswer = 0;/// miss


  // List of widgets for each step
  final List<Widget Function(VoidCallback onNext,dynamic data,int progress,VoidCallback incorrectAns)> steps = [
        // (onNext) => Front(onNext: onNext),
        // (onNext)=>Result(onNext: onNext),
        (onNext,data,progress,incorrectAns) => Mean(onNext: onNext,data: data['Learn_newword'][0],progress: progress,incorrectAns:incorrectAns),
  // (onNext)=> Conversation(onNext: onNext),
        (onNext,data,progress,incorrectAns) => Sentence(onNext: onNext,data:data['choose_correct_sentence'][0],progress: progress,incorrectAns:incorrectAns),

        (onNext,data, progress,incorrectAns) => YesNoQuiz(onNext: onNext,data:data['complete_eng_sentence'][0],progress: progress,incorrectAns:incorrectAns),
        (onNext,data, progress,incorrectAns) => Sentence(onNext: onNext,data:data['choose_correct_sentence'][1],progress: progress,incorrectAns:incorrectAns),
        (onNext,data, progress,incorrectAns) => LanguageLearningScreen(onNext: onNext,data:data['complete_hindi_sentence'][0],progress: progress,incorrectAns:incorrectAns),
        (onNext,data, progress,incorrectAns) => Cardp(onNext: onNext,data:data['Speaking_word'][0],progress: progress,incorrectAns:incorrectAns),
        (onNext,data, progress,incorrectAns) => SimpleSpeak(onNext: onNext,data:data['Speaking_word'][0],progress: progress,incorrectAns:incorrectAns),

        //
  ];


  void goToNextLayer() {
    print(layer);

    if (layer < steps.length - 1) {
      // print(widget.data);
      // print(layer);
     var unique_number  =  random.nextInt(steps.length);
     double quizdived = 100 / steps.length ;

     print(unique_number);
      setState(() {
        progress+= quizdived.toInt();

        layer++;
      });

    }
    if(layer >= steps.length -1  ){
      print("@@@@@@@@@@@@@");
      print(wronganswer);
      print("2@@@");

      var make_result = (steps.length -1)-  wronganswer ;
    var xpearn = make_result * 10;
    var accuracy = 100 - (wronganswer * 20);
    print(accuracy);


      Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>Result(xpearn:xpearn,perfectaccuracy:accuracy)));
    }
  }

  void incorrectAns(){
    setState(() {
      wronganswer++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: steps[layer](goToNextLayer,widget.data, progress,incorrectAns),
    );
  }
}
