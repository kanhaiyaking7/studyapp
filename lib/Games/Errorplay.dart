//
//
// import 'dart:async';
// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'dart:math';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hi/Providers/Games/ErrorHunt/ErrorHuntProvider.dart';
//
// class Errorplay extends ConsumerStatefulWidget {
//   const Errorplay({super.key});
//
//   @override
//   ConsumerState<Errorplay> createState() => _ErrorplayState();
// }
//
// class _ErrorplayState extends ConsumerState<Errorplay>  {
//
//   int currentLevel = 0;
//   int score = 0;
//   int mistake = 0;
//   // int currentQuestionIndex = 0;
//   bool isGameStarted = false;
//   bool isTimedMode = true;
//   bool isStreakMode = true;
//   int curentQuestionIndex = 0;
//
//   // Timer
//   var gameTimer;
//   int timeLeft = 60;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // startTimer();
//   }
//
//   void startTimer() {
//     gameTimer?.cancel();
//     gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         timeLeft--;
//       });
//
//       if (timeLeft <= 0) {print("end game");
//       }
//     });
//   }
//
//   // Sample questions by level
//   // final Map<int, List<Map<String, dynamic>>> questions = {
//   //   0: [ // Beginner
//   //     {
//   //       'sentence': 'He go to the school every day.',
//   //       'words': ['He', 'go', 'to', 'the', 'school', 'every', 'day.'],
//   //       'hindi_mean':'वह हर दिन स्कूल जाता है.',
//   //       'errorIndex': 1,
//   //       'correction': 'goes',
//   //       'explanation': 'Subject-verb agreement: "He" requires "goes" not "go"'
//   //     },
//   //     {
//   //       'sentence': 'She have a beautiful car.',
//   //       'words': ['She', 'have', 'a', 'beautiful', 'car.'],
//   //       'errorIndex': 1,
//   //       'correction': 'has',
//   //       'explanation': 'Subject-verb agreement: "She" requires "has" not "have"'
//   //     },
//   //     {
//   //       'sentence': 'They was playing football.',
//   //       'words': ['They', 'was', 'playing', 'football.'],
//   //       'errorIndex': 1,
//   //       'correction': 'were',
//   //       'explanation': 'Subject-verb agreement: "They" requires "were" not "was"'
//   //     }
//   //   ],
//   //   1: [ // Intermediate
//   //     {
//   //       'sentence': 'I will went to the store tomorrow.',
//   //       'words': ['I', 'will', 'went', 'to', 'the', 'store', 'tomorrow.'],
//   //       'errorIndex': 2,
//   //       'correction': 'go',
//   //       'explanation': 'Future tense: "will" + base form of verb, not past tense'
//   //     },
//   //     {
//   //       'sentence': 'She is working here since 2020.',
//   //       'words': ['She', 'is', 'working', 'here', 'since', '2020.'],
//   //       'errorIndex': 1,
//   //       'correction': 'has been',
//   //       'explanation': 'Present perfect continuous for duration with "since"'
//   //     },
//   //     {
//   //       'sentence': 'He bought a expensive watch.',
//   //       'words': ['He', 'bought', 'a', 'expensive', 'watch.'],
//   //       'errorIndex': 2,
//   //       'correction': 'an',
//   //       'explanation': 'Use "an" before vowel sounds'
//   //     }
//   //   ],
//   //   2: [ // Advanced
//   //     {
//   //       'sentence': 'The book, that I read yesterday was interesting.',
//   //       'words': ['The', 'book,', 'that', 'I', 'read', 'yesterday', 'was', 'interesting.'],
//   //       'errorIndex': 1,
//   //       'correction': 'book',
//   //       'explanation': 'No comma needed before restrictive relative clause'
//   //     },
//   //     {
//   //       'sentence': 'Neither the teacher nor the students was happy.',
//   //       'words': ['Neither', 'the', 'teacher', 'nor', 'the', 'students', 'was', 'happy.'],
//   //       'errorIndex': 6,
//   //       'correction': 'were',
//   //       'explanation': 'With "neither...nor", verb agrees with the nearer subject'
//   //     }
//   //   ]
//   // };
//
//   int selectedWordIndex = -1;
//   bool showExplanation = false;
//   String feedbackMessage = '';
//   Color feedbackColor = Colors.green;
//
//   void nextQuestion(currentquestion) {
//     // final questionsForLevel = questions[currentLevel]!;
//
//     setState(() {
//
//       curentQuestionIndex++;
//       // curentQuestionIndex= (currentQuestionIndex + 1) % questionsForLevel.length;
//       selectedWordIndex = -1;
//       showExplanation = false;
//       feedbackMessage = '';
//     });
//   }
//   // Animation controllers
//   void checkAnswer(int wordIndex,currentquestion) {
//     print(wordIndex);
//     print(currentquestion.errorIndex);
//     print("SSSSSSSS");
//     // if (showExplanation) return;
//
//     final currentQuestion = currentquestion;
//     final isCorrect = wordIndex == currentQuestion.errorIndex;
//
//     print("winnnnner");
//     print(isCorrect);
//
//     setState(() {
//       selectedWordIndex = wordIndex;
//       showExplanation = true;
//
//       if (isCorrect) {
//         score += 10;
//         // mistake++;
//         feedbackMessage = 'Correct! +10 points';
//         showExplanation = true;
//
//       } else {
//           mistake++;
//           // mistake = 0;
//         showExplanation = true;
//         feedbackMessage = 'Wrong! Try again';
//         feedbackColor = Colors.red;
//       }
//
//       Timer(const Duration(seconds: 3), () {
//         if (mounted) {
//           nextQuestion(currentquestion);
//         }
//       });
//     });
//
//     // Auto advance after 3 seconds
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final GrammerHunt = ref.watch(ErrorHuntProvider);
//     return Scaffold(
//         backgroundColor: const Color(0xFF1A1A1A),
//     appBar: AppBar(
//     backgroundColor: const Color(0xFF2D2D2D),
//     title: const Text(
//     'Grammar Error Hunt',
//     style: TextStyle(color: Colors.white),
//     ),
//       leading:  IconButton(
//         icon: const Icon(Icons.arrow_back, color: Colors.white),
//         onPressed: () => Navigator.of(context).pop(),
//       ),
//
//     ),
//     body:
//         GrammerHunt.when(
//             data: (hunt){
//               final quest = hunt[0].question;
//               final currentquestion = quest[curentQuestionIndex];
//
//               return
//                 Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       margin: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[900],
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.grey[700]!),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildScoreItem('Score', score.toString(), Colors.blue),
//                           _buildScoreItem('Error', mistake.toString(), Colors.purple),
//                           buildTimerBar(),
//
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 80,),
//
//                     Column(
//                         mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
//                         crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
//                         children: [
//                           Container(
//                             width: double.infinity,
//                             height: 100,
//                             alignment: Alignment.center,
//                             child: Text(currentquestion.hindiMean,style: TextStyle(color: Colors.white,
//                                 fontSize: 20),),
//                           ),
//                         ]
//                     ),
//                     // Center(
//                     //
//                     //      child:
//                     //      buildSentence(),
//                     //    ),
//                     const SizedBox(height: 80),
//                     Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           buildSentence(currentquestion),
//                         ]
//                     )
//                   ],
//                 ),
//               );
//             },
//             error: (e,stack)=>Text('error$e'),
//             loading: ()=>CircularProgressIndicator())
//
//
//
//     );
//   }
//
//   Widget _buildScoreItem(String label, String value, Color color) {
//     return Column(
//       children: [
//         Text(label, style: const TextStyle(color:Colors.white, fontSize: 15)),
//         const SizedBox(height: 4),
//
//                Text(
//                 value,
//                 style: TextStyle(
//                   color: color,
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//       ],
//     );
//   }
//   Widget buildSentence( currentquestion) {
//
//
//     final words = currentquestion.words as List<String>;
//
//     final errorIndex =currentquestion.errorIndex;
//
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(20),
//
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[700]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Tap the incorrect word:',
//             style: TextStyle(color: Colors.grey, fontSize: 14),
//           ),
//           const SizedBox(height: 30),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: words.asMap().entries.map((entry) {
//               final index = entry.key;
//               final word = entry.value;
//               final isSelected = selectedWordIndex == index;
//
//               final correct = index == null ? false: showExplanation &&index == errorIndex ? true : false;
//
//               final isError = showExplanation && index == errorIndex;
//               final isWrongSelection = showExplanation && isSelected && index != errorIndex;
//
//               Color backgroundColor = Colors.grey[800]!;
//               Color textColor = Colors.white;
//
//               if(correct && showExplanation){
//
//                 backgroundColor = Colors.green;
//                 textColor = Colors.white;
//               }else if(showExplanation && isSelected && index != errorIndex){
//                 backgroundColor = Colors.red;
//                 textColor = Colors.white;
//
//               }
//
//
//               // if (isError) {
//               //   print("1");
//               //   backgroundColor = Colors.red[600]!;
//               //   textColor = Colors.white;
//               // } else if (isWrongSelection) {
//               //   print("2");
//               //   backgroundColor = Colors.red[800]!;
//               //   textColor = Colors.white;
//               // } else if (isSelected) {
//               //   print("3");
//               //   backgroundColor = Colors.blue[600]!;
//               //   textColor = Colors.white;
//               // }
//
//               return GestureDetector(
//                 onTap: () => checkAnswer(index,currentquestion),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: backgroundColor,
//                     borderRadius: BorderRadius.circular(8),
//                     border: correct ? Border.all(color: Colors.orangeAccent, width: 2) : null,
//                   ),
//                   child: Text(
//                     word,
//                     style: TextStyle(
//                       color: textColor,
//                       fontSize: 16,
//                       fontWeight: isError ? FontWeight.bold : FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//           if (showExplanation) ...[
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: feedbackColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: feedbackColor),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     feedbackMessage,
//                     style: TextStyle(
//                       color: feedbackColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Correction: "${currentquestion.correction}"',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     currentquestion.explanation,
//                     // currentquestion['explanation'],
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//   Widget buildTimerBar() {
//
//
//     final progress = timeLeft / 60.0;
//     final color = timeLeft > 20 ? Colors.green : timeLeft > 10 ? Colors.orange : Colors.red;
//
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         // The background circular indicator.
//         SizedBox(
//           width: 70,
//           height: 75,
//           child: CircularProgressIndicator(
//             value: progress,
//             strokeWidth: 5,
//             backgroundColor: const Color(0xFFE5E7EB),
//             valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
//           ),
//         ),
//         // The text displaying the remaining seconds.
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '$timeLeft',
//               style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white
//               ),
//             ),
//             // const Text(
//             // 'seconds',
//             // style: TextStyle(
//             // fontSize: 14,
//             // color: Colors.white,
//             // ),
//             // ),
//           ],
//         ),
//       ],);
//
//     //   Container(
//     //   margin: const EdgeInsets.all(16),
//     //   child: Column(
//     //     children: [
//     //       Row(
//     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //         children: [
//     //           const Text('Time Left:', style: TextStyle(color: Colors.white)),
//     //           Text('${timeLeft}s', style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
//     //         ],
//     //       ),
//     //       const SizedBox(height: 8),
//     //       LinearProgressIndicator(
//     //         value: progress,
//     //         backgroundColor: Colors.grey[800],
//     //         valueColor: AlwaysStoppedAnimation<Color>(color),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hi/Games/ErrorplayResult.dart';
import 'package:hi/Games/ErrorplayTime.dart';
import 'package:hi/Providers/Games/ErrorHunt/ErrorHuntProvider.dart';

class Errorplay extends ConsumerStatefulWidget {
  final result;
  const Errorplay({Key? key, required this.result}) : super(key: key);

  @override
  ConsumerState<Errorplay> createState() => _ErrorplayState();
}

class _ErrorplayState extends ConsumerState<Errorplay> {
  FlutterTts flutterTts  = FlutterTts();
  int score = 0;
  int errors = 0;
  int timeLeft = 60;

 // "run" should be "runs"

  int curentQuestionIndex = 0;

  Set<int> selectedWords = {};
  bool showFeedback = false;
  bool isCorrect = false;
  var reresult = "";




  Future _speak() async {

    await flutterTts.setLanguage("hi");
    await flutterTts.setPitch(0.6);
    await flutterTts.speak(widget.result[curentQuestionIndex].hindiMean);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speak();
  }




  @override
  Widget build(BuildContext context) {
    print("printTTTTTT");

    late final currentquestion = widget.result[curentQuestionIndex];

    late String currentSentence = currentquestion.hindiMean;
    // List<String> words = ["She", "run", "fast", "in", "the", "race."];
    late final words = currentquestion.words as List<String>;



    void nextquestion(){

      if(widget.result.length -1 == curentQuestionIndex){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>
           ErrorplayResult(
               timeInMinutes: 20,
               accuracy: 40,
               coins: 10,
               correctAnswers: 56,
               totalQuestions: 100)
        ));
      }else{
        setState(() {
          showFeedback = false;
          curentQuestionIndex++;
          _speak();
          // curentQuestionIndex= (currentQuestionIndex + 1) % questionsForLevel.length;
        });
      }


    }


    void checkAnswer(int index, correctWordIndex) {
      setState(() {
        if (index == correctWordIndex) {
          isCorrect = true;
          score += 10;
          showFeedback = true;


        } else {
          isCorrect = false;
          errors++;
          showFeedback = true;
        }
      });


      Future.delayed(const Duration(milliseconds: 1500), () {
        print("delay");
        if (mounted) {
          if(isCorrect){
            nextquestion();
          }else{
            setState(() {
              showFeedback = false;
              // Load next question here
            });
          }

        }
      });
    }



    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button and title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {

                            // Navigator.pop(context)
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ErrorplayResult(
                                timeInMinutes: 20,
                                accuracy: 40,
                                coins: 10,
                                correctAnswers: 56,
                                totalQuestions: 100)
                        ));
                        }
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Grammar Error Hunt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              //       final quest = hunt[0].question;
              // final currentquestion = quest[curentQuestionIndex];
              //
              // String currentSentence = currentquestion.hindiMean;
              // // List<String> words = ["She", "run", "fast", "in", "the", "race."];
              //       final words = currentquestion.words as List<String>;

                      Container(
                      width: double.infinity,
                      height: 680,
                      child: Column(

                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF533483),
                                    Color(0xFF7b2cbf),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF7b2cbf).withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildStatItem('Score', score.toString(), Colors.blue, Icons.star),
                                  Container(
                                    width: 1,
                                    height: 50,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  _buildStatItem('Errors', errors.toString(), Colors.pink, Icons.close),
                                  Container(
                                    width: 1,
                                    height: 50,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  // _buildTimerCircle(),
                                  Container(
                                    width: 70,
                                    height: 90,
                                    child:   Errorplaytime(),
                                  )

                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 40),

                          // Sentence Display Card
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    currentSentence,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),


                          // Feedback Banner
                          if (showFeedback)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isCorrect
                                      ? [Color(0xFF00b894), Color(0xFF00cec9)]
                                      : [Color(0xFFe74c3c), Color(0xFFc0392b)],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isCorrect ? Icons.check_circle : Icons.error,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    isCorrect ? '🎉 Perfect!' : '❌ Try Again!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Word Selection Area

                          Container(
                            // padding: EdgeInsets.all(24),
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 24),

                            decoration: BoxDecoration(
                              color: Color(0xFF1a1a2e),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: Offset(0, -5),
                                ),
                              ],
                            ),

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tap the incorrect word:',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: words.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    String word = entry.value;
                                    int correctWordIndex = currentquestion.errorIndex;
                                    return _buildWordButton(word, index,correctWordIndex, checkAnswer  );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
              // Stats Card

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }



  Widget _buildWordButton(String word, int index, correctWordIndex, checkAnswer) {

    return InkWell(
      onTap: showFeedback ? null : () => checkAnswer(index, correctWordIndex),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2d3561),
              Color(0xFF3d4574),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF3d4574).withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          word,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}