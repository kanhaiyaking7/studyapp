

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:hi/Games/Errorplay.dart';

class ErrorHunt extends StatefulWidget {
  const ErrorHunt({Key? key}) : super(key: key);

  @override
  _ErrorHuntState createState() => _ErrorHuntState();
}

class _ErrorHuntState extends State<ErrorHunt> with TickerProviderStateMixin {
  // Game state
  int currentLevel = 0;
  int score = 0;
  int streak = 0;
  int currentQuestionIndex = 0;
  bool isGameStarted = false;
  bool isTimedMode = true;
  bool isStreakMode = true;

  // Timer
  Timer? gameTimer;
  int timeLeft = 60;

  // Animation controllers
  late AnimationController _pulseController;
  late AnimationController _streakController;

  // Levels
  final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

  // Sample questions by level
  final Map<int, List<Map<String, dynamic>>> questions = {
    0: [ // Beginner
      {
        'sentence': 'He go to the school every day.',
        'words': ['He', 'go', 'to', 'the', 'school', 'every', 'day.'],
        'errorIndex': 1,
        'correction': 'goes',
        'explanation': 'Subject-verb agreement: "He" requires "goes" not "go"'
      },
      {
        'sentence': 'She have a beautiful car.',
        'words': ['She', 'have', 'a', 'beautiful', 'car.'],
        'errorIndex': 1,
        'correction': 'has',
        'explanation': 'Subject-verb agreement: "She" requires "has" not "have"'
      },
      {
        'sentence': 'They was playing football.',
        'words': ['They', 'was', 'playing', 'football.'],
        'errorIndex': 1,
        'correction': 'were',
        'explanation': 'Subject-verb agreement: "They" requires "were" not "was"'
      }
    ],
    1: [ // Intermediate
      {
        'sentence': 'I will went to the store tomorrow.',
        'words': ['I', 'will', 'went', 'to', 'the', 'store', 'tomorrow.'],
        'errorIndex': 2,
        'correction': 'go',
        'explanation': 'Future tense: "will" + base form of verb, not past tense'
      },
      {
        'sentence': 'She is working here since 2020.',
        'words': ['She', 'is', 'working', 'here', 'since', '2020.'],
        'errorIndex': 1,
        'correction': 'has been',
        'explanation': 'Present perfect continuous for duration with "since"'
      },
      {
        'sentence': 'He bought a expensive watch.',
        'words': ['He', 'bought', 'a', 'expensive', 'watch.'],
        'errorIndex': 2,
        'correction': 'an',
        'explanation': 'Use "an" before vowel sounds'
      }
    ],
    2: [ // Advanced
      {
        'sentence': 'The book, that I read yesterday was interesting.',
        'words': ['The', 'book,', 'that', 'I', 'read', 'yesterday', 'was', 'interesting.'],
        'errorIndex': 1,
        'correction': 'book',
        'explanation': 'No comma needed before restrictive relative clause'
      },
      {
        'sentence': 'Neither the teacher nor the students was happy.',
        'words': ['Neither', 'the', 'teacher', 'nor', 'the', 'students', 'was', 'happy.'],
        'errorIndex': 6,
        'correction': 'were',
        'explanation': 'With "neither...nor", verb agrees with the nearer subject'
      }
    ]
  };

  int selectedWordIndex = -1;
  bool showExplanation = false;
  String feedbackMessage = '';
  Color feedbackColor = Colors.green;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _streakController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    _pulseController.dispose();
    _streakController.dispose();
    super.dispose();
  }

  void startGame() {
    setState(() {
      isGameStarted = true;
      score = 0;
      streak = 0;
      currentQuestionIndex = 0;
      timeLeft = 60;
      showExplanation = false;
      selectedWordIndex = -1;
    });

    if (isTimedMode) {
      startTimer();
    }
  }

  void startTimer() {
    gameTimer?.cancel();
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft--;
      });

      if (timeLeft <= 0) {
        endGame();
      }
    });
  }

  void endGame() {
    gameTimer?.cancel();
    setState(() {
      isGameStarted = false;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D2D2D),
        title: const Text('Game Over!', style: TextStyle(color: Colors.white)),
        content: Text(
          'Final Score: $score\nBest Streak: $streak',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  void checkAnswer(int wordIndex) {
    if (showExplanation) return;

    final currentQuestion = questions[currentLevel]![currentQuestionIndex];
    final isCorrect = wordIndex == currentQuestion['errorIndex'];

    setState(() {
      selectedWordIndex = wordIndex;
      showExplanation = true;

      if (isCorrect) {
        score += 10;
        streak++;
        feedbackMessage = 'Correct! +10 points';
        feedbackColor = Colors.green;
        _pulseController.forward().then((_) => _pulseController.reverse());

        if (streak > 0 && streak % 5 == 0) {
          _streakController.forward().then((_) => _streakController.reverse());
        }
      } else {
        if (isStreakMode) {
          streak = 0;
        }
        feedbackMessage = 'Wrong! Try again';
        feedbackColor = Colors.red;
      }
    });

    // Auto advance after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        nextQuestion();
      }
    });
  }

  void nextQuestion() {
    final questionsForLevel = questions[currentLevel]!;

    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % questionsForLevel.length;
      selectedWordIndex = -1;
      showExplanation = false;
      feedbackMessage = '';
    });
  }

  Widget buildLevelSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: levels.asMap().entries.map((entry) {
          final index = entry.key;
          final level = entry.value;
          final isSelected = currentLevel == index;

          return GestureDetector(
            onTap: () => setState(() => currentLevel = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
                border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
              ),
              child: Text(
                level,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[400],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildGameModeSelector() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Timed Mode (60s)', style: TextStyle(color: Colors.white)),
          subtitle: const Text('Race against time!', style: TextStyle(color: Colors.grey)),
          value: isTimedMode,
          onChanged: (value) => setState(() => isTimedMode = true),
          activeColor: Colors.blue,
        ),
        SwitchListTile(
          title: const Text('Streak Mode', style: TextStyle(color: Colors.white)),
          subtitle: const Text('Keep your streak alive!', style: TextStyle(color: Colors.grey)),
          value: isStreakMode,
          onChanged: (value) => setState(() => isStreakMode = true),
          activeColor: Colors.purple,
        ),
      ],
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
        width: 50,
        height: 45,
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
    fontSize: 14,
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
  } ///


  Widget buildScoreBoard() {
    return Container(
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
          _buildScoreItem('Streak', streak.toString(), Colors.purple),
          _buildScoreItem('Level', levels[currentLevel], Colors.green),
        ],
      ),
    );
  } ///

  Widget _buildScoreItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            final scale = label == 'Score' ? 1.0 + (_pulseController.value * 0.2) : 1.0;
            return Transform.scale(
              scale: scale,
              child: Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildSentence() {
    if (!isGameStarted) return const SizedBox.shrink();

    final currentQuestion = questions[currentLevel]![currentQuestionIndex];
    final words = currentQuestion['words'] as List<String>;
    final errorIndex = currentQuestion['errorIndex'] as int;

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
          const SizedBox(height: 16),
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
                onTap: () => checkAnswer(index),
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
                    'Correction: "${currentQuestion['correction']}"',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentQuestion['explanation'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  } ////

  Widget buildStartScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.quiz,
            size: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          const Text(
            '🧩 Grammar Error Hunt',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Find and fix grammar mistakes!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          buildLevelSelector(),
          buildGameModeSelector(),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>Errorplay()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Start Game',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  } /////

  @override
  Widget build(BuildContext context) {
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
        actions: [
          if (isGameStarted)
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                gameTimer?.cancel();
                setState(() {
                  isGameStarted = false;
                });
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isGameStarted) ...[
              buildTimerBar(),
              buildScoreBoard(),
              buildSentence(),

            ] else ...[
              buildStartScreen(),
            ],
          ],
        ),
      ),
    );
  }
}