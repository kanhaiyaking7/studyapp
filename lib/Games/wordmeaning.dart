
import 'package:flutter/material.dart';
import 'dart:math';

class FindWordMeaningGame extends StatefulWidget {
  const FindWordMeaningGame({Key? key}) : super(key: key);

  @override
  State<FindWordMeaningGame> createState() => _FindWordMeaningGameState();
}

class _FindWordMeaningGameState extends State<FindWordMeaningGame>
    with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool showResult = false;
  bool isCorrect = false;
  int score = 0;
  int lives = 3;
  int streak = 0;

  late AnimationController _cardController;
  late AnimationController _resultController;
  late Animation<double> _cardAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _resultController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _cardAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.elasticOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _resultController, curve: Curves.easeOutBack));

    _cardController.forward();
    _shuffleCurrentOptions();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  final List<WordQuestion> questions = [
    WordQuestion(
      hindi: "किताब",
      romanized: "kitaab",
      correctAnswer: "Book",
      wrongAnswers: ["Pen", "Table", "Chair"],
      category: "Objects",
      icon: Icons.menu_book,
    ),
    WordQuestion(
      hindi: "पानी",
      romanized: "paani",
      correctAnswer: "Water",
      wrongAnswers: ["Fire", "Air", "Earth"],
      category: "Elements",
      icon: Icons.water_drop,
    ),
    WordQuestion(
      hindi: "खुश",
      romanized: "khush",
      correctAnswer: "Happy",
      wrongAnswers: ["Sad", "Angry", "Tired"],
      category: "Emotions",
      icon: Icons.sentiment_very_satisfied,
    ),
    WordQuestion(
      hindi: "दौड़ना",
      romanized: "daudna",
      correctAnswer: "Run",
      wrongAnswers: ["Walk", "Jump", "Sit"],
      category: "Actions",
      icon: Icons.directions_run,
    ),
    WordQuestion(
      hindi: "लाल",
      romanized: "laal",
      correctAnswer: "Red",
      wrongAnswers: ["Blue", "Green", "Yellow"],
      category: "Colors",
      icon: Icons.palette,
    ),
    WordQuestion(
      hindi: "घर",
      romanized: "ghar",
      correctAnswer: "House",
      wrongAnswers: ["Car", "Tree", "Road"],
      category: "Places",
      icon: Icons.home,
    ),
    WordQuestion(
      hindi: "खाना",
      romanized: "khaana",
      correctAnswer: "Food",
      wrongAnswers: ["Drink", "Sleep", "Play"],
      category: "Actions",
      icon: Icons.restaurant,
    ),
    WordQuestion(
      hindi: "सुंदर",
      romanized: "sundar",
      correctAnswer: "Beautiful",
      wrongAnswers: ["Ugly", "Big", "Small"],
      category: "Adjectives",
      icon: Icons.auto_awesome,
    ),
  ];

  List<String> currentOptions = [];

  WordQuestion get currentQuestion => questions[currentQuestionIndex];

  void _shuffleCurrentOptions() {
    currentOptions = [
      currentQuestion.correctAnswer,
      ...currentQuestion.wrongAnswers,
    ];
    currentOptions.shuffle(Random());
  }

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
                    _buildOptionsGrid(),
                    const SizedBox(height: 30),
                    _buildResultSection(),
                    const SizedBox(height: 20),
                    _buildActionButton(),
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
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const SizedBox(width: 8),
              const Text(
                'Find Word Meaning',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.help_outline, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      'Help',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            children: [
              _buildStatChip(Icons.star, '$score', const Color(0xFFFFD700)),
              const SizedBox(width: 12),
              _buildStatChip(Icons.local_fire_department, '$streak', const Color(0xFFFF6B6B)),
              const SizedBox(width: 12),
              _buildStatChip(Icons.favorite, '$lives', const Color(0xFFE91E63)),
              const Spacer(),
              Text(
                '${currentQuestionIndex + 1}/${questions.length}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return ScaleTransition(
      scale: _cardAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2D2D2D), Color(0xFF3A3A3A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF4A4A4A)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Category and icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    currentQuestion.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A4A4A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    currentQuestion.icon,
                    color: const Color(0xFF6366F1),
                    size: 24,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Image placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF4A4A4A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF6366F1), width: 2),
              ),
              child: const Icon(
                Icons.image,
                color: Colors.grey,
                size: 40,
              ),
            ),

            const SizedBox(height: 24),

            // Hindi word
            Text(
              currentQuestion.hindi,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Romanized text
            Text(
              '(${currentQuestion.romanized})',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 16),

            // Audio button
            GestureDetector(
              onTap: _playAudio,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.volume_up,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'What does this mean in English?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemCount: currentOptions.length,
      itemBuilder: (context, index) {
        return _buildOptionCard(currentOptions[index], index);
      },
    );
  }

  Widget _buildOptionCard(String option, int index) {
    bool isSelected = selectedAnswer == option;
    bool isCorrectOption = option == currentQuestion.correctAnswer;
    bool shouldShowCorrect = showResult && isCorrectOption;
    bool shouldShowWrong = showResult && isSelected && !isCorrectOption;

    Color cardColor;
    Color borderColor;
    Color textColor = Colors.white;

    if (shouldShowCorrect) {
      cardColor = const Color(0xFF1B5E20);
      borderColor = const Color(0xFF4CAF50);
    } else if (shouldShowWrong) {
      cardColor = const Color(0xFF5D1616);
      borderColor = const Color(0xFFFF5722);
    } else if (isSelected) {
      cardColor = const Color(0xFF2D4A87);
      borderColor = const Color(0xFF6366F1);
    } else {
      cardColor = const Color(0xFF2D2D2D);
      borderColor = const Color(0xFF4A4A4A);
    }

    return GestureDetector(
      onTap: showResult ? null : () => _selectOption(option),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: isSelected && !showResult
              ? [
            BoxShadow(
              color: borderColor.withOpacity(0.4),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ]
              : null,
        ),
        child: Row(
          children: [
            if (shouldShowCorrect)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF4CAF50),
                size: 20,
              )
            else if (shouldShowWrong)
              const Icon(
                Icons.cancel,
                color: Color(0xFFFF5722),
                size: 20,
              )
            else if (isSelected)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6366F1),
                    shape: BoxShape.circle,
                  ),
                ),
            if (shouldShowCorrect || shouldShowWrong || isSelected)
              const SizedBox(width: 8),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection() {
    if (!showResult) return const SizedBox.shrink();

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
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
                  isCorrect ? Icons.celebration : Icons.psychology,
                  color: isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFFF9800),
                  size: 28,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCorrect ? 'Excellent! 🎉' : 'Good try! 💪',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      isCorrect
                          ? '+${_getPointsForCorrect()} points'
                          : 'Keep practicing!',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (isCorrect)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '+${_getPointsForCorrect()}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Correct Answer:',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${currentQuestion.hindi} = ${currentQuestion.correctAnswer}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    if (!showResult) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _nextQuestion,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6366F1),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentQuestionIndex < questions.length - 1 ? 'Next Word' : 'Finish Game',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              currentQuestionIndex < questions.length - 1
                  ? Icons.arrow_forward
                  : Icons.flag,
            ),
          ],
        ),
      ),
    );
  }

  void _selectOption(String option) {
    if (showResult) return;

    setState(() {
      selectedAnswer = option;
    });

    // Auto-check after selection
    Future.delayed(const Duration(milliseconds: 500), () {
      _checkAnswer();
    });
  }

  void _checkAnswer() {
    setState(() {
      showResult = true;
      isCorrect = selectedAnswer == currentQuestion.correctAnswer;

      if (isCorrect) {
        score += _getPointsForCorrect();
        streak++;
      } else {
        lives = max(0, lives - 1);
        streak = 0;
        if (lives == 0) {
          _showGameOver();
          return;
        }
      }
    });

    _resultController.forward();
  }

  int _getPointsForCorrect() {
    // Bonus points for streak
    return 10 + (streak * 2);
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        showResult = false;
      });

      _shuffleCurrentOptions();
      _cardController.reset();
      _resultController.reset();
      _cardController.forward();
    } else {
      _showGameComplete();
    }
  }

  void _playAudio() {
    // Simulate audio playback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Playing pronunciation: ${currentQuestion.romanized}'),
        backgroundColor: const Color(0xFFFFD700),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showGameComplete() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D2D2D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.emoji_events, color: Color(0xFFFFD700), size: 28),
            SizedBox(width: 12),
            Text(
              'Game Complete!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Final Score: $score points',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Accuracy: ${((score / (questions.length * 10)) * 100).toInt()}%',
              style: TextStyle(color: Colors.grey[300]),
            ),
            const SizedBox(height: 16),
            const Text(
              '🎯 Great job expanding your vocabulary!',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
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
            child: const Text('Back to Games'),
          ),
        ],
      ),
    );
  }

  void _showGameOver() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D2D2D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.heart_broken, color: Color(0xFFFF5722), size: 28),
            SizedBox(width: 12),
            Text(
              'Game Over',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No lives remaining!',
              style: TextStyle(color: Colors.grey[300]),
            ),
            const SizedBox(height: 8),
            Text(
              'Score: $score points',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
            child: const Text('Try Again'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5722),
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswer = null;
      showResult = false;
      score = 0;
      lives = 3;
      streak = 0;
    });
    _shuffleCurrentOptions();
    _cardController.reset();
    _resultController.reset();
    _cardController.forward();
  }
}

class WordQuestion {
  final String hindi;
  final String romanized;
  final String correctAnswer;
  final List<String> wrongAnswers;
  final String category;
  final IconData icon;

  WordQuestion({
    required this.hindi,
    required this.romanized,
    required this.correctAnswer,
    required this.wrongAnswers,
    required this.category,
    required this.icon,
  });
}

