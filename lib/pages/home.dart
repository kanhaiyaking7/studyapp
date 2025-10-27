import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Games/GamesSection.dart';
import 'package:hi/ImageReading/HomeImagereading.dart';
import 'package:hi/ImageReading/ImageReadingHome.dart';
import 'package:hi/ImageReading/Imagereading.dart';
import 'package:hi/ImageReading/Seeimage.dart';
import 'package:hi/Providers/path_provier/Quiz_provider.dart';
import 'package:hi/Reading/Bookstore.dart';
import 'package:hi/Role_ai/startpage.dart';
import 'package:hi/Speaking/AnimeHome.dart';
import 'package:hi/Speaking/ShowAnime.dart';
import 'package:hi/utils/IconList.dart';
import 'package:hi/utils/Loadinggame.dart';
import 'package:hi/utils/LostNetwork.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:icons_plus/icons_plus.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


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


              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.all(24),
              //   // decoration: BoxDecoration(
              //   //   gradient: LinearGradient(
              //   //     colors: [
              //   //       // const Color(0xFFFFD700),
              //   //       // const Color(0xFF2a2a2a),
              //   //       // const Color(0xFFFFA500),
              //   //       //
              //   //       // const Color(0xFF4ECDC4),
              //   //       // const Color(0xFF7BDCB5),
              //   //       const Color(0xFF9929EA),
              //   //
              //   //       const Color(0xFF9929EA)
              //   //
              //   //     ],
              //   //     begin: Alignment.topLeft,
              //   //     end: Alignment.bottomRight,
              //   //   ),
              //   //   borderRadius: BorderRadius.circular(20),
              //   //   boxShadow: [
              //   //     BoxShadow(
              //   //       color: const Color(0xFFFFD700).withOpacity(0.4),
              //   //       blurRadius: 20,
              //   //       offset: const Offset(0, 10),
              //   //     ),
              //   //   ],
              //   // ),
              //   decoration: BoxDecoration(
              //     // color: const Color(0xFF2a2a2a),
              //     color: Colors.green,
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           // Container(
              //           //   padding: const EdgeInsets.all(8),
              //           //   decoration: BoxDecoration(
              //           //     color: Colors.white.withOpacity(0.2),
              //           //     borderRadius: BorderRadius.circular(12),
              //           //   ),
              //           //   child: Icon(
              //           //     Icons.emoji_events,
              //           //     color: Colors.yellow,
              //           //     size: 24,
              //           //   ),
              //           // ),
              //           const SizedBox(width: 12),
              //           Expanded(
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   'September Challenge',
              //                   style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 18,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 Text(
              //                   'Complete 50 sessions this month',
              //                   style: TextStyle(
              //                     color: Colors.white70,
              //                     fontSize: 13,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Container(
              //             child: Lottie.network("https://fonts.gstatic.com/s/e/notoemoji/latest/1f947/lottie.json",
              //                 height: 60,   width: 70)
              //           )
              //           // AnimatedBuilder(
              //           //   animation: _scaleAnimation,
              //           //   builder: (context, child) {
              //           //     return Transform.scale(
              //           //       scale: _scaleAnimation.value,
              //           //       child: Container(
              //           //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //           //         decoration: BoxDecoration(
              //           //           color: Colors.white.withOpacity(0.2),
              //           //           borderRadius: BorderRadius.circular(20),
              //           //         ),
              //           //         child: Text(
              //           //           '12/50',
              //           //           style: TextStyle(
              //           //             color: Colors.white,
              //           //             fontSize: 14,
              //           //             fontWeight: FontWeight.bold,
              //           //           ),
              //           //         ),
              //           //       ),
              //           //     );
              //           //   },
              //           // ),
              //         ],
              //       ),
              //
              //       const SizedBox(height: 20),
              //
              //       // Progress Bar
              //
              //       Container(
              //         width: double.infinity,
              //         height: 8,
              //         decoration: BoxDecoration(
              //           color: Colors.white.withOpacity(0.3),
              //           borderRadius: BorderRadius.circular(4),
              //         ),
              //         child: FractionallySizedBox(
              //           alignment: Alignment.centerLeft,
              //           widthFactor: 0.6, // 12/20 = 0.6
              //           child: Container(
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(4),
              //             ),
              //           ),
              //         ),
              //       ),
              //
              //       const SizedBox(height:5),
              //
              //       // Rewards Section
              //       // Row(
              //       //   children: [
              //       //     Expanded(
              //       //       child: Container(
              //       //         padding: const EdgeInsets.all(16),
              //       //         decoration: BoxDecoration(
              //       //           color: Colors.white.withOpacity(0.15),
              //       //           borderRadius: BorderRadius.circular(16),
              //       //         ),
              //       //         child: Column(
              //       //           children: [
              //       //             Row(
              //       //               mainAxisAlignment: MainAxisAlignment.center,
              //       //               children: [
              //       //                 Icon(
              //       //                   Icons.monetization_on,
              //       //                   color: Colors.white,
              //       //                   size: 20,
              //       //                 ),
              //       //                 const SizedBox(width: 6),
              //       //                 Text(
              //       //                   '32/50',
              //       //                   style: TextStyle(
              //       //                     color: Colors.white,
              //       //                     fontSize: 18,
              //       //                     fontWeight: FontWeight.bold,
              //       //                   ),
              //       //                 ),
              //       //               ],
              //       //             ),
              //       //             const SizedBox(height: 4),
              //       //             Text(
              //       //               'Coins Earned',
              //       //               style: TextStyle(
              //       //                 color: Colors.white70,
              //       //                 fontSize: 12,
              //       //               ),
              //       //             ),
              //       //           ],
              //       //         ),
              //       //       ),
              //       //     ),
              //       //
              //       //     const SizedBox(width: 12),
              //       //
              //       //     Expanded(
              //       //       child: Container(
              //       //         padding: const EdgeInsets.all(16),
              //       //         decoration: BoxDecoration(
              //       //           color: Colors.white.withOpacity(0.15),
              //       //           borderRadius: BorderRadius.circular(16),
              //       //         ),
              //       //         child: Column(
              //       //           children: [
              //       //             Row(
              //       //               mainAxisAlignment: MainAxisAlignment.center,
              //       //               children: [
              //       //                 Container(
              //       //                   width: 24,
              //       //                   height: 24,
              //       //                   decoration: BoxDecoration(
              //       //                     color: Colors.white,
              //       //                     shape: BoxShape.circle,
              //       //                   ),
              //       //                   child: Icon(
              //       //                     Icons.person,
              //       //                     color: const Color(0xFFFFD700),
              //       //                     size: 16,
              //       //                   ),
              //       //                 ),
              //       //                 const SizedBox(width: 6),
              //       //                 Icon(
              //       //                   Icons.lock_open,
              //       //                   color: Colors.white,
              //       //                   size: 16,
              //       //                 ),
              //       //               ],
              //       //             ),
              //       //             const SizedBox(height: 4),
              //       //             Text(
              //       //               'Avatar Unlock',
              //       //               style: TextStyle(
              //       //                 color: Colors.white70,
              //       //                 fontSize: 12,
              //       //               ),
              //       //             ),
              //       //           ],
              //       //         ),
              //       //       ),
              //       //     ),
              //       //   ],
              //       // ),
              //     ],
              //   ),
              // ),

              _buildSeptemberChallengeCard(),

              const SizedBox(height: 10),
              // Daily Goal
              _buildDailyGoalCard(),
              // _buildDailyGoal(),

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
    return

      Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sprenglish',
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
            // width: 40,
            // height: 40,
            // decoration: BoxDecoration(
            //   color: const Color(0xFF333333),
            //   borderRadius: BorderRadius.circular(20),
            // ),
            child: Row(
    children: [
    Text(AppIcon.xp,style: TextStyle(fontSize: 20),),
      SizedBox(width: 5,),

      Consumer(builder: (context,ref,child){
        final scroree =   ref.watch(UserProgress_Provider).score;
        return  Text(
          // scroree.toString() ,
          "22",
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      })

    ],
    )

            // const Icon(
            //   Icons.person,
            //   color: Colors.white,
            //   size: 24,
            // ),
          ),
        ],
      ),
    );
  }

  //
  // Widget _buildHeader() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Sprenglish',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 32,
  //               fontWeight: FontWeight.bold,
  //               letterSpacing: -0.5,
  //             ),
  //           ),
  //           const SizedBox(height: 4),
  //           Text(
  //             'Skills. Stories.',
  //             style: TextStyle(
  //               color: Colors.grey[400],
  //               fontSize: 16,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //         ],
  //       ),
  //       Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //         decoration: BoxDecoration(
  //           gradient: const LinearGradient(
  //             colors: [Color(0xFFFFB800), Color(0xFFFFA000)],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //           borderRadius: BorderRadius.circular(20),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color(0xFFFFB800).withOpacity(0.3),
  //               blurRadius: 12,
  //               offset: const Offset(0, 4),
  //             ),
  //           ],
  //         ),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Icon(
  //               Icons.stars_rounded,
  //               color: Colors.white,
  //               size: 20,
  //             ),
  //             const SizedBox(width: 6),
  //             Text(
  //               '22',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }



  Widget _buildDailyGoalCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1E1E1E),
            const Color(0xFF2A2A2A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.track_changes_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Daily Goal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '15 min / 20 min',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${(1 * 100).round()}%',
                  style: TextStyle(
                    color: const Color(0xFF2196F3),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Progress bar
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(5),
              ),
              child:
              Container(
                alignment: Alignment.topLeft,
                height: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0), // force no rounding
                  child: LinearPercentIndicator(
                    lineHeight: 10.0,
                    percent: 0.7,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.purple,
                    barRadius: const Radius.circular(4),
                    animation: true,
                    animationDuration: 1000,
                    linearStrokeCap: LinearStrokeCap.butt, // flat ends
                    padding: EdgeInsets.zero, // removes default padding
                  ),
                ),
              )
              // FractionallySizedBox(
              //   alignment: Alignment.centerLeft,
              //   widthFactor: 5,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       gradient: const LinearGradient(
              //         colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
              //       ),
              //       borderRadius: BorderRadius.circular(5),
              //       boxShadow: [
              //         BoxShadow(
              //           color: const Color(0xFF2196F3).withOpacity(0.4),
              //           blurRadius: 8,
              //           offset: const Offset(0, 2),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildSeptemberChallengeCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6B4E9C), // Purple
            Color(0xFF4A5F8C), // Blue-purple
            Color(0xFF7B5C6E), // Mauve
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      // decoration: BoxDecoration(
      //   gradient: const LinearGradient(
      //     colors: [
      //       Color(0xFF4CAF50),
      //       Color(0xFF45A049),
      //       Color(0xFF2E7D32),
      //     ],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //   ),
      //   borderRadius: BorderRadius.circular(24),
      //   boxShadow: [
      //     BoxShadow(
      //       color: const Color(0xFF4CAF50).withOpacity(0.4),
      //       blurRadius: 20,
      //       offset: const Offset(0, 8),
      //     ),
      //   ],
      // ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            right: 40,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(23.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                                size: 23,
                              ),
                              const SizedBox(width: 7),
                              Text(
                                'September Challenge',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Complete 50 sessions this month',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      // margin: EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.amber,
                        size: 32,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Progress section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(100* 50).round()}/50 sessions',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${(200 * 100).round()}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Progress bar
                Container(
                  alignment: Alignment.topLeft,
                  height: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0), // force no rounding
                    child: LinearPercentIndicator(
                      lineHeight: 10.0,
                      percent: 0.7,
                      backgroundColor: Colors.white,
                      progressColor: Colors.green,
                      barRadius: const Radius.circular(4),
                      // animation: true,
                      // animationDuration: 1000,
                      linearStrokeCap: LinearStrokeCap.butt, // flat ends
                      padding: EdgeInsets.zero, // removes default padding
                    ),
                  ),
                )

                // Container(
                //     alignment: Alignment.topLeft,
                //   height: 8,
                //   // decoration: BoxDecoration(
                //   //   color: Colors.white.withOpacity(0.3),
                //   //   borderRadius: BorderRadius.circular(4),
                //   // ),
                //   child:
                //   Container(
                //     alignment: Alignment.topLeft,
                //
                //     child: LinearPercentIndicator(
                //       lineHeight: 8.0,
                //       percent: 0.7, // 70% progress, replace with your dynamic value
                //       backgroundColor: Colors.white,
                //       progressColor: Colors.blue, // set your desired progress color
                //       // barRadius: const Radius.circular(4),
                //       barRadius: Radius.zero,
                //       animation: true,
                //       animationDuration: 1000,
                //       linearStrokeCap: LinearStrokeCap.butt
                //     ),
                //   )
                //
                //   // FractionallySizedBox(
                //   //   alignment: Alignment.centerLeft,
                //   //   widthFactor: 100,
                //   //   child: Container(
                //   //     decoration: BoxDecoration(
                //   //       color: Colors.white,
                //   //       borderRadius: BorderRadius.circular(4),
                //   //       boxShadow: [
                //   //         BoxShadow(
                //   //           color: Colors.white.withOpacity(0.5),
                //   //           blurRadius: 8,
                //   //           offset: const Offset(0, 2),
                //   //         ),
                //   //       ],
                //   //     ),
                //   //   ),
                //   // ),
                // ),
              ],
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
            alignment: Alignment.topLeft,
            // decoration: BoxDecoration(
            //   // color: const Color(0xFF404040),
            //   borderRadius: BorderRadius.circular(2),
            // ),

            child:   new LinearPercentIndicator(
              width: 300.0,
              lineHeight: 8.0,
              percent: 0.2,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
              barRadius: Radius.circular(10.0),
              // animation: true,
              // animationDuration: 1000,
              curve: Curves.easeInOut,
              // animateFromLastPercent: true,


            ),
          ),
        ],
      ),
    );
  }

  // FractionallySizedBox(
  // alignment: Alignment.centerLeft,
  // widthFactor: 0.75,
  // child: Container(
  // decoration: BoxDecoration(
  // color: const Color(0xFF2ECC71),
  // borderRadius: BorderRadius.circular(2),
  // ),
  // ),
  // ),

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
                // const Color(0xFF4A90E2),
                const Color(0xFF6C5CE7),
                const Color(0xFF74B9FF),
                screenWidth,
                    () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>TopicsScreen()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SeeImageHome()));
                  // Navigate to conversation practice
                },
              ),
              _buildPracticeCard(
                'Pronunciation',
                'Drills',
                Icons.mic,
                const Color(0xFF4ECDC4),
                const Color(0xFF7BDCB5),
                // const Color(0xFF7B68EE),
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
                const Color(0xFFFF6B6B),
                const Color(0xFFFF8E8E),
                // const Color(0xFFE74C3C),
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
                const Color(0xFFFFE66D),
                const Color(0xFFFFB74D),
                // const Color(0xFF2ECC71),
                screenWidth,
                    () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>BookStore()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NoInternetPage()));
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
      Color startColor,
      Color endColor,
      // Color iconColor,
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
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [startColor.withOpacity(0.8), endColor.withOpacity(0.8)],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //
        //
        //
        //   ),
        //   borderRadius: BorderRadius.circular(20),
        //   boxShadow: [
        //     BoxShadow(
        //       color: startColor.withOpacity(0.3),
        //       blurRadius: 15,
        //       offset: const Offset(0, 8),
        //     ),
        //   ],
        // ),

        child: Column(
          children: [
            Icon(
              icon,
              color: startColor,
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
                // color: Color(0xFF999999),
                color: Colors.white60
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
                'Launching soon',
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
            // const Icon(
            //   Icons.chevron_right,
            //   color: Color(0xFF999999),
            //   size: 20,
            // ),
          ],
        ),
      ),
    );
  }
}