import 'package:flutter/material.dart';
import 'dart:math' as math;

class TranslationMatchResult extends StatelessWidget {
  final int overallPercentage;
  final String levelName;
  final int vocabularyPercentage;
  final int grammarPercentage;
  final int speedPercentage;
  final int understandingPercentage;
  final int daysRequired;
  final int minutesPerDay;

  const TranslationMatchResult({
    Key? key,
    required this.overallPercentage,
    required this.levelName,
    required this.vocabularyPercentage,
    required this.grammarPercentage,
    required this.speedPercentage,
    required this.understandingPercentage,
    required this.daysRequired,
    required this.minutesPerDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Circular Progress Indicator
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: CustomPaint(
                        painter: CircularProgressPainter(
                          percentage: overallPercentage,
                          color: const Color(0xFF6C63FF),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '$overallPercentage%',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          levelName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Category Performance Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildCategoryCard(
                        icon: '📚',
                        label: 'Vocabulary',
                        percentage: vocabularyPercentage,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildCategoryCard(
                        icon: '✏️',
                        label: 'Grammar',
                        percentage: grammarPercentage,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildCategoryCard(
                        icon: '⚡',
                        label: 'Speed',
                        percentage: speedPercentage,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildCategoryCard(
                        icon: '💡',
                        label: 'Understanding',
                        percentage: understandingPercentage,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Perfection Goal Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF6C63FF),
                        Color(0xFF8B7CFF),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Want to achieve\nperfection?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Here\'s what you need to do   Daily Study',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6C63FF).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.schedule,
                                      color: Color(0xFF6C63FF),
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$minutesPerDay Min',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1A1A2E),
                                        ),
                                      ),
                                      const Text(
                                        'per day',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFBBF24).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.calendar_today,
                                      color: Color(0xFFFBBF24),
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$daysRequired Days',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1A1A2E),
                                        ),
                                      ),
                                      const Text(
                                        'duration',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Learning Journey Section
                const Text(
                  'Your personalized English learning\njourney will include',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF9CA3AF),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                // Learning Methods Grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLearningMethod(
                      icon: Icons.play_circle_filled,
                      label: 'Videos',
                      color: const Color(0xFFEC4899),
                    ),
                    _buildLearningMethod(
                      icon: Icons.sports_esports,
                      label: 'Games',
                      color: const Color(0xFF8B5CF6),
                    ),
                    _buildLearningMethod(
                      icon: Icons.quiz,
                      label: 'Quizzes',
                      color: const Color(0xFF3B82F6),
                    ),
                    _buildLearningMethod(
                      icon: Icons.menu_book,
                      label: 'Vocab',
                      color: const Color(0xFF10B981),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Action Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Start Learning Journey',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF374151)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: const Text(
                      'Review Results',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String icon,
    required String label,
    required int percentage,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2D3250),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$percentage%',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningMethod({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                color.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9CA3AF),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Circular Progress Painter
class CircularProgressPainter extends CustomPainter {
  final int percentage;
  final Color color;

  CircularProgressPainter({
    required this.percentage,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = const Color(0xFF2D3250)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 6, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          color,
          color.withOpacity(0.6),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final sweepAngle = (percentage / 100) * 2 * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 6),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}