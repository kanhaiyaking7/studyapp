import 'package:flutter/material.dart';
import 'dart:async';

class TranslationMatchGame extends StatefulWidget {
  const TranslationMatchGame({Key? key}) : super(key: key);

  @override
  State<TranslationMatchGame> createState() => _TranslationMatchGameState();
}

class _TranslationMatchGameState extends State<TranslationMatchGame>
    with TickerProviderStateMixin {
  bool isListening = false;
  bool showResult = false;
  bool isCorrect = false;
  String userSpeech = "";
  String feedback = "";
  int currentQuestionIndex = 0;
  int score = 0;
  bool showHint = false;

  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;

  // Question data
  final List<Question> questions = [
    Question(
      hindi: "मुझे पानी चाहिए।",
      english: "I need water.",
      grammarHint: "Subject + need + Object",
      pronunciation: "/aɪ niːd ˈwɔːtər/",
      difficulty: "Easy",
    ),
    Question(
      hindi: "वह स्कूल जा रहा है।",
      english: "He is going to school.",
      grammarHint: "Subject + is/am/are + Verb+ing + Object",
      pronunciation: "/hiː ɪz ˈɡoʊɪŋ tuː skuːl/",
      difficulty: "Medium",
    ),
    Question(
      hindi: "मैंने कल किताब पढ़ी थी।",
      english: "I had read the book yesterday.",
      grammarHint: "Subject + had + Past Participle + Object + Time",
      pronunciation: "/aɪ hæd riːd ðə bʊk ˈjestərdeɪ/",
      difficulty: "Hard",
    ),
    Question(
      hindi: "क्या आप मेरी मदद कर सकते हैं?",
      english: "Can you help me?",
      grammarHint: "Can/Could + Subject + Verb + Object?",
      pronunciation: "/kæn juː help miː/",
      difficulty: "Easy",
    ),
    Question(
      hindi: "मैं कल दिल्ली जाऊंगा।",
      english: "I will go to Delhi tomorrow.",
      grammarHint: "Subject + will + Verb + Object + Time",
      pronunciation: "/aɪ wɪl ɡoʊ tuː ˈdeli təˈmɔːroʊ/",
      difficulty: "Medium",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  Question get currentQuestion => questions[currentQuestionIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildQuestionCard(),
                    const SizedBox(height: 30),
                    _buildHintSection(),
                    const SizedBox(height: 30),
                    _buildMicrophoneSection(),
                    const SizedBox(height: 30),
                    _buildResultSection(),
                    const SizedBox(height: 20),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Text(
                'Translation Match',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '$score',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${currentQuestionIndex + 1}/${questions.length}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D2D2D), Color(0xFF3A3A3A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4A4A4A)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  currentQuestion.difficulty,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: _playHindiAudio,
                icon: const Icon(
                  Icons.plus_one_outlined,
                  color: Color(0xFFFFD700),
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Translate to English:',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            currentQuestion.hindi,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.volume_up_rounded,
                color: Color(0xFF6366F1),
                size: 40,
              ),
              const SizedBox(width: 8),
              // Text(
              //   'Speak in English',
              //   style: TextStyle(
              //     color: Colors.grey[400],
              //     fontSize: 14,
              //     fontStyle: FontStyle.italic,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHintSection() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showHint = !showHint;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2D4A87),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF6366F1)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb,
                    color: Color(0xFFFFD700),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Grammar Hint',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    showHint ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          if (showHint) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2332),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF4A5568)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Grammar Formula:',
                    style: TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentQuestion.grammarHint,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // const Text(
                  //   'Pronunciation:',
                  //   style: TextStyle(
                  //     color: Color(0xFFFFD700),
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   currentQuestion.pronunciation,
                  //   style: const TextStyle(
                  //     color: Color(0xFF94A3B8),
                  //     fontSize: 14,
                  //     fontStyle: FontStyle.italic,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMicrophoneSection() {
    return Column(
      children: [
        if (userSpeech.isNotEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF4A4A4A)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'You said:',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  userSpeech,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
        GestureDetector(
          onTap: (){},
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: isListening ? _pulseAnimation.value : 1.0,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: isListening
                          ? [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)]
                          : [const Color(0xFF4CAF50), const Color(0xFF45A049)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isListening
                            ? const Color(0xFFFF6B6B).withOpacity(0.3)
                            : const Color(0xFF4CAF50).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    isListening ? Icons.stop : Icons.mic,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Text(
          isListening ? 'Listening... Tap to stop' : 'Tap to speak',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
        ),
        if (isListening)
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 4,
                      height: 20 + (10 * (_waveController.value + index * 0.3) % 1),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
      ],
    );
  }

  Widget _buildResultSection() {
    if (!showResult) return const SizedBox.shrink();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xFF1B5E20) : const Color(0xFF5D1616),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFFF5722),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.error,
                color: isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFFF5722),
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                isCorrect ? 'Excellent!' : 'Keep Practicing!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Correct Answer:',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            currentQuestion.english,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (feedback.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              feedback,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        if (showResult) ...[
          Expanded(
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Next Question',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ] else ...[
          Expanded(
            child: ElevatedButton(
              onPressed: userSpeech.isNotEmpty ? _checkAnswer : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: userSpeech.isNotEmpty
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFF4A4A4A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'CHECK ANSWER',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color _getDifficultyColor() {
    switch (currentQuestion.difficulty) {
      case 'Easy':
        return const Color(0xFF4CAF50);
      case 'Medium':
        return const Color(0xFFFF9800);
      case 'Hard':
        return const Color(0xFFFF5722);
      default:
        return const Color(0xFF6366F1);
    }
  }

  void _toggleListening() {
    setState(() {
      isListening = !isListening;
      if (isListening) {
        _pulseController.repeat(reverse: true);
        _waveController.repeat();
        _startListening();
      } else {
        _pulseController.stop();
        _waveController.stop();
        _stopListening();
      }
    });
  }

  void _startListening() {
    // Simulate speech recognition
    Timer(const Duration(seconds: 3), () {
      if (isListening) {
        setState(() {
          isListening = false;
          // Simulate different user inputs
          List<String> simulatedInputs = [
            "I need water",
            "I need water.",
            "I want water",
            currentQuestion.english,
          ];
          userSpeech = simulatedInputs[currentQuestionIndex % simulatedInputs.length];
        });
        _pulseController.stop();
        _waveController.stop();
      }
    });
  }

  void _stopListening() {
    // Stop listening logic would go here
  }

  void _playHindiAudio() {
    // Play Hindi audio logic would go here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Playing Hindi pronunciation...'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _checkAnswer() {
    setState(() {
      showResult = true;
      isCorrect = _isAnswerCorrect(userSpeech, currentQuestion.english);

      if (isCorrect) {
        score += 10;
        feedback = "Perfect pronunciation and grammar! 🎉";
      } else {
        feedback = _generateFeedback(userSpeech, currentQuestion.english);
      }
    });
  }

  bool _isAnswerCorrect(String userAnswer, String correctAnswer) {
    // Simple similarity check - in real app, use more sophisticated AI
    String normalizedUser = userAnswer.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
    String normalizedCorrect = correctAnswer.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');

    return normalizedUser == normalizedCorrect;
  }

  String _generateFeedback(String userAnswer, String correctAnswer) {
    // Generate helpful feedback based on common mistakes
    if (userAnswer.toLowerCase().contains('want') && correctAnswer.toLowerCase().contains('need')) {
      return "Close! Try using 'need' instead of 'want' for necessity.";
    }
    return "Grammar and pronunciation need work. Check the hint above! 💪";
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        showResult = false;
        userSpeech = "";
        showHint = false;
      } else {
        _showGameComplete();
      }
    });
  }

  void _showGameComplete() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D2D2D),
        title: const Text(
          '🎉 Game Complete!',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Your final score: $score points\nGreat job practicing English!',
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestionIndex = 0;
                score = 0;
                showResult = false;
                userSpeech = "";
                showHint = false;
              });
            },
            child: const Text('Play Again'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
            ),
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }
}

class Question {
  final String hindi;
  final String english;
  final String grammarHint;
  final String pronunciation;
  final String difficulty;

  Question({
    required this.hindi,
    required this.english,
    required this.grammarHint,
    required this.pronunciation,
    required this.difficulty,
  });
}
