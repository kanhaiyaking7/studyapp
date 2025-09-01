
import 'package:flutter/material.dart';

class ChapterCompletionScreen extends StatefulWidget {
  final cover;
  const ChapterCompletionScreen({required this.cover});

  @override
  State<ChapterCompletionScreen> createState() => _ChapterCompletionScreenState();
}

class _ChapterCompletionScreenState extends State<ChapterCompletionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with back button
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Chapter 1',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),

              // const SizedBox(height: 10),

              // Main content
              // Expanded(
              //   child: FadeTransition(
              //     opacity: _fadeAnimation,
              //     child: SlideTransition(
              //       position: _slideAnimation,
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           // Achievement icon
              //           // Container(
              //           //   width: 120,
              //           //   height: 120,
              //           //   decoration: BoxDecoration(
              //           //     shape: BoxShape.circle,
              //           //     gradient: LinearGradient(
              //           //       colors: [
              //           //         const Color(0xFF6C5CE7),
              //           //         const Color(0xFF74B9FF),
              //           //       ],
              //           //       begin: Alignment.topLeft,
              //           //       end: Alignment.bottomRight,
              //           //     ),
              //           //     boxShadow: [
              //           //       BoxShadow(
              //           //         color: const Color(0xFF6C5CE7).withOpacity(0.3),
              //           //         blurRadius: 20,
              //           //         spreadRadius: 2,
              //           //       ),
              //           //     ],
              //           //   ),
              //           //   child: const Icon(
              //           //     Icons.check_circle,
              //           //     size: 60,
              //           //     color: Colors.white,
              //           //   ),
              //           // ),
              //
              //
              //           // Stats row
              //           // Row(
              //           //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           //   children: [
              //           //     _buildStatItem(Icons.schedule, 'Time', '25 min'),
              //           //     _buildStatItem(Icons.menu_book, 'Pages', '12'),
              //           //     _buildStatItem(Icons.star, 'Progress', '8%'),
              //           //   ],
              //           // ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Column(
                children: [
                  Image.network(widget.cover.coverUrl,width: 340,height: 350,fit: BoxFit.fill,),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [  Icon(
                      Icons.star_rate,
                      size: 25,

                      color: Colors.yellow,


                    ),
                      const Icon(
                        Icons.star_rate_rounded,
                        size: 25,
                        color: Colors.yellow,

                      ),
                      const Icon(
                        Icons.star_half_rounded,
                        size: 25,
                        color: Colors.yellow,

                      ),],
                  ),



                  // Congratulations text
                  Text(
                    'Congratulations!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'You have successfully completed\nChapter 1',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),


                ],
              ),

              const Spacer(),

              // Continue button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Add navigation logic here
                    print('Continue to next chapter');
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 1),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildStatItem(IconData icon, String label, String value) {
  //   return Column(
  //     children: [
  //       Container(
  //         width: 50,
  //         height: 50,
  //         decoration: BoxDecoration(
  //           color: const Color(0xFF2D2D2D),
  //           borderRadius: BorderRadius.circular(12),
  //           border: Border.all(
  //             color: Colors.white.withOpacity(0.1),
  //           ),
  //         ),
  //         child: Icon(
  //           icon,
  //           color: const Color(0xFF74B9FF),
  //           size: 24,
  //         ),
  //       ),
  //       const SizedBox(height: 8),
  //       Text(
  //         label,
  //         style: TextStyle(
  //           color: Colors.white.withOpacity(0.6),
  //           fontSize: 12,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //       const SizedBox(height: 4),
  //       Text(
  //         value,
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}