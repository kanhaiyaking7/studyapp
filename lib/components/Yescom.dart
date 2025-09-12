

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hi/Providers/path_provier/data_provider.dart';
import 'package:hi/components/navbarcomponent.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sound_library/sound_library.dart';
import 'package:audioplayers/audioplayers.dart';

class YesNoQuiz extends ConsumerStatefulWidget {

  final Function onNext;
final dynamic data;
  final int progress;
  final Function incorrectAns;

  const YesNoQuiz({

    required this.onNext,
    required this.data,
    required this.progress,
    required this.incorrectAns
  });

  @override
  ConsumerState<YesNoQuiz> createState() => _YesNoQuizState();
}

class _YesNoQuizState extends ConsumerState<YesNoQuiz> {

  String? butt;
  var info;
  var unique_sentence;

  late List<Map<String,dynamic>> user = [
    {
      "question": unique_sentence['english_word'],
      'hindi_mean':unique_sentence['hindi_mean'],
      'option':unique_sentence['opt'],
      'correct_ans':unique_sentence['corr_ans']

    }
  ];


  FlutterTts flutterTts  = FlutterTts();

  Future _speak() async {

    await flutterTts.setLanguage("hi");
    await flutterTts.setPitch(1);
    await flutterTts.speak(user[0]['hindi_mean']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 _speak();
    // final data =  ref.read(Path_data).data;
    // info = data;
    // var extract_data = info['complete_eng_sentence'];
    unique_sentence= widget.data;
  }


  // void handleNo() async{
  //  await SoundPlayer.play(Sounds.click, volume: 0.9, position: Duration(milliseconds: 500));
  //   print(user[0]["situation"] == "no");
  //   print('User cancelled exit');
  //   if (user[0]["situation"] == "no") {
  //     // widget.setLayer(widget.layer + 1);
  //     widget.onNext();
  //   } else {
  //     setState(() {
  //       butt = "wrong";
  //     });
  //   }
  // }


  //
  void nextQuestion() {
    // widget.setLayer(widget.layer + 1);
    widget.onNext();
  }


  void left_are(){
    if(user[0]['option'][0] == user[0]['correct_ans']){
      widget.onNext();
    }
    else{
      widget.incorrectAns();
      setState(() {
        butt = "wrong";
      });

    }
  }
  void right_are(){
    if(user[0]['option'][1] == user[0]['correct_ans']){
      widget.onNext();
    }
    else{
      widget.incorrectAns();

      setState(() {
        butt = "wrong";
      });

    }
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
                width: double.infinity,
                height: 41,

                child: navbar(progress:widget.progress) ,
              ),
              // Container(
              //
              //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   child: Column(
              //     children: [
              //       // Top row with back button and menu
              //
              //       // const SizedBox(height: 15),
              //
              //       // Progress bar
              //       // Row(
              //       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       //   children: List.generate(4, (index) {
              //       //     return Container(
              //       //       width: (screenWidth - 60) / 7,
              //       //       height: 8,
              //       //       decoration: BoxDecoration(
              //       //         color: index < 3
              //       //             ? Colors.white
              //       //             : Colors.white.withOpacity(0.3),
              //       //         borderRadius: BorderRadius.circular(4),
              //       //       ),
              //       //     );
              //       //   }),
              //       // ),
              //     ],
              //   ),
              // ),
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
                                decoration:  BoxDecoration(
                                  // color: Color(0xFFFF6B47),
                                  // color:  const Color(0xFFFFF8E1),
                                  // color:  const Color(0xFFFFECB3),
                                  color:  Colors.amber[200],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  // 'Choose sentence is right',
                                  'Complete the Sentence',
                                  style: TextStyle(
                                    color: Colors.black,
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
                                         user[0]['question'],
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: Color(0xFF4A5568),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                       Text(
                                         user[0]['hindi_mean'],
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
                                  onTap: left_are,

                                  child: Container(
                                    height: 90,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      // color: const Color(0xFF2ECC71),
                                      border: Border.all(width: 2.0,color: Colors.yellow),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          offset: const Offset(0, 2),
                                          blurRadius: 3.84,
                                        ),
                                      ],
                                    ),
                                    child:  Center(
                                      child: Text(
                                        user[0]['option'][0],
                                        style: TextStyle(
                                          color: Colors.white,
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
                                  onTap: right_are,
                                  // onTap:(){},
                                  child: Container(
                                    height: 90,
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                      // color: const Color(0xFF2ECC71),
                                      // color:  Colors.blueGrey[50],
                                      border: Border.all(width: 2.0,color: Colors.yellow),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          offset: const Offset(0, 2),
                                          blurRadius: 3.84,
                                        ),
                                      ],
                                    ),
                                    child:  Center(
                                      child: Text(
                                        user[0]['option'][1],
                                        style: TextStyle(
                                          color: Colors.white,
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
                                  'Correct answer = ${user[0]['correct_ans']}',
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