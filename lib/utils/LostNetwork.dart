import 'package:flutter/material.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Floating animation for the icon
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    // Pulse animation for the button
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Fade in animation for content
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onTryAgain() {
    // Add your retry logic here
    // For example: check internet connection and navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Checking connection...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.purple.shade50,
              Colors.pink.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated No Internet Icon
                    AnimatedBuilder(
                      animation: _floatingAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _floatingAnimation.value),
                          child: child,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.wifi_off_rounded,
                          size: 100,
                          color: Colors.purple.shade400,
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Title
                    Text(
                      'Oops!',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'No Internet Connection',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Reason/Description
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.purple.shade100,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'It seems like you\'re offline.\nPlease check your internet connection\nand try again.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Animated Try Again Button
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: child,
                        );
                      },
                      child: ElevatedButton(
                        onPressed: _onTryAgain,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade400,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                          shadowColor: Colors.purple.withOpacity(0.5),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.refresh_rounded, size: 24),
                            SizedBox(width: 10),
                            Text(
                              'Try Again',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Decorative elements
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade300,
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}