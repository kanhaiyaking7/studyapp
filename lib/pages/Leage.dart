

import 'package:flutter/material.dart';

final avatoroo = 'assets/images/avator.png';

class Scoreboard extends StatefulWidget {
  const Scoreboard({Key? key}) : super(key: key);

  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  String selectedCategory = 'Workout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Leaderboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Top 3 Podium Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                // Winners Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 2nd Place
                    _buildPodiumUser(
                      name: 'Alex\nFreedman',
                      position: 2,
                      avatara: Icons.person,
                      badgeColor: Colors.grey,
                      isWinner: false,
                      topp: 40,

                    ),
                    const SizedBox(width: 15),
                    // 1st Place (Winner)
                    _buildPodiumUser(
                      name: 'Regina Fly',
                      position: 1,
                      avatara: Icons.person,
                      badgeColor: Colors.amber,
                      isWinner: true,
                      topp: 0
                    ),
                    const SizedBox(width: 15),
                    // 3rd Place
                    _buildPodiumUser(
                      name: 'Matthew\nApeter',
                      position: 3,
                      avatara: Icons.person,
                      badgeColor: Colors.brown,
                      isWinner: false,
                      topp: 50
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Podium Base
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 2nd podium
                    Container(
                      width: 100,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // 1st podium (highest)
                    Container(
                      width: 100,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // 3rd podium
                    Container(
                      width: 100,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Category Selector
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               selectedCategory = 'Workout';
          //             });
          //           },
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          //             decoration: BoxDecoration(
          //               color: selectedCategory == 'Workout'
          //                   ? const Color(0xFF7CB342)
          //                   : Colors.transparent,
          //               borderRadius: BorderRadius.circular(25),
          //               border: Border.all(
          //                 color: selectedCategory == 'Workout'
          //                     ? const Color(0xFF7CB342)
          //                     : Colors.grey.shade600,
          //                 width: 1,
          //               ),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.all(4),
          //                   decoration: BoxDecoration(
          //                     color: selectedCategory == 'Workout'
          //                         ? Colors.white.withOpacity(0.2)
          //                         : Colors.grey.shade700,
          //                     shape: BoxShape.circle,
          //                   ),
          //                   child: Icon(
          //                     Icons.fitness_center,
          //                     color: selectedCategory == 'Workout'
          //                         ? Colors.white
          //                         : Colors.grey.shade400,
          //                     size: 16,
          //                   ),
          //                 ),
          //                 const SizedBox(width: 8),
          //                 Text(
          //                   'Workout',
          //                   style: TextStyle(
          //                     color: selectedCategory == 'Workout'
          //                         ? Colors.white
          //                         : Colors.grey.shade400,
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 14,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 12),
          //       // Expanded(
          //       //   child: GestureDetector(
          //       //     onTap: () {
          //       //       setState(() {
          //       //         selectedCategory = 'Cooking';
          //       //       });
          //       //     },
          //       //     child: Container(
          //       //       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          //       //       decoration: BoxDecoration(
          //       //         color: selectedCategory == 'Cooking'
          //       //             ? const Color(0xFF7CB342)
          //       //             : Colors.transparent,
          //       //         borderRadius: BorderRadius.circular(25),
          //       //         border: Border.all(
          //       //           color: selectedCategory == 'Cooking'
          //       //               ? const Color(0xFF7CB342)
          //       //               : Colors.grey.shade600,
          //       //           width: 1,
          //       //         ),
          //       //       ),
          //       //       child: Row(
          //       //         mainAxisAlignment: MainAxisAlignment.center,
          //       //         children: [
          //       //           Container(
          //       //             padding: const EdgeInsets.all(4),
          //       //             decoration: BoxDecoration(
          //       //               color: selectedCategory == 'Cooking'
          //       //                   ? Colors.white.withOpacity(0.2)
          //       //                   : Colors.grey.shade700,
          //       //               shape: BoxShape.circle,
          //       //             ),
          //       //             child: Icon(
          //       //               Icons.restaurant,
          //       //               color: selectedCategory == 'Cooking'
          //       //                   ? Colors.white
          //       //                   : Colors.grey.shade400,
          //       //               size: 16,
          //       //             ),
          //       //           ),
          //       //           const SizedBox(width: 8),
          //       //           Text(
          //       //             'Cooking',
          //       //             style: TextStyle(
          //       //               color: selectedCategory == 'Cooking'
          //       //                   ? Colors.white
          //       //                   : Colors.grey.shade400,
          //       //               fontWeight: FontWeight.w500,
          //       //               fontSize: 14,
          //       //             ),
          //       //           ),
          //       //         ],
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),

          // All Users Section
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ALL USERS',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      Icon(
                        Icons.tune,
                        color: Colors.grey.shade500,
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // User List
                  Expanded(
                    child: ListView(
                      children: [
                        _buildUserTile(
                          name: 'Regina Fly',
                          streak: '2,3m',
                          streakType: 'Workout streak',
                          position: 1,
                          avatar: Icons.person,
                          isCurrentUser: false,
                        ),
                        _buildUserTile(
                          name: 'Alex Freedman',
                          streak: '1,8m',
                          streakType: 'Workout streak',
                          position: 2,
                          avatar: Icons.person,
                          isCurrentUser: false,
                        ),
                        _buildUserTile(
                          name: 'Alex Freedman',
                          streak: '1,8m',
                          streakType: 'Workout streak',
                          position: 2,
                          avatar: Icons.person,
                          isCurrentUser: false,
                        ),  _buildUserTile(
                          name: 'Alex Freedman',
                          streak: '1,8m',
                          streakType: 'Workout streak',
                          position: 2,
                          avatar: Icons.person,
                          isCurrentUser: false,
                        ),  _buildUserTile(
                          name: 'Alex Freedman',
                          streak: '1,8m',
                          streakType: 'Workout streak',
                          position: 2,
                          avatar: Icons.person,
                          isCurrentUser: false,
                        ),  _buildUserTile(
                          name: 'Alex Freedman',
                          streak: '1,8m',
                          streakType: 'Workout streak',
                          position: 2,
                          avatar: Icons.person,
                          isCurrentUser: false,
                        ),
                        _buildUserTile(
                          name: '(You) Emma Richa...',
                          streak: '987k',
                          streakType: 'Workout streak',
                          position: 32,
                          avatar: Icons.person,
                          isCurrentUser: true,
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
    );
  }

  Widget _buildPodiumUser({
    required String name,
    required int position,
    required IconData avatara,
    required Color badgeColor,
    required bool isWinner,
    required int topp,
  }) {

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(

              width: isWinner ? 105 : 85,
              height: isWinner ? 105 : 85,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
              ),
              child: Image.asset(
                avatoroo,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              )
            ),
            if (isWinner)
              Positioned(
                top: -10,
                left: 0,
                right: 0,
                child: Container(
                  width: 50,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.orange,
                    size: 18,
                  ),
                ),
              ),
            if (!isWinner)
              Positioned(
                bottom: -5,
                right: -5,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: badgeColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      position.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: isWinner ? 14 : 12,
            fontWeight: isWinner ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildUserTile({
    required String name,
    required String streak,
    required String streakType,
    required int position,
    required IconData avatar,
    required bool isCurrentUser,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child:Image.asset(avatoroo,width: 40,height: 30,fit: BoxFit.cover,),
                // Icon(
                //   avatar,
                //   color: Colors.white,
                //   size: 25,
                // ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: position == 1 ? Colors.amber :
                    position == 2 ? Colors.grey :
                    position == 3 ? Colors.brown :
                    const Color(0xFF7CB342),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF2A2A2A), width: 2),
                  ),
                  child: Center(
                    child: Text(
                      position <= 99 ? position.toString() : '99+',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF7CB342),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      streakType,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                streak,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'steps',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}