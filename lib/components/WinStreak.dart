
import 'package:flutter/material.dart';

class WinStreak extends StatefulWidget {
  final int currentStreak;
  final List<bool> weeklyProgress;
  final VoidCallback? onContinue;

  const WinStreak({
    Key? key,
    this.currentStreak = 3,
    this.weeklyProgress = const [true, true, true, false, false, false, false],
    this.onContinue,
  }) : super(key: key);

  @override
  State<WinStreak> createState() => _WinStreakState();
}

class _WinStreakState extends State<WinStreak>
    with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late AnimationController _streakAnimationController;
  late AnimationController _pulseAnimationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _streakCountAnimation;
  late Animation<double> _pulseAnimation;

  final List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<String> weekDaysFull = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  void initState() {
    super.initState();

    // Main animation controller
    _mainAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Streak counter animation
    _streakAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Pulse animation for active streak
    _pulseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
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

    _streakCountAnimation = Tween<double>(
      begin: 0.0,
      end: widget.currentStreak.toDouble(),
    ).animate(CurvedAnimation(
      parent: _streakAnimationController,
      curve: Curves.easeOutBack,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseAnimationController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _mainAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _streakAnimationController.forward();
    });

    // Start pulse animation and repeat
    _pulseAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _mainAnimationController.dispose();
    _streakAnimationController.dispose();
    _pulseAnimationController.dispose();
    super.dispose();
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
                        // Header
                        // _buildHeader(),

                        const Spacer(flex: 1),

                        // Main streak content
                        _buildStreakContent(),

                        const SizedBox(height: 40),

                        // Weekly progress
                        _buildWeeklyProgress(),

                        const SizedBox(height: 32),

                        // Motivational text
                        _buildMotivationalText(),

                        const Spacer(flex: 2),

                        // Continue button
                        _buildContinueButton(),

                        const SizedBox(height: 3),
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
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        const Text(
          'Your Streak',
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

  Widget _buildStreakContent() {
    return Column(
      children: [
        // Fire icon with animation
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.orange.withOpacity(0.3),
                      Colors.red.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_fire_department,
                  size: 80,
                  color: Colors.orange,
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // Streak counter with animation
        AnimatedBuilder(
          animation: _streakCountAnimation,
          builder: (context, child) {
            return Column(
              children: [
                Text(
                  '${_streakCountAnimation.value.round()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
                const Text(
                  'Day Streak',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildWeeklyProgress() {
    return Column(
      children: [
        const Text(
          'This Week',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final isCompleted = widget.weeklyProgress[index];
            final isToday = index == 3; // Assuming today is Wednesday

            return AnimatedContainer(
              duration: Duration(milliseconds: 200 + (index * 100)),
              curve: Curves.easeOutBack,
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.green
                          : isToday
                          ? Colors.orange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: isToday
                          ? Border.all(color: Colors.orange, width: 2)
                          : null,
                    ),
                    child: isCompleted
                        ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 24,
                    )
                        : isToday
                        ? const Icon(
                      Icons.today,
                      color: Colors.orange,
                      size: 20,
                    )
                        : null,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weekDays[index],
                    style: TextStyle(
                      color: isCompleted || isToday
                          ? Colors.white
                          : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMotivationalText() {
    return Container(


      child: Row(
        children: [

          const SizedBox(width: 16),
          const Expanded(
            child: Text(
             'Practice having a conversation every day. Learn or review new words to keep your learning streak going.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          widget.onContinue?.call();
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: Colors.orange.withOpacity(0.3),
        ),
        child: const Text(
          'Continue Learning',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// Demo app to showcase the WinStreak widget
class WinStreakDemo extends StatefulWidget {
  const WinStreakDemo({Key? key}) : super(key: key);

  @override
  State<WinStreakDemo> createState() => _WinStreakDemoState();
}

class _WinStreakDemoState extends State<WinStreakDemo> {
  int currentStreak = 5;
  List<bool> weekProgress = [true, true, true, true, true, false, false];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WinStreak Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1a1a1a),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        appBar: AppBar(
          title: const Text('Study App - Streak Demo'),
          backgroundColor: const Color(0xFF2a2a2a),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Your Learning Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WinStreak(
                        currentStreak: currentStreak,
                        weeklyProgress: weekProgress,
                        onContinue: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Keep up the great work!'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.local_fire_department),
                label: const Text('View Your Streak'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentStreak++;
                    // Update today's progress
                    weekProgress[4] = true; // Friday
                  });
                },
                child: const Text('Complete Today\'s Practice'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}