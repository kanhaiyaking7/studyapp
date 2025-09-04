

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/Aichat_provider/Aichat_provider.dart';
import 'package:hi/Role_ai/Aivirtual.dart';
import 'package:hi/Role_ai/blanket.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StatePage extends ConsumerStatefulWidget {
  const StatePage({Key? key}) : super(key: key);

  @override
  ConsumerState<StatePage> createState() => _StatePageState();
}

class _StatePageState extends ConsumerState<StatePage> {
  final List<Map<String, dynamic>> scenarios = [
    {
      'id': 1,
      'title': 'Job Interview',
      'description': 'Practice answering common interview questions',
      'duration': '5/10 ch',
      'difficulty': 'Beginner',
      'difficultyColor': const Color(0xFF4CAF50),
      'icon': Icons.work,
      'iconColor': const Color(0xFF6366F1),
      'iconBg': const Color(0xFFEEF2FF),
    },
    {
      'id': 2,
      'title': 'Ordering at a Restaurant',
      'description': 'Learn how to order food and make special requests',
      'duration': '3/5 ch',
      'difficulty': 'Beginner',
      'difficultyColor': const Color(0xFF4CAF50),
      'icon': Icons.restaurant,
      'iconColor': const Color(0xFF3B82F6),
      'iconBg': const Color(0xFFEBF8FF),
    },
    {
      'id': 3,
      'title': 'Making New Friends',
      'description': 'Practice introducing yourself and small talk',
      'duration': '3-8 min',
      'difficulty': 'Intermediate',
      'difficultyColor': const Color(0xFFFF9800),
      'icon': Icons.people,
      'iconColor': const Color(0xFF8B5CF6),
      'iconBg': const Color(0xFFF3E8FF),
    },
    {
      'id': 4,
      'title': 'Making New Friends',
      'description': 'Practice introducing yourself and small talk',
      'duration': '3-8 min',
      'difficulty': 'Intermediate',
      'difficultyColor': const Color(0xFFFF9800),
      'icon': Icons.people,
      'iconColor': const Color(0xFF8B5CF6),
      'iconBg': const Color(0xFFF3E8FF),
    },
    {
      'id': 5,
      'title': 'Making New Friends',
      'description': 'Practice introducing yourself and small talk',
      'duration': '3-8 min',
      'difficulty': 'Intermediate',
      'difficultyColor': const Color(0xFFFF9800),
      'icon': Icons.people,
      'iconColor': const Color(0xFF8B5CF6),
      'iconBg': const Color(0xFFF3E8FF),
    },
    {
      'id': 6,
      'title': 'Making New Friends',
      'description': 'Practice introducing yourself and small talk',
      'duration': '3-8 min',
      'difficulty': 'Intermediate',
      'difficultyColor': const Color(0xFFFF9800),
      'icon': Icons.people,
      'iconColor': const Color(0xFF8B5CF6),
      'iconBg': const Color(0xFFF3E8FF),
    },
  ];

  final List<String> categories = ['AI Scenarios', 'Business', 'Travel', 'Social'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: const Text(
          'Role Play',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        leading:  IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),

      ),
      // backgroundColor: const Color(0xFF1a1a1a),
      // backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            // _buildHeader(),

            // Scenarios List
            Expanded(
              child: _buildScenariosList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: Color(0xFF374151),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Role Play',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    // color: Color(0xFF111827),
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Choose a conversation scenario',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenariosList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: scenarios.length,
      itemBuilder: (context, index) {
        final scenario = scenarios[index];
        return _buildScenarioCard(scenario);
      },
    );
  }

  Widget _buildScenarioCard(Map<String, dynamic> scenario) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Left side - Icon and Info
            Expanded(
              child: Row(
                children: [
                  // Icon Container
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: scenario['iconBg'],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      scenario['icon'],
                      size: 24,
                      color: scenario['iconColor'],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Scenario Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scenario['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:Colors.white
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          scenario['description'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                            height: 1.43,
                          ),
                        ),
                        Row(

                          children: [
                            new LinearPercentIndicator(
                              width: 100.0,
                              lineHeight: 6.0,
                              percent: 0.7,
                              backgroundColor: Colors.white,
                              progressColor: Colors.blue,
                              barRadius: Radius.circular(10.0),
                              animation: true,
                              animationDuration: 1000,
                              curve: Curves.easeInOut,
                              animateFromLastPercent: true,


                            ),
                            const SizedBox(height: 8),
                            Text(
                              scenario['duration'],
                              style: const TextStyle(
                                  fontSize: 12,
                                  color:Colors.white
                              ),
                            ),

                          ],
                        )


                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Right side - Difficulty and Start Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Difficulty Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: scenario['difficultyColor'].withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    scenario['difficulty'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: scenario['difficultyColor'],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Start Button
                GestureDetector(
                  onTap: () {
                    // Handle start button tap
                    _onStartScenario(scenario);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onStartScenario(Map<String, dynamic> scenario) {


    // Handle scenario start logic here
    print('Starting scenario: ${scenario['title']}');

    // You can navigate to the scenario screen or show a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Start ${scenario['title']}'),
        content: Text('Ready to practice ${scenario['title'].toLowerCase()}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),


          ElevatedButton(
            onPressed: () {


              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>blanket()));
              // Navigate to the actual scenario screen
            },
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }
}