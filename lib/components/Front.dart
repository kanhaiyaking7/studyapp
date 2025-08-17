import 'package:flutter/material.dart';

class Front extends StatelessWidget {


  final VoidCallback onNext;
  // final String data;

 Front({required this.onNext,
   // required this.data
 });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF8F3ED),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  // Background area
                  Positioned.fill(
                    child: Container(
                      color: Colors.white.withOpacity(0.5),
                      child: Stack(
                        children: [
                          // Small clouds
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Image.asset(
                              'assets/images/cloud.png',
                              width: 40,
                              height: 40,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          Positioned(
                            top: 60,
                            right: 40,
                            child: Image.asset(
                              'assets/images/cloud.png',
                              width: 40,
                              height: 40,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          // Yellow dots
                          Positioned(
                            top: 120,
                            left: 110,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFED36A),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 180,
                            right: 90,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFED36A),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          // Education icon
                          Positioned(
                            top: 200,
                            right: 80,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4CAF50),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.school,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          // Main volcano illustration
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Volcano smoke
                                Container(
                                  width: 120,
                                  height: 150,
                                  margin: const EdgeInsets.only(bottom: 0),
                                  child: CustomPaint(
                                    painter: SmokePainter(),
                                  ),
                                ),
                                // Volcano and island
                                SizedBox(
                                  width: 250,
                                  height: 200,
                                  child: CustomPaint(
                                    painter: VolcanoIslandPainter(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom section with text
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F3ED),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Welcome to Kanhaiya',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Hand wave emoji
                  const Icon(
                    Icons.waving_hand,
                    color: Color(0xFFFED36A),
                    size: 30,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'It systematically addresses key areas crucial for effective communication, offering practical strategies and insightful explanations. By delving into the nuances of grammar, vocabulary acquisition,',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Next button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2761),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:ElevatedButton(onPressed: onNext, child:
                       Text(
                        'Next',
                        style: TextStyle(

                          fontSize: 18,
                        ),
                      ),
                      )

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
}

// Custom painter for the smoke effect
class SmokePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw cloud-like smoke shapes
    final Path path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.2, size.height * 0.5,
      size.width * 0.35, size.height * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.4, size.height * 0.2,
      size.width * 0.5, size.height * 0.3,
    );
    path.quadraticBezierTo(
      size.width * 0.6, size.height * 0.1,
      size.width * 0.7, size.height * 0.3,
    );
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.5,
      size.width * 0.6, size.height * 0.7,
    );
    path.close();

    // Add shadow effect
    canvas.drawShadow(path, Colors.grey.withOpacity(0.3), 3, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Custom painter for the volcano and island
class VolcanoIslandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint volcanoPaint = Paint()
      ..color = Colors.grey.shade700
      ..style = PaintingStyle.fill;

    final Paint lavaPaint = Paint()
      ..color = Colors.red.shade700
      ..style = PaintingStyle.fill;

    final Paint islandPaint = Paint()
      ..color = const Color(0xFF8BC34A)
      ..style = PaintingStyle.fill;

    final Paint waterPaint = Paint()
      ..color = const Color(0xFF64B5F6)
      ..style = PaintingStyle.fill;

    final Paint shorePaint = Paint()
      ..color = const Color(0xFFE8A45B)
      ..style = PaintingStyle.fill;

    // Draw water (lake)
    final Path waterPath = Path();
    waterPath.addOval(Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.7),
      width: size.width * 0.9,
      height: size.height * 0.4,
    ));
    canvas.drawPath(waterPath, waterPaint);

    // Draw shore
    final Path shorePath = Path();
    shorePath.addOval(Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.7),
      width: size.width * 0.95,
      height: size.height * 0.45,
    ));
    canvas.drawPath(shorePath, shorePaint);
    canvas.drawPath(waterPath, waterPaint);

    // Draw island
    final Path islandPath = Path();
    islandPath.moveTo(size.width * 0.2, size.height * 0.6);
    islandPath.quadraticBezierTo(
      size.width * 0.35, size.height * 0.4,
      size.width * 0.5, size.height * 0.5,
    );
    islandPath.quadraticBezierTo(
      size.width * 0.7, size.height * 0.4,
      size.width * 0.8, size.height * 0.65,
    );
    islandPath.lineTo(size.width * 0.65, size.height * 0.7);
    islandPath.lineTo(size.width * 0.35, size.height * 0.7);
    islandPath.close();
    canvas.drawPath(islandPath, islandPaint);

    // Draw volcano
    final Path volcanoPath = Path();
    volcanoPath.moveTo(size.width * 0.4, size.height * 0.55);
    volcanoPath.lineTo(size.width * 0.5, size.height * 0.15);
    volcanoPath.lineTo(size.width * 0.6, size.height * 0.55);
    volcanoPath.close();
    canvas.drawPath(volcanoPath, volcanoPaint);

    // Draw lava
    final Path lavaPath = Path();
    lavaPath.moveTo(size.width * 0.48, size.height * 0.15);
    lavaPath.lineTo(size.width * 0.52, size.height * 0.15);
    lavaPath.lineTo(size.width * 0.55, size.height * 0.3);
    lavaPath.lineTo(size.width * 0.45, size.height * 0.3);
    lavaPath.close();
    canvas.drawPath(lavaPath, lavaPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}