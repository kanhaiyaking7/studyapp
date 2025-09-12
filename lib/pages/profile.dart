
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Core/ProfileProvider.dart';
import 'package:hi/utils/IconList.dart';
import 'package:intl/intl.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  // Sample data - replace with your actual data
  final String userName = "Johnson";
  final String userLevel = "Premium Member";
  final int totalExp = 1250;
  final String speakingTime = "45h 30m";
  final int currentStreak = 4;

  // 7 days streak data (true = completed, false = not completed)


  @override
  Widget build(BuildContext context) {
    print("Profile!!!!!!!!");
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Profile Card
              _buildProfileHeader(),
              const SizedBox(height: 24),

              // Speaking Streak Section
              _buildSpeakingStreak(),
              const SizedBox(height: 24),

              // My Achievements Section
              _buildAchievements(),
              const SizedBox(height: 24),

              // Statistics Section
              _buildStatistics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D30),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userLevel,
                  style: TextStyle(
                    color: Colors.yellow[400],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Consumer(
                        builder: (context,ref,child){
                      final totalcoin = ref.watch(ProfileProvider.select((state)=>state.coin));
                    return   _buildStatItem('XP', totalcoin.toString(), AppIcon.xp);
                    }),
                    const SizedBox(width: 24),
                    Consumer(
                        builder: (context,ref,child){
                          final time = ref.watch(ProfileProvider.select((state)=>state.Speaking_time));
                          var actualtime = time < 60 ? time: "1h:${time-60}";
                          var correcttime = '${actualtime}m';
                          return   _buildStatItem('Speaking Time', correcttime,AppIcon.time);
                        }),
                  ],
                ),
              ],
            ),
          ),

          // Settings Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String texticon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
           Text(texticon,style: TextStyle(fontSize: 22),),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        )

      ],
    );
  }

  Widget _buildSpeakingStreak() {
    DateTime now =  DateTime.now();
    DateTime currentDate  = DateTime(now.year,now.month, now.day);
    String monthname = DateFormat.MMM().format(now);
    String dayname = DateFormat.EEEEE().format(now);

    print(dayname);
    // final int currentStreak = 4;

    final List<bool> streakData = [true, true, true, true, true, false, false];
    final List<String> weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];


    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D30),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_fire_department,
                color: Colors.orange,
                size: 28,
              ),
              const SizedBox(width: 8),
              const Text(
                'Speaking Streak',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '$currentStreak',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Today • ${monthname} ${currentDate.day} • $currentStreak of 7',
            // 'Today  ',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),

          // 7 Days Streak Circles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  // color: streakData[index]
                  color: currentStreak-1 >= index
                      ? const Color(0xFF6C5CE7)
                      : Colors.grey[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    weekDays[index],
                    style: TextStyle(
                      color: currentStreak-1 >= index ? Colors.white : Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Achievements',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAchievementItem(
              Icons.wb_sunny,
              'Early Speaker',
              Colors.orange,
              true,
            ),
            _buildAchievementItem(
              Icons.check_circle,
              'Daily Goal',
              Colors.blue,
              true,
            ),
            _buildAchievementItem(
              Icons.emoji_events,
              'Perfect Week',
              Colors.purple,
              true,
            ),
            _buildAchievementItem(
              Icons.lock,
              'Locked',
              Colors.grey,
              false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAchievementItem(
      IconData icon,
      String title,
      Color color,
      bool isUnlocked,
      ) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isUnlocked ? color.withOpacity(0.2) : Colors.grey[800],
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isUnlocked ? color : Colors.grey[600]!,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: isUnlocked ? color : Colors.grey[600],
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: isUnlocked ? Colors.white : Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatistics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D30),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Speaking Statistics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'This Week',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const Text(
            'Focus Distribution',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),

          _buildStatisticsItem('Conversation', '45%', const Color(0xFF6C5CE7)),
          const SizedBox(height: 12),
          _buildStatisticsItem('Pronunciation', '32%', const Color(0xFF00D4AA)),
          const SizedBox(height: 12),
          _buildStatisticsItem('Grammar', '23%', const Color(0xFFFFC107)),
        ],
      ),
    );
  }

  Widget _buildStatisticsItem(String title, String percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}