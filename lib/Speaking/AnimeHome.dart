import 'package:flutter/material.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  final Map<String, dynamic> jobInterviewPreparation = {
    'title': 'Job Interview Preparation',
    'courses': '8 courses',
    'level': 'Intermediate',
    'progress': 0.0, // Example progress, adjust as needed
  };

  final List<Map<String, dynamic>> businessEnglish = [
    {
      'title': 'Job Interviews',
      'duration': '10 min',
      'level': 'Intermediate',
      'icon': Icons.work,
      'iconColor': Colors.green,
      'progress': 0.5, // Example progress
    },
    {
      'title': 'Meetings',
      'duration': '15 min',
      'level': 'Advanced',
      'icon': Icons.people,
      'iconColor': Colors.purple,
      'progress': 0.7,
    },
    {
      'title': 'Negotiations',
      'duration': '12 min',
      'level': 'Advanced',
      'icon': Icons.handshake,
      'iconColor': Colors.orange,
      'progress': 0.3,
    },
    {
      'title': 'Presentations',
      'duration': '8 min',
      'level': 'Intermediate',
      'icon': Icons.slideshow,
      'iconColor': Colors.cyan,
      'progress': 0.9,
    },
  ];

  final List<Map<String, dynamic>> dailyConversations = [
    {
      'title': 'Job Interviews',
      'duration': '10 min',
      'level': 'Intermediate',
      'icon': Icons.work,
      'iconColor': Colors.green,
      'progress': 0.4,
    },
    {
      'title': 'Meetings',
      'duration': '15 min',
      'level': 'Advanced',
      'icon': Icons.people,
      'iconColor': Colors.purple,
      'progress': 0.6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        elevation: 0,
        title: Text(
          "Topics",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.school_rounded,size: 30, color: Colors.blueAccent),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          // Top decoration
          // Container(
          //   width: double.infinity,
          //   height: 80,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Colors.blueGrey[800]!, Colors.black],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //     borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.5),
          //         blurRadius: 10,
          //         offset: const Offset(0, 5),
          //       ),
          //     ],
          //   ),
          //   child: const Center(
          //     child: Text(
          //       'Topics',
          //       style: TextStyle(
          //         fontSize: 28,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
          // Job Interview Preparation banner
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Container(
                    width: double.infinity,
                    height: 120,
                    color: Colors.grey[700],
                    child: const Center(
                      child: Text(
                        'Image Placeholder',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobInterviewPreparation['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${jobInterviewPreparation['courses']} • ${jobInterviewPreparation['level']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: jobInterviewPreparation['progress'],
                          backgroundColor: Colors.grey[800],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                          minHeight: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Business English section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Business English',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[300],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: businessEnglish.length,
              itemBuilder: (context, index) {
                final item = businessEnglish[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (item['iconColor'] as Color).withOpacity(0.2),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          size: 40,
                          color: item['iconColor'] as Color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${item['duration']} • ${item['level']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: LinearProgressIndicator(
                          value: item['progress'] as double,
                          backgroundColor: Colors.grey[800],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Daily Conversations section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Daily Conversations',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[300],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: dailyConversations.length,
              itemBuilder: (context, index) {
                final item = dailyConversations[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (item['iconColor'] as Color).withOpacity(0.2),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          size: 40,
                          color: item['iconColor'] as Color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${item['duration']} • ${item['level']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Row(
                          children: [
                            LinearProgressIndicator(
                              value: item['progress'] as double,
                              backgroundColor: Colors.grey[800],
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                              minHeight: 6,
                            ),
                            Text("6/8",style: TextStyle(color: Colors.greenAccent,fontSize: 15),),
                          ],
                        )
                        // LinearProgressIndicator(
                        //   value: item['progress'] as double,
                        //   backgroundColor: Colors.grey[800],
                        //   valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                        //   minHeight: 6,
                        // ),
                        
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32), // Bottom padding
        ],
      ),
    );
  }
}