import 'package:flutter/material.dart';

class BottomVoiceUI extends StatefulWidget {
  const BottomVoiceUI({Key? key}) : super(key: key);

  @override
  State<BottomVoiceUI> createState() => _BottomVoiceUIState();
}

class _BottomVoiceUIState extends State<BottomVoiceUI>
    with TickerProviderStateMixin {
  bool isRecording = false;
  bool isPlaying = false;
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      _waveController.repeat();
    } else {
      _waveController.stop();
    }
  }

  void _togglePlayback() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 24),

            // Main text display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "I'm good, thanks!",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    '"I\'m good, thanks!"',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Control buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Volume/Speaker button
                _buildCircularButton(
                  icon: isPlaying ? Icons.volume_up : Icons.volume_off,
                  onPressed: _togglePlayback,
                  color: const Color(0xFF2D2D2D),
                  iconColor: Colors.white70,
                ),

                // Main microphone button
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: isRecording ? _pulseAnimation.value : 1.0,
                      child: _buildCircularButton(
                        icon: isRecording ? Icons.stop : Icons.mic,
                        onPressed: _toggleRecording,
                        color: const Color(0xFF4A9EFF),
                        iconColor: Colors.white,
                        size: 80,
                        iconSize: 36,
                        isMain: true,
                      ),
                    );
                  },
                ),

                // Text/Language button
                _buildCircularButton(
                  icon: Icons.text_fields,
                  onPressed: () {
                    // Handle text input
                    print('Text input pressed');
                  },
                  color: const Color(0xFF2D2D2D),
                  iconColor: Colors.white70,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Audio wave visualization (placeholder)
            if (isRecording)
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: WavePainter(_waveController.value),
                      size: const Size(double.infinity, 60),
                    );
                  },
                ),
              ),

            if (isRecording) const SizedBox(height: 16),

            // Status text
            Text(
              isRecording
                  ? 'Recording...'
                  : isPlaying
                  ? 'Playing...'
                  : 'Tap the microphone to start',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    required Color iconColor,
    double size = 60,
    double iconSize = 24,
    bool isMain = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isMain
                ? Colors.white.withOpacity(0.2)
                : Colors.white.withOpacity(0.1),
            width: isMain ? 2 : 1,
          ),
          boxShadow: isMain
              ? [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}

// Custom painter for audio wave visualization
class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A9EFF).withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final centerY = size.height / 2;
    final barWidth = 3.0;
    final spacing = 6.0;
    final barCount = (size.width / (barWidth + spacing)).floor();

    for (int i = 0; i < barCount; i++) {
      final x = i * (barWidth + spacing) + barWidth / 2;
      final heightFactor = (0.3 + 0.7 *
          (0.5 + 0.5 *
              (animationValue * 2 * 3.14159 + i * 0.5))).abs();
      final barHeight = size.height * heightFactor * 0.8;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(x, centerY),
            width: barWidth,
            height: barHeight,
          ),
          const Radius.circular(1.5),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Example usage in a screen
class VoiceScreen extends StatelessWidget {
  const VoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Column(
        children: [
          // Your main content here
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Main Content Area',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom voice UI
          const BottomVoiceUI(),
        ],
      ),
    );
  }
}