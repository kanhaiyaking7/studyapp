import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/path_provier/Current_Level.dart';
import 'package:hi/Providers/path_provier/Quiz_provider.dart';
import 'package:hi/Providers/path_provier/data_provider.dart';
import 'package:hi/Service/Path_data.dart';
import 'package:hi/components/Done.dart';
import 'package:hi/components/PrevResult.dart';
import 'package:hi/components/Result.dart';
import 'package:hi/components/WinStreak.dart';

const String study_child = 'assets/images/children_study.png';

class PathScreen extends ConsumerStatefulWidget {
  const PathScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PathScreen> createState() => _PathScreenState();
}

class _PathScreenState extends ConsumerState<PathScreen> {


  final All_path_data _all_path_data = All_path_data();// Number of completed levels


  final List<Topic> topics = [

    Topic(
        Unit_name: 'Unit1 | Topic 1',
        topic: 'Basic Rules',
        Background_color: Colors.green,
        lessons: [
          LessonData(
            title: 'Vocabulary',
            subtitle: 'शब्दावली',
            icon: Icons.book,
            Level:1,

          ),
          LessonData(
            title: 'Read with me',
            subtitle: '',
            icon: Icons.person,
            Level:2,

          ),
          LessonData(
            title: 'Grammar',
            subtitle: 'व्याकरण',
            icon: Icons.article,
            Level:3,

          ),
          LessonData(
            title: 'Listening',
            subtitle: 'सुनना',
            icon: Icons.headphones,
            Level:4,

          ),


        ]
    ),
    Topic(
        Unit_name: 'Unit 1 | Topic 2',
        topic: 'Writing Skills',
        Background_color: Colors.orange,
        lessons: [
          LessonData(
            title: 'Speaking',
            subtitle: 'बोलना',
            icon: Icons.mic,
            Level:5,

          ),

          LessonData(
            title: 'Writing',
            subtitle: 'लिखना',
            icon: Icons.edit,
            Level:6,

          ),
          LessonData(
            title: 'Pronunciation',
            subtitle: 'उच्चारण',
            icon: Icons.record_voice_over,
            Level:7,

          ),
          LessonData(
            title: 'Conversation',
            subtitle: 'बातचीत',
            icon: Icons.chat,
            Level:8,

          ),
          LessonData(
            title: 'Reading Practice',
            subtitle: 'पढ़ने का अभ्यास',
            icon: Icons.chrome_reader_mode,
            Level:9,

          ),
          LessonData(
            title: 'Final Assessment',
            subtitle: 'अंतिम मूल्यांकन',
            icon: Icons.assignment_turned_in,
            Level:10,

          ),

        ]
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    int completedLevels = ref.watch(Current_Level);


    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      //   decoration: BoxDecoration(
                      //     color: const Color(0xFF4A4A4A),
                      //     borderRadius: BorderRadius.circular(6),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //
                      //       // const Text(
                      //       //   'हि',
                      //       //   style: TextStyle(
                      //       //     color: Colors.white,
                      //       //     fontSize: 14,
                      //       //     fontWeight: FontWeight.bold,
                      //       //   ),
                      //       // ),
                      //       const SizedBox(width: 4),
                      //       const Icon(
                      //         Icons.keyboard_arrow_down,
                      //         color: Colors.white,
                      //         size: 16,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(

                        child:   CountryFlag.fromLanguageCode('hi',shape: Circle(),),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Lessons',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [

                      const SizedBox(width: 12),
                      Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        // decoration: BoxDecoration(
                        //   color: const Color(0xFFFFD700),
                        //   borderRadius: BorderRadius.circular(8),
                        // ),
                        child:  Row(
                          children: [
                            Icon(
                              Icons.currency_exchange,
                              color: Colors.orangeAccent,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Consumer(builder: (context,ref,child){
                            final scroree =   ref.watch(UserProgress_Provider).score;
                            return  Text(
                              scroree.toString() ,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                            })

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Module Header
            // Container(
            //   width: double.infinity,
            //   margin: const EdgeInsets.symmetric(horizontal: 10),
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: const Color(0xFFE97434),
            //     borderRadius: BorderRadius.circular(16),
            //   ),
            //   child:  Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //
            //               Text(
            //                 'UNIT 1 | TOPIC 1',
            //                 style: TextStyle(
            //                   color: Colors.white70,
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               SizedBox(height: 4),
            //               Text(
            //                 'Basic Rules',
            //   // 'MODULE 1 | TOPIC 1',
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //
            //
            //       // SizedBox(height: 4),
            //       // Text(
            //       //   'रोज की अंग्रेजी',
            //       //   style: TextStyle(
            //       //     color: Colors.white70,
            //       //     fontSize: 14,
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 30),
            //
            // // Daily English Title
            // const Text(
            //   'Daily English',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 18,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),

            const SizedBox(height: 30),

            // Lessons Path
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    children: [
                    for (var topic in topics) ...[
                  _buildTopicHeader(topic),
                const SizedBox(height: 10),
                for (var lesson in topic.lessons)
            _buildLessonItem(lesson,completedLevels),
            const SizedBox(height: 20),
          ]



                    // for (int i = 0; i < lessons.length; i++)
                    //   _buildLessonItem(lessons[i], i),
                  ],

                )
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTopicHeader(Topic topic) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: topic.Background_color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            topic.Unit_name ,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            topic.topic,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonItem(LessonData lesson,completedLevels) {

    return  Column(
      children: [
        GestureDetector(
          onTap: (){
           _showLessonDialog(lesson,completedLevels);
          },
          child:     Row(
            children: [
              // Left side - Circle with icon
              Container(
                width: 80, // Increase width to accommodate the border
                height: 80, // Increase height to accommodate the border
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey, // Choose your border color
                    width: 3.0, // Adjust the border thickness as needed
                  ),
                ),
                alignment: Alignment.center,
                child:
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lesson.Level < completedLevels ? Colors.greenAccent
                        : lesson.Level == completedLevels
                        ? const Color(0xFFE97434)
                        : const Color(0xFF4A4A4A),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        lesson.icon,
                        color: Colors.black,
                        size: 25,
                      ),
                      // if (lesson.isCompleted)
                      //   Positioned(
                      //     bottom: 5,
                      //     right: 5,
                      //     child: Container(
                      //       width: 20,
                      //       height: 20,
                      //       decoration: const BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Color(0xFF4CAF50),
                      //       ),
                      //       child: const Icon(
                      //         Icons.check,
                      //         color: Colors.white,
                      //         size: 12,
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // Right side - Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lesson.title,
                          style:  TextStyle(
                            color:  lesson.Level < completedLevels ? Colors.white
                                : lesson.Level == completedLevels
                                ? Colors.redAccent
                                : const Color(0xFF4A4A4A),

                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),


                        Icon(
                            lesson.Level < completedLevels ? Icons.check_circle : Icons.cloud_download,
                            color: lesson.Level < completedLevels ? Colors.green : Colors.grey,
                            size: 24),
                      ],
                    ),

                    if (lesson.subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        lesson.subtitle,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),

                    ],
                    // if (lesson.hasStartButton) ...[
                    //   const SizedBox(height: 12),
                    //   ElevatedButton(
                    //     onPressed: () {
                    //       // Handle start button tap
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         const SnackBar(
                    //           content: Text('Starting lesson...'),
                    //           backgroundColor: Color(0xFFE97434),
                    //         ),
                    //       );
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: const Color(0xFFE97434),
                    //       foregroundColor: Colors.white,
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 24,
                    //         vertical: 8,
                    //       ),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(20),
                    //       ),
                    //     ),
                    //     child: const Text(
                    //       'START HERE',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //   ),
                    // ],
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Connecting line

          Container(
            margin: const EdgeInsets.only(right:290),
            child: Container(
              width: 8,
              height: 20,
              color: const Color(0xFF4A4A4A),
            ),
          ),

        const SizedBox(height: 10),
      ],
    );
  }

  void _showLessonDialog(LessonData lesson,completedLevels) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.blueAccent.withOpacity(0.90),
          // decoration:BoxDecoration(
          //     border: Border.all(color: Colors.white)
          // ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Main curved container
              Padding(
                padding: const EdgeInsets.all(28),

                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // Header row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left side - Icon and label
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.school_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                             Text(
                              'Practice',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        // Right side - Duration badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            '2 MIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Main title
                     Text(
                      lesson.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Subtitle/Description
                    const Text(
                      'Discover how to greet people Learn',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Action button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:() async {
                          if(completedLevels <= lesson.Level){
                            final data = await  _all_path_data.get_data(completedLevels);
                            ref.read(Path_data.notifier).update_data(data, completedLevels+1);

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_)=> Pro()));

                          }if(completedLevels > lesson.Level){
                            final data =  ref.read(UserProgress_Provider).completed_level;
                          var  info = data[lesson.Level - 1];
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_)=> PrevResult( Lesson:lesson.Level,data:info)));
                          }

                          // Navigator.push(context, MaterialPageRoute(builder:
                          //     (context)=>Pro(data:data)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF2563eb),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.2),
                        ),
                        child: const Text(
                          "Let's go",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Positioned lesson icon "pointing out"

            ],
          ),
        );
      },
    );
  }

}

class LessonData {
  final String title;
  final String subtitle;
  final IconData icon;
   final  int Level;


  LessonData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.Level,

  });
}

class Topic{
  final String Unit_name;
  final String topic;
  final Color Background_color;
  final List<LessonData> lessons;

  Topic({required this.Unit_name, required this.topic,required this.Background_color ,required this.lessons});
}




