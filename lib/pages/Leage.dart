

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Core/ProfileProvider.dart';
import 'package:hi/Providers/Champions/champions.dart';
import 'package:hi/utils/IconList.dart';
import 'package:hi/utils/Loadinggame.dart';
import 'package:lottie/lottie.dart';

final avatoroo = 'assets/images/avator.png';

class Scoreboard extends ConsumerStatefulWidget {
  const Scoreboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends ConsumerState<Scoreboard> {
  String selectedCategory = 'Workout';

  // final List<Map<String,dynamic>> Players = [
  //   {
  //       'name': 'Regina Fly',
  //       'streak': '23m',
  //       'streakType': 'Workout streak',
  //       'position': 1,
  //       'avatar': 'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/avator/Anastasia.png.webp',
  //       'isCurrentUser': false,
  //   },
  //   {
  //     'name': 'Regina Fly',
  //     'streak': '13m',
  //     'streakType': 'Workout streak',
  //     'position': 2,
  //     'avatar': 'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/avator/farid.png.webp',
  //     'isCurrentUser': false,
  //   },
  //   {
  //     'name': 'Regina Fly',
  //     'streak': '03m',
  //     'streakType': 'Workout streak',
  //     'position': 3,
  //     'avatar': 'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/avator/ivan_2.png.webp',
  //     'isCurrentUser': false,
  //   },
  //   {
  //     'name': 'Regina Fly',
  //     'streak': '33m',
  //     'streakType': 'Workout streak',
  //     'position': 4,
  //     'avatar': 'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/avator/Kostya.png.webp',
  //     'isCurrentUser': false,
  //   },
  //   {
  //     'name': 'Regina Fly',
  //     'streak': '45m',
  //     'streakType': 'Workout streak',
  //     'position': 5,
  //     'avatar': 'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/avator/Nikita.png.webp',
  //     'isCurrentUser': false,
  //   },
  //
  //
  // ];
final List<Map<String,dynamic>> Winners = [
  {
      'name': 'King',
      'position': 1,
      'avatara': 'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/avator/Nikita.png.webp',
      'badgeColor': Colors.amber,
      'isWinner': true,
      'topp': 0,
  },
  {
    'name': 'Alex\nFreedman',
    'position': 2,
    'avatara': 'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/avator/farid.png.webp',
    'badgeColor': Colors.grey,
    'isWinner': false,
    'topp': 40,
  },
  {
    'name': 'Matthew\nApeter',
    'position': 3,
    'avatara': 'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/avator/ivan_2.png.webp',
    'badgeColor': Colors.brown,
    'isWinner': false,
    'topp': 50,
  },
];


  @override
  Widget build(BuildContext context) {
    final Learner = ref.watch(champions);

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
            icon: const Icon(
                // Icons.more_vert,
              Icons.notifications,
                color: Colors.yellow),
            onPressed: () {},
          ),
        ],
      ),
      body:
          Learner.when(
              data: (players){
             final winers = players.where((b)=>b.position < 4).toList();
             List ee = players;
              ee.sort((a,b)=>a.position.compareTo(b.position));
             final champions = ee.toList();
             // print(winers);
                return  Column(
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
                              //     ListView.builder(
                              //       itemCount: Winners.length,
                              //         itemBuilder: (context,index){
                              //         return  _buildPodiumUser(
                              //           name: Winners[index]['name'],
                              //           position: Winners[index]['position'],
                              //           avatara: Winners[index]['avatara'],
                              //           badgeColor: Winners[index]['badgeColor'],
                              //           isWinner: Winners[index]['isWinner'],
                              //           topp: Winners[index]['topp'],
                              //         );
                              //
                              //
                              //     })
                              //     2nd Place
                              _buildPodiumUser(
                                name: winers[1].name,
                                position: winers[1].position,
                                avatar: winers[1].avatar,

                              ),
                              const SizedBox(width: 15),
                              // 1st Place (Winner)
                              _buildPodiumUser(
                                name: winers[0].name,
                                position: winers[0].position,
                                avatar: winers[0].avatar,
                              ),
                              const SizedBox(width: 15),
                              // 3rd Place
                              _buildPodiumUser(
                                name: winers[2].name,
                                position: winers[2].position,
                                avatar: winers[2].avatar,
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
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: champions.length,
                                      itemBuilder: (context, index) {
                                        return _buildUserTile(
                                          name: champions[index].name,
                                          streak: champions[index].streak,
                                          xp: champions[index].xp,
                                          position: champions[index].position,
                                          avatar: champions[index].avatar,
                                        );
                                      },
                                    ),
                                  ),
                                  // The second ListView will be positioned at the bottom.
                                  // `shrinkWrap` is essential here to prevent overflow errors.
                                  ListView(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(), // Recommended to avoid nested scrolling
                                    children: [
                                      Consumer(
                                          builder: (context,ref,child){
                                            final totalcoin = ref.watch(ProfileProvider);

                                            return   _buildUserTile(
                                              name: 'radhe',
                                              streak: 55,
                                              xp: 56,
                                              position: -1,
                                              avatar: 'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/Avator/avator/Nikita.png.webp',
                                            );
                                          }),

                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            error: (e,stack)=>Text('error$e'),
            loading: ()=>Loadinggame()
          ),


    );
  }

  Widget _buildPodiumUser({
    required String name,
    required int position,
    required String  avatar,

  }) {

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(

              width: position == 1 ? 105 : 85,
              height: position == 1  ? 105 : 85,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
              ),
              child:
              CircleAvatar(
                backgroundImage:NetworkImage(avatar),
                // backgroundColor: Colors.red,
              ),

              // Image.asset(
              //   avatoroo,
              //   width: 90,
              //   height: 90,
              //   fit: BoxFit.cover,
              // )
            ),
            // if (isWinner)
            //   Positioned(
            //     top: -10,
            //     left: 0,
            //     right: 0,
            //     child: Container(
            //       width: 50,
            //       height: 40,
            //       decoration: const BoxDecoration(
            //         color: Colors.amber,
            //         shape: BoxShape.circle,
            //       ),
            //       child: const Icon(
            //         Icons.emoji_events,
            //         color: Colors.orange,
            //         size: 18,
            //       ),
            //     ),
            //   ),
            if (position != 1)
              Positioned(
                bottom: -5,
                right: -5,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    // color: badgeColor,
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
            fontSize: position == 1 ? 14 : 12,
            fontWeight: position == 1 ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildUserTile({
    required String name,
    required int streak,
    required int xp,
    required int position,
    required String avatar,
    // required bool isCurrentUser,
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
                width: 60,
                height: 55,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child:
                    CircleAvatar(
                      backgroundImage:NetworkImage(avatar),
                      // backgroundColor: Colors.red,
                    ),

                // Image.asset(avatoroo,width: 40,height: 30,
                //   fit: BoxFit.cover,),
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
                // const SizedBox(height: 4),
                Row(
                  children: [
                    Container(

                      height: 6,
                      alignment: Alignment.topLeft,
                      // decoration: const BoxDecoration(
                      //   color: Color(0xFF7CB342),
                      //   shape: BoxShape.circle,
                      // ),
                    ),
                    // const SizedBox(width: 6),
                    Lottie.network('https://fonts.gstatic.com/s/e/notoemoji/latest/1f525/lottie.json',height: 30,width: 20),
                    Text(
                      streak.toString(),
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
                xp.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'xp',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,)),

                 Text(
                   AppIcon.xp,
                   style: TextStyle(
                     fontSize: 15,
                     color: AppColor.xpo
                   ),
                 )


                ],
              )
              // Text(
              //   'xp',
              //   style: TextStyle(
              //     color: Colors.grey.shade400,
              //     fontSize: 12,
              //   ),
              // ),
              // Lottie.network('https://fonts.gstatic.com/s/e/notoemoji/latest/1f525/lottie.json',height: 50,width: 30),

            ],
          ),
        ],
      ),
    );
  }
}