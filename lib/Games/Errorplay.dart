

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/Games/ErrorHunt/ErrorHuntProvider.dart';

class Errorplay extends ConsumerStatefulWidget {
  const Errorplay({super.key});

  @override
  ConsumerState<Errorplay> createState() => _ErrorplayState();
}

class _ErrorplayState extends ConsumerState<Errorplay>  {

  int currentLevel = 0;
  int score = 0;
  int streak = 0;
  // int currentQuestionIndex = 0;
  bool isGameStarted = false;
  bool isTimedMode = true;
  bool isStreakMode = true;
  int curentQuestionIndex = 0;

  // Timer
  var gameTimer;
  int timeLeft = 60;

  // Sample questions by level
  // final Map<int, List<Map<String, dynamic>>> questions = {
  //   0: [ // Beginner
  //     {
  //       'sentence': 'He go to the school every day.',
  //       'words': ['He', 'go', 'to', 'the', 'school', 'every', 'day.'],
  //       'hindi_mean':'वह हर दिन स्कूल जाता है.',
  //       'errorIndex': 1,
  //       'correction': 'goes',
  //       'explanation': 'Subject-verb agreement: "He" requires "goes" not "go"'
  //     },
  //     {
  //       'sentence': 'She have a beautiful car.',
  //       'words': ['She', 'have', 'a', 'beautiful', 'car.'],
  //       'errorIndex': 1,
  //       'correction': 'has',
  //       'explanation': 'Subject-verb agreement: "She" requires "has" not "have"'
  //     },
  //     {
  //       'sentence': 'They was playing football.',
  //       'words': ['They', 'was', 'playing', 'football.'],
  //       'errorIndex': 1,
  //       'correction': 'were',
  //       'explanation': 'Subject-verb agreement: "They" requires "were" not "was"'
  //     }
  //   ],
  //   1: [ // Intermediate
  //     {
  //       'sentence': 'I will went to the store tomorrow.',
  //       'words': ['I', 'will', 'went', 'to', 'the', 'store', 'tomorrow.'],
  //       'errorIndex': 2,
  //       'correction': 'go',
  //       'explanation': 'Future tense: "will" + base form of verb, not past tense'
  //     },
  //     {
  //       'sentence': 'She is working here since 2020.',
  //       'words': ['She', 'is', 'working', 'here', 'since', '2020.'],
  //       'errorIndex': 1,
  //       'correction': 'has been',
  //       'explanation': 'Present perfect continuous for duration with "since"'
  //     },
  //     {
  //       'sentence': 'He bought a expensive watch.',
  //       'words': ['He', 'bought', 'a', 'expensive', 'watch.'],
  //       'errorIndex': 2,
  //       'correction': 'an',
  //       'explanation': 'Use "an" before vowel sounds'
  //     }
  //   ],
  //   2: [ // Advanced
  //     {
  //       'sentence': 'The book, that I read yesterday was interesting.',
  //       'words': ['The', 'book,', 'that', 'I', 'read', 'yesterday', 'was', 'interesting.'],
  //       'errorIndex': 1,
  //       'correction': 'book',
  //       'explanation': 'No comma needed before restrictive relative clause'
  //     },
  //     {
  //       'sentence': 'Neither the teacher nor the students was happy.',
  //       'words': ['Neither', 'the', 'teacher', 'nor', 'the', 'students', 'was', 'happy.'],
  //       'errorIndex': 6,
  //       'correction': 'were',
  //       'explanation': 'With "neither...nor", verb agrees with the nearer subject'
  //     }
  //   ]
  // };

  int selectedWordIndex = -1;
  bool showExplanation = false;
  String feedbackMessage = '';
  Color feedbackColor = Colors.green;

  void nextQuestion(currentquestion) {
    // final questionsForLevel = questions[currentLevel]!;

    setState(() {

      curentQuestionIndex++;
      // curentQuestionIndex= (currentQuestionIndex + 1) % questionsForLevel.length;
      selectedWordIndex = -1;
      showExplanation = false;
      feedbackMessage = '';
    });
  }
  // Animation controllers
  void checkAnswer(int wordIndex,currentquestion) {
    // if (showExplanation) return;

    final currentQuestion = currentquestion;
    final isCorrect = wordIndex == currentQuestion.errorIndex;

    setState(() {
      selectedWordIndex = wordIndex;
      showExplanation = true;

      if (isCorrect) {
        score += 10;
        streak++;
        feedbackMessage = 'Correct! +10 points';
        showExplanation = true;

      } else {
        if (isStreakMode) {
          streak = 0;
        }
        showExplanation = true;
        feedbackMessage = 'Wrong! Try again';
        feedbackColor = Colors.red;
      }

      Timer(const Duration(seconds: 3), () {
        if (mounted) {
          nextQuestion(currentquestion);
        }
      });
    });

    // Auto advance after 3 seconds

  }


  @override
  Widget build(BuildContext context) {
    final GrammerHunt = ref.watch(ErrorHuntProvider);
    return Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
    appBar: AppBar(
    backgroundColor: const Color(0xFF2D2D2D),
    title: const Text(
    'Grammar Error Hunt',
    style: TextStyle(color: Colors.white),
    ),
      leading:  IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),

    ),
    body:
        GrammerHunt.when(
            data: (hunt){
              final quest = hunt[0].question;
              final currentquestion = quest[curentQuestionIndex];

              print(currentquestion.words);


              return
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildScoreItem('Score', score.toString(), Colors.blue),
                          _buildScoreItem('Error', streak.toString(), Colors.purple),
                          buildTimerBar(),

                        ],
                      ),
                    ),
                    const SizedBox(height: 80,),

                    Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
                        crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100,
                            alignment: Alignment.center,
                            child: Text(currentquestion.hindiMean,style: TextStyle(color: Colors.white,
                                fontSize: 20),),
                          ),
                        ]
                    ),
                    // Center(
                    //
                    //      child:
                    //      buildSentence(),
                    //    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildSentence(currentquestion),
                        ]
                    )







                  ],
                ),
              );
            },
            error: (e,stack)=>Text('error$e'),
            loading: ()=>CircularProgressIndicator())



    );
  }

  Widget _buildScoreItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color:Colors.white, fontSize: 15)),
        const SizedBox(height: 4),

               Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

      ],
    );
  }
  Widget buildSentence( currentquestion) {


    final words = currentquestion.words as List<String>;

    final errorIndex =currentquestion.errorIndex;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tap the incorrect word:',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: words.asMap().entries.map((entry) {
              final index = entry.key;
              final word = entry.value;
              final isSelected = selectedWordIndex == index;
              final isError = showExplanation && index == errorIndex;
              final isWrongSelection = showExplanation && isSelected && index != errorIndex;

              Color backgroundColor = Colors.grey[800]!;
              Color textColor = Colors.white;

              if (isError) {
                backgroundColor = Colors.red[600]!;
                textColor = Colors.white;
              } else if (isWrongSelection) {
                backgroundColor = Colors.red[800]!;
                textColor = Colors.white;
              } else if (isSelected) {
                backgroundColor = Colors.blue[600]!;
                textColor = Colors.white;
              }

              return GestureDetector(
                onTap: () => checkAnswer(index,currentquestion),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    border: isError ? Border.all(color: Colors.red, width: 2) : null,
                  ),
                  child: Text(
                    word,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: isError ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (showExplanation) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: feedbackColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: feedbackColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feedbackMessage,
                    style: TextStyle(
                      color: feedbackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Correction: "${currentquestion.correction}"',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentquestion.explanation,
                    // currentquestion['explanation'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
  Widget buildTimerBar() {


    final progress = timeLeft / 60.0;
    final color = timeLeft > 20 ? Colors.green : timeLeft > 10 ? Colors.orange : Colors.red;

    return Stack(
      alignment: Alignment.center,
      children: [
        // The background circular indicator.
        SizedBox(
          width: 70,
          height: 75,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 5,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
        ),
        // The text displaying the remaining seconds.
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$timeLeft',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            // const Text(
            // 'seconds',
            // style: TextStyle(
            // fontSize: 14,
            // color: Colors.white,
            // ),
            // ),
          ],
        ),
      ],);

    //   Container(
    //   margin: const EdgeInsets.all(16),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           const Text('Time Left:', style: TextStyle(color: Colors.white)),
    //           Text('${timeLeft}s', style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
    //         ],
    //       ),
    //       const SizedBox(height: 8),
    //       LinearProgressIndicator(
    //         value: progress,
    //         backgroundColor: Colors.grey[800],
    //         valueColor: AlwaysStoppedAnimation<Color>(color),
    //       ),
    //     ],
    //   ),
    // );
  }
}
