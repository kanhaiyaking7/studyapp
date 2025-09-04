import 'package:flutter/material.dart';
import 'package:hi/Games/Dragpoint.dart';
import 'package:hi/Games/Enrichment.dart';
import 'package:hi/Games/ErrorHunt.dart';
import 'package:hi/Games/GamesSection.dart';
import 'package:hi/Reading/Bookstore.dart';
import 'package:hi/Reading/Reading.dart';
import 'package:hi/Role_ai/startpage.dart';
import 'package:hi/Speaking/AnimeHome.dart';
import 'package:hi/Speaking/LoadAnim.dart';
import 'package:hi/Speaking/ShowAnime.dart';
import 'package:hi/Speaking/VideoStudy.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),

              // Current Streak
              _buildStreakContainer(),

              // Daily Goal
              _buildDailyGoal(),

              // Practice Speaking
              _buildPracticeSection(screenWidth),

              // Recommended Topics
              _buildRecommendedTopics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SpeakEasy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Skills. Stories.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakContainer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department,
            color: Color(0xFFFFB800),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current streak',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  '7 days',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildStatItem('12', 'Sessions'),
              const SizedBox(width: 20),
              _buildStatItem('85%', 'Accuracy'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF999999),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyGoal() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Goal',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '15 min / 20 min',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF999999),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFF404040),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.75,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2ECC71),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeSection(double screenWidth) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Practice Speaking',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildPracticeCard(
                'Conversation',
                'Practice',
                Icons.chat_bubble_outline,
                const Color(0xFF4A90E2),
                screenWidth,
                    () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoCallScreen()));
                  // Navigate to conversation practice
                },
              ),
              _buildPracticeCard(
                'Pronunciation',
                'Drills',
                Icons.mic,
                const Color(0xFF7B68EE),
                screenWidth,
                    () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GamesSection()));
                  // Navigate to pronunciation drills
                },
              ),
              _buildPracticeCard(
                'Role Play',
                'Scenarios',
                Icons.theater_comedy,
                const Color(0xFFE74C3C),
                screenWidth,
                    () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> StatePage()));
                  // Navigate to role play scenarios
                  // router.push('(main)/Fourmain/Role')
                },
              ),
              _buildPracticeCard(
                'Reading Book',
                'Challenges',
                Icons.trending_up,
                const Color(0xFF2ECC71),
                screenWidth,
                    () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BookStore()));
                  // Navigate to reading book challenges
                  // router.push('(main)/Book/Reading')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeCard(
      String title,
      String subtitle,
      IconData icon,
      Color iconColor,
      double screenWidth,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (screenWidth - 60) / 2,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2a2a2a),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF999999),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedTopics() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recommended Topics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle see all tap
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4A90E2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTopicCard(
            'Job Interview',
            '16 sessions • Intermediate',
            Icons.work,
            const Color(0xFF4A90E2),
                () {
              // Navigate to job interview
              // router.push('(main)/Jobw/Modd')
            },
          ),
          _buildTopicCard(
            'Travel Conversations',
            '24 sessions • Beginner',
            Icons.flight,
            const Color(0xFF2ECC71),
                () {
              // Navigate to travel conversations
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(
      String title,
      String subtitle,
      IconData icon,
      Color iconColor,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2a2a2a),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF404040),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF999999),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}