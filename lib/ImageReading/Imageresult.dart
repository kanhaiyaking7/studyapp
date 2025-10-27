import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:hi/ImageReading/ImageReadingHome.dart';

class Imageresult extends StatefulWidget {
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int timeSpent; // in seconds

  const Imageresult({
    Key? key,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    this.timeSpent = 30,
  }) : super(key: key);

  @override
  State<Imageresult> createState() => _ImageresultState();
}

class _ImageresultState extends State<Imageresult>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _starController;
  late Animation<Offset> _slideAnimation;

  int earnedStars = 0;

  @override
  void initState() {
    super.initState();

    // Calculate earned stars based on correct answers percentage
    double percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
    if (percentage >= 80) {
      earnedStars = 3;
    } else if (percentage >= 60) {
      earnedStars = 2;
    } else if (percentage >= 40) {
      earnedStars = 1;
    }

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _starController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _slideController.forward();
    _starController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _starController.dispose();
    super.dispose();
  }

  String _getResultMessage() {
    if (earnedStars == 3) return "बधाई हो! आप बहुत अच्छा कर रहे हैं। 😊";
    if (earnedStars == 2) return "शानदार! आप अच्छे से सीख रहे हैं। 👍";
    if (earnedStars == 1) return "अच्छा प्रयास! और मेहनत करें। 💪";
    return "कोशिश जारी रखें! आप कर सकते हैं। 📚";
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: Color(0xFFe63946),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Quiz result',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child:  Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 10),
                _buildIllustration(),
                SizedBox(height: 25),
                _buildResultMessage(),
                SizedBox(height: 30),
                _buildStatsCards(),
                SizedBox(height: 30),
                // _buildFeedbackCard(),
                 Spacer(),
                // SizedBox(height: 25),
                _buildActionButton(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );

  }

  Widget _buildIllustration() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFe8f5e9),
            Color(0xFFc8e6c9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Image.network('https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/Gemini_Generated_Image_siyl2isiyl2isiyl.webp',
      fit: BoxFit.cover,)

    );
  }

  Widget _buildResultMessage() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2d2d44),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Text(
        _getResultMessage(),
        style: TextStyle(
          color: Color(0xFFffd369),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.check_circle_outline,
            value: '${widget.correctAnswers}/${widget.totalQuestions}',
            label: 'correct',
            color: Color(0xFF4CAF50),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: _buildStatCard(
            icon: Icons.star_border,
            value: '${(widget.correctAnswers / widget.totalQuestions * 10).toStringAsFixed(1)}/10',
            label: 'Rating',
            color: Color(0xFF9c27b0),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: _buildStatCard(
            icon: Icons.timer_outlined,
            value: _formatTime(widget.timeSpent),
            label: 'Duration',
            color: Color(0xFFf44336),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFF2d2d44),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard() {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00b894).withOpacity(0.2),
            Color(0xFF00cec9).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF00b894).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final isEarned = index < earnedStars;

              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 800),
                // delay: Duration(milliseconds: index * 200),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: isEarned
                            ? LinearGradient(
                          colors: [Color(0xFFffd369), Color(0xFFff9a3c)],
                        )
                            : null,
                        color: isEarned ? null : Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                        boxShadow: isEarned
                            ? [
                          BoxShadow(
                            color: Color(0xFFffd369).withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ]
                            : [],
                      ),
                      child: Icon(
                        Icons.star,
                        size: 32,
                        color: isEarned ? Colors.white : Colors.white30,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          SizedBox(height: 20),
          Text(
            'बधाईस्स दोस्तोमोयो! आपको तारांविश्यूलिश्यन\nजन्तेन?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFF2d2d44),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, color: Color(0xFF00d9ff), size: 18),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'আপনার উত্তর: ১৮-৩০ বছরীয়া, ২১+ রাবি',
                    style: TextStyle(
                      color: Color(0xFF00d9ff),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00b894), Color(0xFF00cec9)],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF00b894).withOpacity(0.4),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SeeImageHome()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

extension DelayedAnimation on TweenAnimationBuilder {
  static Widget delayed({
    required Duration delay,
    required Widget child,
  }) {
    return FutureBuilder(
      future: Future.delayed(delay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return child;
        }
        return SizedBox.shrink();
      },
    );
  }
}