
// import 'package:flutt/features/auth/pages/signup.dart';
// import 'package:flutt/features/auth/provider/User_provider.dart';
// import 'package:flutt/features/auth/provider/user_state.dart';
// import 'package:flutt/features/auth/repository/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/features/auth/pages/signup.dart';
import 'package:hi/features/auth/provider/User_provider.dart';
import 'package:hi/pages/Navbar.dart';

class EnglishLevel extends ConsumerStatefulWidget {
  const EnglishLevel({Key? key}) : super(key: key);

  @override
  ConsumerState<EnglishLevel> createState() => _EnglishLevelState();
}

class _EnglishLevelState extends ConsumerState<EnglishLevel> {
  String? selectedLevel;

  final List<Map<String, dynamic>> levels = [
    {
      'id': 'beginner',
      'title': 'Beginner',
      'description': "I'm just starting to learn English.",
      'icon': Icons.eco,
      'color': const Color(0xFF4CAF50),
    },
    {
      'id': 'intermediate',
      'title': 'Intermediate',
      'description': 'I can have basic conversations.',
      'icon': Icons.rocket_launch,
      'color': const Color(0xFFFF5722),
    },
    {
      'id': 'advanced',
      'title': 'Advanced',
      'description': "I'm comfortable speaking fluently.",
      'icon': Icons.emoji_events,
      'color': const Color(0xFFFFB300),
    },
  ];

  void handleLevelSelect(String levelId) {
    setState(() {
      selectedLevel = levelId;
    });
  }

  void handleContinue() {
    if (selectedLevel != null) {
      // print('Selected level: $selectedLevel');
      // Handle navigation or next step
      // ref.watch(UserProvider.notifier).useridenti("", 0, '', selectedLevel);
      // Userinfo().third_page(English_level: selectedLevel);
      ref.read(UserDetails.notifier).user_englishL(selectedLevel.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNav()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1f2e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1f2e),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF1a1f2e),
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
          child: Column(
            children: [
              // Header
              Column(
                children: [
                  const Text(
                    'Select your English Level',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choose the level that best describes you.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9ca3af),
                      height: 1.375,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Level Options
              Expanded(
                child: ListView.separated(
                  itemCount: levels.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final level = levels[index];
                    final isSelected = selectedLevel == level['id'];

                    return GestureDetector(
                      onTap: () => handleLevelSelect(level['id']),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color:
                          isSelected
                              ? const Color(0xFF2a3142)
                              : const Color(0xFF252b3a),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                            isSelected
                                ? const Color(0xFF4285F4)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon Container
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: (level['color'] as Color).withOpacity(
                                  0.2,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Icon(
                                level['icon'],
                                size: 24,
                                color: level['color'],
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Text Container
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    level['title'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    level['description'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF9ca3af),
                                      height: 1.43,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Checkmark
                            if (isSelected)
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 24,
                                  color: Color(0xFF4285F4),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Continue Button
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedLevel != null ? handleContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    selectedLevel != null
                        ? const Color(0xFF4285F4)
                        : const Color(0xFF374151),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                      selectedLevel != null
                          ? Colors.white
                          : const Color(0xFF9ca3af),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
