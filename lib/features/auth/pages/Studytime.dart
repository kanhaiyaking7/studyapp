
// import 'package:flutt/features/auth/pages/EnglishLevel.dart';
// import 'package:flutt/features/auth/provider/User_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/features/auth/pages/EnglishLevel.dart';
import 'package:hi/features/auth/provider/User_provider.dart';

class StudyTime extends ConsumerStatefulWidget {
  const StudyTime({Key? key}) : super(key: key);

  @override
  ConsumerState<StudyTime> createState() => _StudyTimeState();
}

class _StudyTimeState extends ConsumerState<StudyTime> {
  String selectedDuration = "";

  final List<Map<String, dynamic>> durations = [
    {
      'id': '10',
      'title': '10 Minutes',
      'description': 'A quick and focused session.',
      'icon': Icons.flash_on,
      'color': const Color(0xFFFF6B35),
    },
    {
      'id': '20',
      'title': '20 Minutes',
      'description': 'A solid learning block.',
      'icon': Icons.lightbulb,
      'color': const Color(0xFFFFD23F),
    },
    {
      'id': '30',
      'title': '30 Minutes',
      'description': 'A standard, effective session.',
      'icon': Icons.gps_fixed, // Using gps_fixed as target alternative
      'color': const Color(0xFFFF1744),
    },
    {
      'id': '60',
      'title': '60 Minutes',
      'description': 'A deep dive into learning.',
      'icon': Icons.nights_stay,
      'color': const Color(0xFFFFB74D),
    },
  ];

  void handleDurationSelect(String durationId) {
    setState(() {
      selectedDuration = durationId;
    });
  }

  void handleContinue() {
    if (selectedDuration != null) {
      String timep = selectedDuration;
      int tima = int.parse(timep);
      // print('Selected duration: $selectedDuration minutes');
      // Handle navigation or next step
      // Userinfo().second_page(time: selectedDuration);
      print(selectedDuration);
      ref.read(UserDetails.notifier).user_studytime(tima);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => EnglishLevel()),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Text(
                      'How long will you learn tonight?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Commit to a session. Every minute counts.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9ca3af),
                        height: 1.375,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Duration Options
              Expanded(
                child: ListView.separated(
                  itemCount: durations.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final duration = durations[index];
                    final isSelected = selectedDuration == duration['id'];

                    return GestureDetector(
                      onTap: () => handleDurationSelect(duration['id']),
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
                          boxShadow: [
                            BoxShadow(
                              color:
                              isSelected
                                  ? const Color(0xFF4285F4).withOpacity(0.3)
                                  : Colors.black.withOpacity(0.1),
                              blurRadius: isSelected ? 6 : 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Icon Container
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: (duration['color'] as Color).withOpacity(
                                  0.2,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Icon(
                                duration['icon'],
                                size: 24,
                                color: duration['color'],
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Text Container
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    duration['title'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    duration['description'],
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
              const SizedBox(height: 20),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedDuration != null ? handleContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    selectedDuration != null
                        ? const Color(0xFF4285F4)
                        : const Color(0xFF374151),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: selectedDuration != null ? 6 : 3,
                    shadowColor:
                    selectedDuration != null
                        ? const Color(0xFF4285F4).withOpacity(0.3)
                        : Colors.black.withOpacity(0.1),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                      selectedDuration != null
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
