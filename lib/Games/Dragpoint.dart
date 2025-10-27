// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hi/Games/TranslationMatchButton.dart';
// import 'package:hi/Providers/Games/TranslationMatch/TransMatch.dart';
//
// class TranslationMatchScreen extends ConsumerStatefulWidget {
//   const TranslationMatchScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<TranslationMatchScreen> createState() => _TranslationMatchScreenState();
// }
//
// class _TranslationMatchScreenState extends ConsumerState<TranslationMatchScreen> {
//   int currentQuestion = 1;
//   int totalQuestions = 5;
//   int score = 0;
//   bool isGrammarHintExpanded = false;
//
//   int currentIndex = 0;
//   // Sample translation data
//   // List<Map<String, String>> translationData = [
//   //   {
//   //     'text': 'मुझे पानी चाहिए।',
//   //     'translation': 'I need water.',
//   //     'hint': 'Use "need" for necessity and "water" is uncountable noun.'
//   //   },
//   //   {
//   //     'text': 'वह स्कूल जाता है।',
//   //     'translation': 'He goes to school.',
//   //     'hint': 'Present simple tense with third person singular.'
//   //   },
//   //   {
//   //     'text': 'यह बहुत अच्छा है।',
//   //     'translation': 'This is very good.',
//   //     'hint': 'Demonstrative pronoun with adjective.'
//   //   },
//   // ];
//
//   // Question(
//
//   // text: "मुझे पानी चाहिए।",
//   // translation: "I need water.",
//   // grammarHint: "Subject + need + Object",
//   // difficulty: "Easy",
//   // ),
//
//
//   complete_speak(){
//     setState(() {
//       currentIndex++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final translationData = ref.watch(Translationprovider);
//     return Scaffold(
//       backgroundColor: const Color(0xFF1E1E1E),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1E1E1E),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text(
//           'Translation Match',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//
//           Container(
//             margin: const EdgeInsets.only(right: 16),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: const Color(0xFF333333),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               '$currentQuestion/$totalQuestions',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: translationData.when(
//           data: (query){
//             final output = query[0].question;
//
//             return
//               Column(
//
//               children: [
//                 // Decorative top section
//                 Container(
//                   width: double.infinity,
//                   height: 4,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                   ),
//                 ),
//
//                 Expanded(
//
//                   child: Padding(
//                     padding: const EdgeInsets.all(23.0),
//                     child: Column(
//                       children: [
//                         // Main translation card
//                         // Expanded(
//                         //
//                         //   flex: 2,
//                         //   child: Container(
//                         //     width: double.infinity,
//                         //     // padding: const EdgeInsets.all(24),
//                         //     decoration: BoxDecoration(
//                         //       color: const Color(0xFF2D2D2D),
//                         //       // color: Colors.orange,
//                         //       borderRadius: BorderRadius.circular(16),
//                         //     ),
//                         //     child:
//                         //     Container(
//                         //       decoration: BoxDecoration(
//                         //         color: const Color(0xFF2D2D2D),
//                         //         // color: Colors.orange,
//                         //         borderRadius: BorderRadius.circular(16),
//                         //       ),
//                         //       child:
//                               Container(
//                                 width: double.infinity,
//                                     height: 300,
//                                     // padding: const EdgeInsets.all(24),
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFF2D2D2D),
//                                       // color: Colors.orange,
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//
//                                 child: Column(
//
//
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     // // Easy badge
//                                     // Align(
//                                     //   alignment: Alignment.topLeft,
//                                     //   child: Container(
//                                     //     padding: const EdgeInsets.symmetric(
//                                     //       horizontal: 18,
//                                     //       vertical: 9,
//                                     //     ),
//                                     //     decoration: BoxDecoration(
//                                     //       color: const Color(0xFF4CAF50),
//                                     //       borderRadius: BorderRadius.circular(20),
//                                     //     ),
//                                     //     child: const Text(
//                                     //       'Easy',
//                                     //       style: TextStyle(
//                                     //         color: Colors.white,
//                                     //         fontWeight: FontWeight.bold,
//                                     //         fontSize: 14,
//                                     //       ),
//                                     //     ),
//                                     //   ),
//                                     // ),
//
//                                     // Score indicator
//                                     Align(
//                                       alignment: Alignment.topRight,
//                                       child: Text(
//                                         '+1',
//                                         style: TextStyle(
//                                           color: Colors.amber[600],
//                                           fontSize:25 ,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//
//                                     // const SizedBox(height: 20),
//
//                                     // Instruction text
//                                     const Text(
//                                       'Translate to English',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//
//                                     const SizedBox(height: 80),
//
//                                     // Text to translate
//                                     Text(
//                                       output[currentIndex].hindi!,
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     const SizedBox(height: 10),
//
//                                     // const SizedBox(height: 30),
//
//                                     // Audio button
//                                     Container(
//                                       width: 60,
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xFF5C6BC0),
//                                         borderRadius: BorderRadius.circular(30),
//                                       ),
//                                       child: IconButton(
//                                         icon: const Icon(
//                                           Icons.volume_up,
//                                           color: Colors.white,
//                                           size: 30,
//                                         ),
//                                         onPressed: () {
//                                           // Handle audio playback
//                                           ScaffoldMessenger.of(context).showSnackBar(
//                                             const SnackBar(
//                                               content: Text('Audio playback'),
//                                               duration: Duration(seconds: 1),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//
//
//                                   ],
//                                 ),
//                               ),
//                         //     ),
//                         //   ),
//                         // ),
//
//                         const SizedBox(height: 80),
//
//                         // Grammar hint section
//                         Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF3949AB),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(12),
//                               onTap: () {
//                                 setState(() {
//                                   isGrammarHintExpanded = !isGrammarHintExpanded;
//                                 });
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16),
//                                 child: Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.lightbulb,
//                                       color: Colors.amber,
//                                       size: 24,
//                                     ),
//                                     const SizedBox(width: 12),
//                                     const Expanded(
//                                       child: Text(
//                                         'Grammar Hint',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                     Icon(
//                                       isGrammarHintExpanded
//                                           ? Icons.keyboard_arrow_up
//                                           : Icons.keyboard_arrow_down,
//                                       color: Colors.white,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         // Hint content (expandable)
//                         if (isGrammarHintExpanded) ...[
//                           const SizedBox(height: 8),
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF2D2D2D),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               output[currentIndex].grammarHint!,
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ],
//
//                         // const SizedBox(height: 40),
//
//                         // Microphone button
//
//
//                         // const SizedBox(height: 12),
//                         //
//                         // const Text(
//                         //   'Tap to speak',
//                         //   style: TextStyle(
//                         //     color: Colors.grey,
//                         //     fontSize: 16,
//                         //   ),
//                         // ),
//                         //
//                         // const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//            width: double.infinity,
//                   height: 200,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF4CAF50),
//
//                   ),
//                   child:
//                   TranslationButton(
//                       messageList: output[currentIndex].english,
//                       complete_speak: complete_speak
//                   ),
//
//
//
//
//                   // IconButton(
//                   //   icon: const Icon(
//                   //     Icons.mic,
//                   //     color: Colors.white,
//                   //     size: 36,
//                   //   ),
//                   //   onPressed: () {
//                   //     // Handle voice input
//                   //     ScaffoldMessenger.of(context).showSnackBar(
//                   //       const SnackBar(
//                   //         content: Text('Voice recording started'),
//                   //         duration: Duration(seconds: 2),
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//                 ),
//
//               ],
//             );
//           },
//           error: (e,stack)=>Text('error$e'),
//           loading: ()=>CircularProgressIndicator()),
//
//
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hi/Games/SpeakButt.dart';
import 'package:hi/Games/TranslationResult.dart';
import 'package:hi/Providers/Games/TranslationMatch/TransMatch.dart';
import 'dart:math' as math;



class TranslationMatchScreen extends ConsumerStatefulWidget {
  final output;
  const TranslationMatchScreen({Key? key, required this.output}) : super(key: key);

  @override
  ConsumerState<TranslationMatchScreen> createState() => _TranslationMatchScreenState();
}

class _TranslationMatchScreenState extends ConsumerState<TranslationMatchScreen>
    with TickerProviderStateMixin {
  int score = 0;
  int currentQuestion = 0;
  int totalQuestions = 5;
  bool showHint = false;
  // late var hindiText = "मुझे पानी चाहिए।";
  String difficulty = "Easy";
  int currentIndex = 0;
  // String _hintText = "";
  // String   _Englishword = "";

  late AnimationController _cardController;
  late AnimationController _scoreController;
  late AnimationController _pulseController;
  late Animation<double> _cardAnimation;
  late Animation<double> _scoreAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _speak();

    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _cardAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.elasticOut,
    );

    _scoreAnimation = CurvedAnimation(
      parent: _scoreController,
      curve: Curves.easeOutBack,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _cardController.forward();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _scoreController.dispose();
    _pulseController.dispose();
    super.dispose();
  }


  FlutterTts flutterTts  = FlutterTts();

  Future _speak() async {

    await flutterTts.setLanguage("hi");
    await flutterTts.setPitch(0.6);
    await flutterTts.speak(widget.output[currentIndex].hindi);
  }

   _onAnswerSubmitted() {
    setState(() {
      print("dododood");

      score++;
      _scoreController.forward(from: 0);
      if (currentQuestion < totalQuestions) {
        print("aaaaaaaaaaaaa");
        currentQuestion++;
        currentIndex++;
        _speak();
        _cardController.forward(from: 0);
      }else{
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>)
      }
    });
  }

 //  late String hindiText =   widget.output[currentIndex].hindi;
 //   late String  _hintText =   widget.output[currentIndex].grammarHint;
 // late String  _Englishword =   widget.output[currentIndex].english;


  @override
  Widget build(BuildContext context) {

     String hindiText =   widget.output[currentIndex].hindi;
     String  hintText =   widget.output[currentIndex].grammarHint;
     String Tence =   widget.output[currentIndex].Rule;
     String  _Englishword =   widget.output[currentIndex].english;

    print(currentIndex);
    print(hindiText);




    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6366F1),
              Color(0xFF8B5CF6),
              // Color(0xFFEC4899),
            ],
          ),
        ),
        child:
            SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildProgressIndicator(),
                        SizedBox(height: 30),
                        _buildQuestionCard(hindiText),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              showHint = !showHint;
                            });
                          },
                          child: Container(
                            // color: Colors.black,
                              child: _buildHintButton(hintText, Tence, _Englishword)),
                        ),
                        // _buildHintButton(),
                          // child:  Speakbutt(messageList: _Englishword, complete_speak: _onAnswerSubmitted),
                        // Spacer(),
                        // _buildMicrophoneButton(),
                        // SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 40),
                Speakbutt(english_word: _Englishword,sucessfully_speak: _onAnswerSubmitted,),

              ],
            ),
          ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                TranslationMatchResult(
                    overallPercentage: 45,
                    levelName: "first",
                    vocabularyPercentage: 55,
                    grammarPercentage: 33,
                    speedPercentage: 77,
                    understandingPercentage: 33,
                    daysRequired: 22, minutesPerDay: 66)
                    // TranslationMatchResult(score: 50, totalQuestions: 100, correctAnswers: 66)
                ));
              },
            ),
          ),
          SizedBox(width: 16),
          Text(
            'Translation Match',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Spacer(),
          // ScaleTransition(
          //   scale: _scoreAnimation,
          //   child: Container(
          //     // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //     decoration: BoxDecoration(
          //       color: Color(0xFF10B981),
          //       borderRadius: BorderRadius.circular(20),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Color(0xFF10B981).withOpacity(0.5),
          //           blurRadius: 12,
          //           spreadRadius: 2,
          //         ),
          //       ],
          //     ),
          //     child: Row(
          //       children: [
          //         Icon(Icons.star, color: Colors.white, size: 10),
          //         SizedBox(width: 4),
          //         Text(
          //           '$score',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 15,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(width: 35),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$currentQuestion/$totalQuestions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      children: [
        Row(
          children: List.generate(totalQuestions, (index) {
            bool isCompleted = index < currentQuestion - 1;
            bool isCurrent = index == currentQuestion - 1;

            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: isCompleted
                      ? Color(0xFF10B981)
                      : isCurrent
                      ? Colors.white
                      : Colors.white.withOpacity(0.3),
                  boxShadow: isCurrent
                      ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                      : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(hindiText) {
    return ScaleTransition(
      scale: _cardAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 30,
              spreadRadius: 5,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    difficulty,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '+1',
                        style: TextStyle(
                          color: Color(0xFFD97706),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.star,
                        color: Color(0xFFD97706),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Translate to English:',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
              ).createShader(bounds),
              child: Text(
                hindiText,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: Icon(Icons.volume_up, color: Color(0xFF6366F1)),
                iconSize: 32,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHintButton( hintText, Tence, _Englishword) {
    return
        Container(

            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: showHint
                  ? LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
              )
                  : LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1)
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Grammar Hint',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                if (showHint)

                  Padding(

                    padding: const EdgeInsets.only(top: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Tence,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          hintText,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          _Englishword,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Icon(
                //   showHint ? Icons.expand_less : Icons.expand_more,
                //   color: Colors.white,
                // ),
              ],
            ),
          );



  }


}