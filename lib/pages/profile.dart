
import 'package:flutter/material.dart';
import 'package:hi/Setting/SettingUi.dart';
import 'package:hi/pages/helpprofile.dart';

final avatoroo = 'assets/images/avator.png';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              _buildProfileHeader(),
              const SizedBox(height: 30),

              // Stats Grid (2x2)
              _buildStatsGrid(),
              const SizedBox(height: 40),

              // Weekly Progress Section
             WeeklyProgressChart(),
              const SizedBox(height: 40),

              // Recent Achievements Section
              _buildRecentAchievements(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Profile Image Placeholder
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3C),
              // borderRadius: BorderRadius.circular(25),
            ),
            child: Image.asset(avatoroo,width: 40,height: 30,fit: BoxFit.cover,),
          ),
          const SizedBox(width: 16),

          // Profile Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Alex Mitchell',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFCC02),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Premium Member',
                      style: TextStyle(
                        color: Color(0xFFFFCC02),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Arrow Icon

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
            },
            child:Icon(
              Icons.settings,
              color: Color(0xFF8E8E93),
              size: 24,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.schedule,
                iconColor: const Color(0xFF007AFF),
                label: 'Today',
                value: '4h 25m',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                icon: Icons.local_fire_department,
                iconColor: const Color(0xFFFF3B30),
                label: 'Streak',
                value: '15 Days',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.trending_up,
                iconColor: const Color(0xFF34C759),
                label: 'Progress',
                value: '80%',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                icon: Icons.emoji_events,
                iconColor: const Color(0xFFFFCC02),
                label: 'XP',
                value: '2,450',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 25),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyProgress() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          WeeklyProgressChart(),
          // Chart Area

        ],
      ),
    );
  }

  Widget _buildBarChart(String day, double hours) {
    // Normalize height (max 8 hours = 80px)
    double barHeight = (hours / 8.0) * 80;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Y-axis labels (shown only on first bar for reference)
        if (day == 'Mo') ...[
          const SizedBox(height: 20),
          Column(
            children: [
              Text('8', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 10)),
              SizedBox(height: 8),
              Text('6', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 10)),
              SizedBox(height: 8),
              Text('4', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 10)),
              SizedBox(height: 8),
              Text('2', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 10)),
              SizedBox(height: 8),
              Text('0', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 10)),
            ],
          ),
        ] else ...[
          const SizedBox(height: 80),
        ],

        // Bar
        Container(
          width: 20,
          height: barHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF7C3AED),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),

        // Day label
        Text(
          day,
          style: const TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentAchievements() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Achievements',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          _buildAchievementItem(
            icon: Icons.emoji_events,
            iconColor: const Color(0xFFFFCC02),
            title: 'Study Master',
            subtitle: 'Completed 50 hours',
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

