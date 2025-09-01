

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/path_provier/Current_Level.dart';
import 'package:hi/Providers/path_provier/Quiz_provider.dart';

class PrevResult extends ConsumerStatefulWidget {
  final int Lesson;
  final Object data;
  final int xpEarned;
  final int coinsEarned;
  final Duration timeTaken;
  final double accuracy;
  final int correctAnswers;
  final int totalQuestions;
  final VoidCallback? onContinue;
  final VoidCallback? onReview;


  const PrevResult({
    Key? key,
    required this.Lesson,
    required this.data,
    this.xpEarned  = 34,
    this.coinsEarned = 25,
    this.timeTaken = const Duration(minutes: 0, seconds: 35),
    this.accuracy = 85.0,
    this.correctAnswers = 8,
    this.totalQuestions = 10,
    this.onContinue,
    this.onReview,
  }) : super(key: key);

  @override
  ConsumerState<PrevResult> createState() => _ResultState();
}

class _ResultState extends ConsumerState<PrevResult> with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late AnimationController _xpAnimationController;
  late AnimationController _coinAnimationController;
  late AnimationController _accuracyAnimationController;
  late AnimationController _celebrationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<int> _xpCountAnimation;
  late Animation<int> _coinCountAnimation;
  late Animation<double> _accuracyProgressAnimation;
  late Animation<double> _celebrationAnimation;




  @override
  void initState() {
    super.initState();


    _initializeAnimations();
    _startAnimations();

    // final data =  ref.read(UserProgress_Provider).completed_level;
    // print(widget.Lesson);
    // info = data[widget.Lesson - 1];
    // print(info.score);
    // print(info.time);
    // xpEarned =info.score;



  }





  void _initializeAnimations() {
    // Main entrance animation
    _mainAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // XP counter animation
    _xpAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Coin counter animation
    _coinAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Accuracy progress animation
    _accuracyAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Celebration animation
    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainAnimationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainAnimationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainAnimationController,
      curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
    ));

    _xpCountAnimation = IntTween(
      begin: 0,
      end: widget.xpEarned,
    ).animate(CurvedAnimation(
      parent: _xpAnimationController,
      curve: Curves.easeOutBack,
    ));

    _coinCountAnimation = IntTween(
      begin: 0,
      end: widget.coinsEarned,
    ).animate(CurvedAnimation(
      parent: _coinAnimationController,
      curve: Curves.bounceOut,
    ));

    _accuracyProgressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.accuracy / 100,
    ).animate(CurvedAnimation(
      parent: _accuracyAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _celebrationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _celebrationController,
      curve: Curves.elasticOut,
    ));
  }

  void _startAnimations() {
    _mainAnimationController.forward();

    Future.delayed(const Duration(milliseconds: 500), () {
      _xpAnimationController.forward();
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      _coinAnimationController.forward();
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      _accuracyAnimationController.forward();
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      _celebrationController.forward();
    });
  }

  void next_lesson(){
    final lev =  ref.read(UserProgress_Provider).Level;
    final scor = ref.read(UserProgress_Provider).score;
    final prev_data = ref.read(UserProgress_Provider).completed_level;
    print(lev);
    print(scor);
    print(prev_data[0].time);




    // ref.read(UserProgress_Provider.notifier).;


    Navigator.pop(context);

  }

  @override
  void dispose() {
    _mainAnimationController.dispose();
    _xpAnimationController.dispose();
    _coinAnimationController.dispose();
    _accuracyAnimationController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  String get _performanceMessage {
    if (widget.accuracy >= 90) return "Excellent work! 🎉";
    if (widget.accuracy >= 80) return "Great job! 👏";
    if (widget.accuracy >= 70) return "Good effort! 👍";
    if (widget.accuracy >= 60) return "Keep practicing! 💪";
    return "Don't give up! 📚";
  }

  Color get _performanceColor {
    if (widget.accuracy >= 90) return Colors.green;
    if (widget.accuracy >= 80) return Colors.blue;
    if (widget.accuracy >= 70) return Colors.orange;
    return Colors.red;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _mainAnimationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // _buildHeader(),
                        // const SizedBox(height: 24),
                        _buildResultHeader(),
                        const SizedBox(height: 32),
                        _buildStatsCards(),
                        // const SizedBox(height: 24),
                        // _buildAccuracySection(),
                        // const SizedBox(height: 32),
                        // _buildPerformanceMessage(),
                        const Spacer(),
                        _buildActionButtons(),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 24,
          ),
        ),
        const Text(
          'Quiz Results',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildResultHeader() {
    return AnimatedBuilder(
      animation: _celebrationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_celebrationAnimation.value * 0.1),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      _performanceColor.withOpacity(0.3),
                      _performanceColor.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  widget.accuracy >= 80 ?  '🎉': '👏',
                  style: TextStyle(
                    fontSize: 80,

                  ),
                  // size: 80,
                  // color: _performanceColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Quiz Completed!',
                style: TextStyle(
                  color: _performanceColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                // '${widget.correctAnswers}/${widget.totalQuestions} Questions Correct',
                'Amazing!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(child: _buildXpCard()),
        const SizedBox(width: 16),
        Expanded(child: _buildCoinsCard()),
        const SizedBox(width: 16),
        Expanded(child: _buildTimeCard()),
      ],
    );
  }

  Widget _buildXpCard() {
    return AnimatedBuilder(
      animation: _xpCountAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue,
            // gradient: const LinearGradient(
            //   colors: [Color(0xFF6366f1), Color(0xFF8b5cf6)],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.electric_bolt_outlined,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                '+${_xpCountAnimation.value}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'XP',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCoinsCard() {
    return AnimatedBuilder(
      animation: _coinCountAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFf59e0b), Color(0xFFef4444)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Icon(
                // Icons.monetization_on,
                Icons.signal_cellular_alt_rounded,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                '${_coinCountAnimation.value}\%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Accuracy',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10b981), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.timer,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.timeTaken.inMinutes}:${(widget.timeTaken.inSeconds % 60).toString().padLeft(2, '0')}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Time',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccuracySection() {
    return AnimatedBuilder(
      animation: _accuracyProgressAnimation,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF2a2a2a),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _performanceColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Accuracy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${(widget.accuracy * _accuracyProgressAnimation.value).round()}%',
                    style: TextStyle(
                      color: _performanceColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: _accuracyProgressAnimation.value,
                  backgroundColor: Colors.grey[700],
                  valueColor: AlwaysStoppedAnimation<Color>(_performanceColor),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPerformanceMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: _performanceColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _performanceColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: _performanceColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              _performanceMessage,
              style: TextStyle(
                color: _performanceColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              next_lesson();
              // widget.onContinue?.call();
              // Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              // [Color(0xFFf59e0b),],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              shadowColor: _performanceColor.withOpacity(0.3),
            ),
            child: const Text(
              'Start Next Lesson',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        // const SizedBox(height: 12),
        // SizedBox(
        //   width: double.infinity,
        //   child: OutlinedButton(
        //     onPressed: () {
        //       widget.onReview?.call();
        //     },
        //     style: OutlinedButton.styleFrom(
        //       foregroundColor: Colors.white,
        //       side: const BorderSide(color: Colors.grey, width: 1),
        //       padding: const EdgeInsets.symmetric(vertical: 16),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(16),
        //       ),
        //     ),
        //     child: const Text(
        //       'Review Answers',
        //       style: TextStyle(
        //         fontSize: 16,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

