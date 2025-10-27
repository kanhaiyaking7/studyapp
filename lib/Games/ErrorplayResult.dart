// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
// class ErrorplayResult extends StatefulWidget {
//   final int score;
//   final int errors;
//   final int correctAnswers;
//   final int totalQuestions;
//   final int timeTaken; // in seconds
//
//   const ErrorplayResult({
//     Key? key,
//     required this.score,
//     required this.errors,
//     required this.correctAnswers,
//     required this.totalQuestions,
//     required this.timeTaken,
//   }) : super(key: key);
//
//   @override
//   State<ErrorplayResult> createState() => _ErrorplayResultState();
// }
//
// class _ErrorplayResultState extends State<ErrorplayResult>
//     with TickerProviderStateMixin {
//   late AnimationController _mainController;
//   late AnimationController _confettiController;
//   late AnimationController _starController;
//   late AnimationController _scoreController;
//
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _rotateAnimation;
//   late Animation<int> _scoreCountAnimation;
//
//   List<Confetti> confettiList = [];
//   bool _showContent = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Main animation controller
//     _mainController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _mainController,
//         curve: Interval(0.0, 0.5, curve: Curves.easeOut),
//       ),
//     );
//
//     _slideAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _mainController,
//         curve: Interval(0.2, 0.7, curve: Curves.easeOutCubic),
//       ),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _mainController,
//         curve: Interval(0.3, 0.8, curve: Curves.elasticOut),
//       ),
//     );
//
//     // Confetti animation
//     _confettiController = AnimationController(
//       duration: const Duration(milliseconds: 3000),
//       vsync: this,
//     );
//
//     // Star rotation animation
//     _starController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     )..repeat();
//
//     _rotateAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
//       CurvedAnimation(parent: _starController, curve: Curves.linear),
//     );
//
//     // Score counting animation
//     _scoreController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
//
//     _scoreCountAnimation = IntTween(begin: 0, end: widget.score).animate(
//       CurvedAnimation(
//         parent: _scoreController,
//         curve: Curves.easeOutCubic,
//       ),
//     );
//
//     // Generate confetti
//     _generateConfetti();
//
//     // Start animations
//     Future.delayed(Duration(milliseconds: 100), () {
//       setState(() => _showContent = true);
//       _mainController.forward();
//       _confettiController.forward();
//       _scoreController.forward();
//     });
//   }
//
//   void _generateConfetti() {
//     final random = math.Random();
//     for (int i = 0; i < 50; i++) {
//       confettiList.add(Confetti(
//         x: random.nextDouble(),
//         y: -random.nextDouble() * 0.3,
//         color: _getRandomColor(),
//         size: random.nextDouble() * 10 + 5,
//         rotation: random.nextDouble() * 2 * math.pi,
//         velocity: random.nextDouble() * 2 + 1,
//       ));
//     }
//   }
//
//   Color _getRandomColor() {
//     final colors = [
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.yellow,
//       Colors.purple,
//       Colors.orange,
//       Colors.pink,
//       Colors.teal,
//     ];
//     return colors[math.Random().nextInt(colors.length)];
//   }
//
//   String _getPerformanceText() {
//     double percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
//     if (percentage >= 90) return "Outstanding! 🏆";
//     if (percentage >= 75) return "Excellent! 🌟";
//     if (percentage >= 60) return "Good Job! 👍";
//     if (percentage >= 40) return "Keep Practicing! 💪";
//     return "Try Again! 📚";
//   }
//
//   String _getPerformanceEmoji() {
//     double percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
//     if (percentage >= 90) return "🎉";
//     if (percentage >= 75) return "😊";
//     if (percentage >= 60) return "🙂";
//     if (percentage >= 40) return "😐";
//     return "😔";
//   }
//
//   @override
//   void dispose() {
//     _mainController.dispose();
//     _confettiController.dispose();
//     _starController.dispose();
//     _scoreController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF1a1a2e),
//               Color(0xFF16213e),
//               Color(0xFF0f3460),
//             ],
//           ),
//         ),
//         // decoration: BoxDecoration(
//         //   gradient: LinearGradient(
//         //     begin: Alignment.topLeft,
//         //     end: Alignment.bottomRight,
//         //     colors: [
//         //       Color(0xFF667eea),
//         //       Color(0xFF764ba2),
//         //       Color(0xFFf093fb),
//         //     ],
//         //   ),
//         // ),
//         child: Stack(
//           children: [
//             _buildConfetti(),
//             SafeArea(
//               child: AnimatedBuilder(
//                 animation: _mainController,
//                 builder: (context, child) {
//                   return Opacity(
//                     opacity: _fadeAnimation.value,
//                     child: Transform.translate(
//                       offset: Offset(0, _slideAnimation.value),
//                       child: _buildContent(),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildConfetti() {
//     return AnimatedBuilder(
//       animation: _confettiController,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: ConfettiPainter(
//             confettiList: confettiList,
//             progress: _confettiController.value,
//           ),
//           size: Size.infinite,
//         );
//       },
//     );
//   }
//
//   Widget _buildContent() {
//     return Column(
//       children: [
//         _buildHeader(),
//         Expanded(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 _buildMainScoreCard(),
//                 SizedBox(height: 24),
//                 _buildStatsGrid(),
//                 SizedBox(height: 24),
//                 _buildPerformanceCard(),
//                 SizedBox(height: 32),
//                 _buildActionButtons(),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: IconButton(
//               icon: Icon(Icons.close, color: Colors.white),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Text(
//                 "Game Over!",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 48),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMainScoreCard() {
//     return AnimatedBuilder(
//       animation: _scaleAnimation,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _scaleAnimation.value,
//           child: Container(
//             padding: EdgeInsets.all(32),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(32),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   blurRadius: 30,
//                   offset: Offset(0, 15),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 AnimatedBuilder(
//                   animation: _rotateAnimation,
//                   builder: (context, child) {
//                     return Transform.rotate(
//                       angle: _rotateAnimation.value,
//                       child: Container(
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
//                           ),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xFFFFD700).withOpacity(0.5),
//                               blurRadius: 20,
//                               spreadRadius: 5,
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Icons.star,
//                           size: 60,
//                           color: Colors.white,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 24),
//                 Text(
//                   "Your Score",
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 AnimatedBuilder(
//                   animation: _scoreCountAnimation,
//                   builder: (context, child) {
//                     return ShaderMask(
//                       shaderCallback: (bounds) => LinearGradient(
//                         colors: [Color(0xFF667eea), Color(0xFFf093fb)],
//                       ).createShader(bounds),
//                       child: Text(
//                         "${_scoreCountAnimation.value}",
//                         style: TextStyle(
//                           fontSize: 72,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//                     ),
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: Text(
//                     _getPerformanceText(),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildStatsGrid() {
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       mainAxisSpacing: 16,
//       crossAxisSpacing: 16,
//       childAspectRatio: 2,
//       children: [
//         _buildStatCard(
//           "Correct",
//           "${widget.correctAnswers}",
//           Icons.check_circle,
//           // [Color(0xFF11998e), Color(0xFF38ef7d)],
//           [ Color(0xFF16213e),
//             Color(0xFF0f3460)]
//         ),
//         _buildStatCard(
//           "Wrong",
//           "${widget.errors}",
//           Icons.cancel,
//           [Color(0xFFff6b6b), Color(0xFFee5a6f)],
//         ),
//         _buildStatCard(
//           "Total",
//           "${widget.totalQuestions}",
//           Icons.quiz,
//           [Color(0xFF4facfe), Color(0xFF00f2fe)],
//         ),
//         _buildStatCard(
//           "Time",
//           "${widget.timeTaken}s",
//           Icons.timer,
//           [Color(0xFFf093fb), Color(0xFFf5576c)],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStatCard(String label, String value, IconData icon, List<Color> colors) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: colors),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: colors[0].withOpacity(0.3),
//             blurRadius: 15,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: Colors.white, size: 32),
//           SizedBox(height: 2),
//           Text(
//             value,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.9),
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPerformanceCard() {
//     double percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Accuracy Rate",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF2D3748),
//                 ),
//               ),
//               SizedBox(width: 8),
//               Text(
//                 _getPerformanceEmoji(),
//                 style: TextStyle(fontSize: 24),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 width: 150,
//                 height: 150,
//                 child: CircularProgressIndicator(
//                   value: percentage / 100,
//                   strokeWidth: 12,
//                   backgroundColor: Colors.grey[200],
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     percentage >= 75 ? Colors.green : percentage >= 50 ? Colors.orange : Colors.red,
//                   ),
//                 ),
//               ),
//               Column(
//                 children: [
//                   Text(
//                     "${percentage.toStringAsFixed(1)}%",
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF2D3748),
//                     ),
//                   ),
//                   Text(
//                     "Accuracy",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButtons() {
//     return Column(
//       children: [
//         _buildButton(
//           "Play Again",
//           Icons.replay,
//           [Color(0xFF667eea), Color(0xFF764ba2)],
//               () {
//             Navigator.pop(context);
//             // Navigate to game screen again
//           },
//         ),
//         SizedBox(height: 16),
//         _buildButton(
//           "Share Result",
//           Icons.share,
//           [Color(0xFF11998e), Color(0xFF38ef7d)],
//               () {
//             // Share functionality
//           },
//         ),
//         SizedBox(height: 16),
//         _buildButton(
//           "Back to Home",
//           Icons.home,
//           [Color(0xFF4facfe), Color(0xFF00f2fe)],
//               () {
//             Navigator.pop(context);
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildButton(String text, IconData icon, List<Color> colors, VoidCallback onTap) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 18, horizontal: 32),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(colors: colors),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: colors[0].withOpacity(0.4),
//                 blurRadius: 15,
//                 offset: Offset(0, 8),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, color: Colors.white, size: 24),
//               SizedBox(width: 12),
//               Text(
//                 text,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Confetti {
//   double x;
//   double y;
//   Color color;
//   double size;
//   double rotation;
//   double velocity;
//
//   Confetti({
//     required this.x,
//     required this.y,
//     required this.color,
//     required this.size,
//     required this.rotation,
//     required this.velocity,
//   });
// }
//
// class ConfettiPainter extends CustomPainter {
//   final List<Confetti> confettiList;
//   final double progress;
//
//   ConfettiPainter({required this.confettiList, required this.progress});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     for (var confetti in confettiList) {
//       final paint = Paint()
//         ..color = confetti.color.withOpacity(1 - progress)
//         ..style = PaintingStyle.fill;
//
//       final xPos = confetti.x * size.width;
//       final yPos = confetti.y * size.height + (progress * size.height * confetti.velocity);
//
//       canvas.save();
//       canvas.translate(xPos, yPos);
//       canvas.rotate(confetti.rotation + progress * 4 * math.pi);
//
//       final rect = Rect.fromCenter(
//         center: Offset.zero,
//         width: confetti.size,
//         height: confetti.size,
//       );
//       canvas.drawRect(rect, paint);
//       canvas.restore();
//     }
//   }
//
//   @override
//   bool shouldRepaint(ConfettiPainter oldDelegate) => true;
// }
import 'package:flutter/material.dart';

class ErrorplayResult extends StatelessWidget {
  final int timeInMinutes;
  final int accuracy;
  final int coins;
  final int correctAnswers;
  final int totalQuestions;

  const ErrorplayResult({
    Key? key,
    required this.timeInMinutes,
    required this.accuracy,
    required this.coins,
    required this.correctAnswers,
    required this.totalQuestions,
  }) : super(key: key);

  int _calculateStars() {
    if (accuracy >= 80) return 3;
    if (accuracy >= 60) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final stars = _calculateStars();

    return Scaffold(
      backgroundColor: const Color(0xFF2D3250),
      body: SafeArea(
        child: Column(
          children: [
            // Header with close and share buttons
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                  children: [
                    // const SizedBox(height: 20),
                    _buildCurvedStarRating(stars),

                    // Trophy Icon with Glow
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF8B5CF6).withOpacity(0.4),
                            const Color(0xFF8B5CF6).withOpacity(0.2),
                            Colors.transparent,
                          ],
                          stops: const [0.3, 0.6, 1.0],
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF8B5CF6).withOpacity(0.5),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.bolt,
                            color: Color(0xFF8B5CF6),
                            size: 45,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Congratulations Text
                    const Text(
                      'CONGRATULATIONS',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'QUIZ COMPLETED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 5 Star Rating with Curve


                    // const SizedBox(height: 32),

                    // Stats Cards
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.schedule,
                              value: '${timeInMinutes}Min',
                              label: 'Quick',
                              color: const Color(0xFFEF4444),
                              iconBg: const Color(0xFF991B1B),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.check_circle,
                              value: '$accuracy%',
                              label: 'Accuracy',
                              color: const Color(0xFF10B981),
                              iconBg: const Color(0xFF065F46),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.emoji_events,
                              value: '$coins',
                              label: 'X-Coins',
                              color: const Color(0xFFFBBF24),
                              iconBg: const Color(0xFF92400E),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Score Display
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2937),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.stars,
                              color: Color(0xFFFBBF24),
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Score: $correctAnswers/$totalQuestions',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Leaderboard Card

                    // Earn More Coins Message
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Earn more COINS to improve your rank',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    //
                    // const SizedBox(height: 24),

                    // Continue Button
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B5CF6),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),
                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }

  Widget _buildCurvedStarRating(int filledStars) {
    return SizedBox(
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Curved line background
          CustomPaint(
            size: const Size(280, 60),
            painter: CurvePainter(),
          ),
          // Stars positioned on the curve
          SizedBox(
            width: 280,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                // Calculate Y offset for curve (parabola shape)
                double normalizedX = (index - 2) / 2; // -1 to 1
                double yOffset = -(normalizedX * normalizedX) * 20 + 20; // inverted parabola

                return Transform.translate(
                  offset: Offset(0, yOffset),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: index < filledStars
                          ? const Color(0xFFFBBF24)
                          : const Color(0xFF374151),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: index < filledStars
                            ? const Color(0xFFFBBF24)
                            : const Color(0xFF4B5563),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.star,
                      color: index < filledStars
                          ? Colors.white
                          : const Color(0xFF6B7280),
                      size: 32,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}

// Curve Painter for star background
class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF374151)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Create a curved path (inverted parabola)
    path.moveTo(0, size.height * 0.5);

    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.2,
      size.width * 0.5, size.height * 0.1,
    );

    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.2,
      size.width, size.height * 0.5,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}