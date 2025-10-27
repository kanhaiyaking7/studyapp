import 'package:flutter/material.dart';
import 'package:hi/ImageReading/HomeImagereading.dart';
import 'package:hi/ImageReading/Imageresult.dart';

class SeeImageHome extends StatefulWidget {
  final bool isDarkMode;

  const SeeImageHome({Key? key, this.isDarkMode = false}) : super(key: key);

  @override
  State<SeeImageHome> createState() => _SeeImageHomeState();
}

class _SeeImageHomeState extends State<SeeImageHome> {
  // Light Theme Colors
  final lightBg =  const Color(0xFF1A1A1A);
  // const Color(0xFFF8F9FA);
  final lightCardBg = const Color(0xFF2A2A2A);
  final lightTextPrimary = Colors.white;
  // const Color(0xFF2D3748);
  final lightTextSecondary = const Color(0xFF718096);

  // Dark Theme Colors
  final darkBg = const Color(0xFF0F172A);
  final darkCardBg = const Color(0xFF1E293B);
  final darkTextPrimary = const Color(0xFFF1F5F9);
  final darkTextSecondary = const Color(0xFF94A3B8);

  Color get bgColor => widget.isDarkMode ? darkBg : lightBg;
  Color get cardBgColor => widget.isDarkMode ? darkCardBg : lightCardBg;
  Color get textPrimaryColor => widget.isDarkMode ? darkTextPrimary : lightTextPrimary;
  Color get textSecondaryColor => widget.isDarkMode ? darkTextSecondary : lightTextSecondary;

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Daily Life',
      'icon': Icons.home_rounded,
      'color': const Color(0xFF667EEA),
      'gradient': [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      'items': [
        {'title': 'Home Activities', 'progress': 0.8, 'completed': 8, 'total': 10, 'image': '🏠'},
        {'title': 'Daily Routine', 'progress': 0.5, 'completed': 5, 'total': 10, 'image': '⏰'},
        {'title': 'Food & Cooking', 'progress': 0.3, 'completed': 3, 'total': 10, 'image': '🍳'},
      ]
    },
    {
      'title': 'Nature & Animals',
      'icon': Icons.nature_rounded,
      'color': const Color(0xFF10B981),
      'gradient': [const Color(0xFF10B981), const Color(0xFF059669)],
      'items': [
        {'title': 'Wild Animals', 'progress': 0.9, 'completed': 9, 'total': 10, 'image': '🦁'},
        {'title': 'Plants & Trees', 'progress': 0.6, 'completed': 6, 'total': 10, 'image': '🌳'},
      ]
    },
    {
      'title': 'School & Learning',
      'icon': Icons.school_rounded,
      'color': const Color(0xFFF59E0B),
      'gradient': [const Color(0xFFF59E0B), const Color(0xFFD97706)],
      'items': [
        {'title': 'Classroom', 'progress': 0.7, 'completed': 7, 'total': 10, 'image': '📚'},
        {'title': 'Sports & Games', 'progress': 0.4, 'completed': 4, 'total': 10, 'image': '⚽'},
        {'title': 'Art & Creativity', 'progress': 0.2, 'completed': 2, 'total': 10, 'image': '🎨'},
      ]
    },
    {
      'title': 'City & Transport',
      'icon': Icons.location_city_rounded,
      'color': const Color(0xFFEF4444),
      'gradient': [const Color(0xFFEF4444), const Color(0xFFDC2626)],
      'items': [
        {'title': 'Vehicles', 'progress': 0.5, 'completed': 5, 'total': 10, 'image': '🚗'},
        {'title': 'City Life', 'progress': 0.3, 'completed': 3, 'total': 10, 'image': '🏙️'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardBgColor,
                boxShadow: [
                  BoxShadow(
                    color: widget.isDarkMode
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.all(12),
                      //   decoration: BoxDecoration(
                      //     gradient: const LinearGradient(
                      //       colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      //     ),
                      //     borderRadius: BorderRadius.circular(16),
                      //   ),
                      //   child: const Icon(
                      //     Icons.photo_library_rounded,
                      //     color: Colors.white,
                      //     size: 28,
                      //   ),
                      // ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'See Image & Speak',
                              style: TextStyle(
                                color: textPrimaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              'Practice English speaking',
                              style: TextStyle(
                                color: textSecondaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: widget.isDarkMode
                              ? const Color(0xFF0F172A)
                              : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: widget.isDarkMode
                                ? const Color(0xFF334155)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Icon(
                          Icons.notifications_rounded,
                          color: textSecondaryColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Overall Progress Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Your Progress',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '37 / 60 Lessons',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: 37 / 60,
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                  minHeight: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '62%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Categories List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _buildCategorySection(category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(Map<String, dynamic> category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: category['gradient']),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category['icon'],
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category['title'],
                  style: TextStyle(
                    color: textPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: category['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: category['color'].withOpacity(0.3),
                  ),
                ),
                child: Text(
                  '${category['items'].length} Topics',
                  style: TextStyle(
                    color: category['color'],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Category Items
          ...List.generate(category['items'].length, (itemIndex) {
            final item = category['items'][itemIndex];
            return _buildLessonCard(item, category['gradient'], category['color']);
          }),
        ],
      ),
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> item, List<Color> gradient, Color accentColor) {
    final progress = item['progress'] as double;
    final completed = item['completed'] as int;
    final total = item['total'] as int;
    final isCompleted = progress >= 1.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF334155)
              : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: widget.isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Image/Emoji Container
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          gradient[0].withOpacity(0.1),
                          gradient[1].withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: accentColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        item['image'],
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item['title'],
                                style: TextStyle(
                                  color: textPrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (isCompleted)
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: gradient),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.image_rounded,
                              size: 14,
                              color: textSecondaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$completed/$total Story',
                              style: TextStyle(
                                color: textSecondaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: accentColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${(progress * 100).toInt()}%',
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Action Button
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homeimagereading()));
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>SeeImageResult()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradient),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Progress Bar at Bottom
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: widget.isDarkMode
                    ? const Color(0xFF0F172A)
                    : const Color(0xFFF8FAFC),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradient),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}