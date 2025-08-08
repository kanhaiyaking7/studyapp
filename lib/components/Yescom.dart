

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sound_library/sound_library.dart';
import 'package:audioplayers/audioplayers.dart';

class YesNoQuiz extends StatefulWidget {
  // final Function(int) setLayer;
  // final int layer;
  final Function onNext;
  const YesNoQuiz({
    Key? key,
    // required this.setLayer,
    // required this.layer,
    required this.onNext,
  }) : super(key: key);

  @override
  State<YesNoQuiz> createState() => _YesNoQuizState();
}

class _YesNoQuizState extends State<YesNoQuiz> {
  final List<Map<String, String>> user = [
    {"question": "I am a boy", "situation": "yes"}
  ];

  String? butt;



  var english_word = "Do you want to play?";
  var hindi_word = "क्या तुम खेलना चाहते हो?";
  var speaking_word = "";
  bool _speechEnabled = false;
  String _wordsSpoken = " ";
  double _confidenceLevel = 0;

  bool _sucessfull = false;

  String dd = "done";

  FlutterTts flutterTts  = FlutterTts();

  Future _speak() async {

    await flutterTts.setLanguage("hi");
    await flutterTts.setPitch(5);
    await flutterTts.speak(hindi_word);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 _speak();
  }

  void handleYes() {


    if (user[0]["situation"] == "yes") {
      print(widget.onNext);
      // setState(() {
      //   butt = "Right";
      // });
      // widget.setLayer(widget.layer + 1);
      widget.onNext();

    } else {
      setState(() {
        butt = "wrong";
      });
    }
  }

  void handleNo() async{
   await SoundPlayer.play(Sounds.click, volume: 0.9, position: Duration(milliseconds: 500));
    print(user[0]["situation"] == "no");
    print('User cancelled exit');
    if (user[0]["situation"] == "no") {
      // widget.setLayer(widget.layer + 1);
      widget.onNext();
    } else {
      setState(() {
        butt = "wrong";
      });
    }
  }

  void handleClose() {
    print('User closed dialog');
  }
  //
  void nextQuestion() {
    // widget.setLayer(widget.layer + 1);
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(

      body: Container(
        width: double.infinity,
        color: Colors.black,

        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    // Top row with back button and menu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.close_sharp,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Container(child:
                        new LinearPercentIndicator(
                          width: 250.0,
                          lineHeight: 8.0,
                          percent: 0.2,
                          backgroundColor: Colors.white,
                          progressColor: Colors.blue,
                          barRadius: Radius.circular(10.0),
                          animation: true,
                          animationDuration: 1000,
                          curve: Curves.easeInOut,
                          animateFromLastPercent: true,


                        ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.grid_view,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 15),

                    // Progress bar
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: List.generate(4, (index) {
                    //     return Container(
                    //       width: (screenWidth - 60) / 7,
                    //       height: 8,
                    //       decoration: BoxDecoration(
                    //         color: index < 3
                    //             ? Colors.white
                    //             : Colors.white.withOpacity(0.3),
                    //         borderRadius: BorderRadius.circular(4),
                    //       ),
                    //     );
                    //   }),
                    // ),
                  ],
                ),
              ),
              // Main content
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Dialog Box
                        Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.5,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F0E8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              // Dialog header
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF6B47),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Choose sentence is right',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Dialog content
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                       Text(
                                       english_word,
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: Color(0xFF4A5568),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                       Text(
                                        hindi_word,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Yes/No Buttons
                        SizedBox(
                          width: screenWidth * 0.9,
                          height: 90,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: handleYes,
                                  // onTap:(){},
                                  child: Container(
                                    height: 90,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE74C3C),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          offset: const Offset(0, 2),
                                          blurRadius: 3.84,
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: handleNo,
                                  // onTap:(){},
                                  child: Container(
                                    height: 90,
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2ECC71),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          offset: const Offset(0, 2),
                                          blurRadius: 3.84,
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Wrong answer feedback
                        if (butt == "wrong") ...[
                          const SizedBox(height: 20),
                          Container(
                            width: screenWidth * 0.9,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Answer is wrong',
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Correct answer = ${user[0]["situation"]}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: nextQuestion,
                                  // onTap:(){},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 85,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: const Text(
                                      'Next',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example usage in your main app
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Quiz App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: QuizScreen(),
//     );
//   }
// }
//
// class QuizScreen extends StatefulWidget {
//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen> {
//   int currentLayer = 0;
//
//   void setLayer(int newLayer) {
//     setState(() {
//       currentLayer = newLayer;
//     });
//     print('Layer changed to: $newLayer');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return YesNoQuiz(
//       // setLayer: setLayer,
//       // layer: currentLayer,
//     );
//   }
// }