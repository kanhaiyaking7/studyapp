

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/Aichat_provider/Aichat_provider.dart';
import 'package:hi/Providers/Aichat_provider/RolePlayinfo.dart';
import 'package:hi/Role_ai/Aivirtual.dart';
import 'package:hi/Role_ai/blanket.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:flutter/material.dart';

class StatePage extends ConsumerStatefulWidget {
  const StatePage({Key? key}) : super(key: key);

  @override
  ConsumerState<StatePage> createState() => _StatePageState();
}

class _StatePageState extends ConsumerState<StatePage> {
  // Store list data in variables
  final List<RolePlayItem> rolePlayItems = [
    RolePlayItem(
      title: "Job Interview",
      description: "Practice answering common interview questions",
      difficulty: "Beginner",
      icon: Icons.work_outline,
      progress: 5,
      total: 6,
      duration: "ch",
      color: Colors.blue,
      id:"Job_interview"
    ),
    // RolePlayItem(
    //   title: "Ordering at a Restaurant",
    //   description: "Learn how to order food and make special requests",
    //   difficulty: "Beginner",
    //   icon: Icons.restaurant_menu,
    //   progress: 3,
    //   total: 5,
    //   duration: "ch",
    //   color: Colors.orange,
    //     id:"Job_interview"
    // ),
    RolePlayItem(
      title: "Making New Friends",
      description: "Practice introducing yourself and small talk",
      difficulty: "Intermediate",
      icon: Icons.people_outline,
      progress: 3,
      total: 8,
      duration: "ch",
      color: Colors.purple,
        id:"Making_Friends"
    ),
    RolePlayItem(
      title: "Shopping for clothes",
      description: "Practice introducing yourself and small talk",
      difficulty: "Intermediate",
      icon: Icons.people_outline,
      progress: 3,
      total: 7,
      duration: "ch",
      color: Colors.green,
        id:"shoppingClothes"
    ),

    RolePlayItem(
        title: "Talking with a classmate",
        description: "Practice introducing yourself and small talk",
        difficulty: "Intermediate",
        icon: Icons.people_outline,
        progress: 3,
        total: 8,
        duration: "ch",
        color: Colors.purple,
        id:"Talking_with_a_classmate"
    ),

    RolePlayItem(
        title: " Rent a car",
        description: "Practice introducing yourself and small talk",
        difficulty: "Intermediate",
        icon: Icons.people_outline,
        progress: 3,
        total: 8,
        duration: "ch",
        color: Colors.purple,
        id:"Renting_car"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            // Custom decorated header
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1A1A1A),
                    const Color(0xFF0F0F0F),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Role Play",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            "Practice real-world scenarios",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable content
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: rolePlayItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RolePlayCard(item: rolePlayItems[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RolePlayItem {
  final String title;
  final String description;
  final String difficulty;
  final IconData icon;
  final int progress;
  final int total;
  final String duration;
  final Color color;
  final String id;

  RolePlayItem({
    required this.title,
    required this.description,
    required this.difficulty,
    required this.icon,
    required this.progress,
    required this.total,
    required this.duration,
    required this.color,
    required this.id
  });
}

class RolePlayCard extends StatelessWidget {
  final RolePlayItem item;

  const RolePlayCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressPercentage = item.progress / item.total;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E1E1E),
            const Color(0xFF181818),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: item.color.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Icon container
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        item.color.withOpacity(0.2),
                        item.color.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: item.color.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.color,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style:  TextStyle(
                                color: item.color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(item.difficulty).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _getDifficultyColor(item.difficulty).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              item.difficulty,
                              style: TextStyle(
                                color: _getDifficultyColor(item.difficulty),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Progress section
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final completed = ref.read(RoleplayProvider.notifier).get_data(item.id);

                              return Text(
                                "${completed.toString()}/${item.total}",
                                  style: TextStyle(
                                    color: item.color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                              );
                            },
                          )
                          // Text(
                          //   "${item.progress}/${item.total} ${item.duration}",
                          //   style: TextStyle(
                          //     color: item.color,
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Consumer(
                        builder: (context, ref, child) {
                          final completed = ref.read(RoleplayProvider.notifier).get_data(item.id);

                          return    Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: completed/item.total,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(item.color),
                              ),
                            ),
                          );
                        }
                      )

                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Start button
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF6366F1),
                        const Color(0xFF4F46E5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6366F1).withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {


                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context)=>blanket(Id:item.id,title:item.title)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return const Color(0xFF10B981);
      case 'intermediate':
        return const Color(0xFFF59E0B);
      case 'advanced':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }
}