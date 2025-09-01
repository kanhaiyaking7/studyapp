import 'package:flutter/material.dart';
import 'package:hi/Speaking/ShowVideo.dart';
import 'package:hi/Speaking/SpeakButt.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool isMuted = false;
  bool isListening = false;
  int message = 0;


  final List UserSpeak = [
    "Hello",
    "I am here for a job interview",
        "My name is Simon",
    "Where is it",
    "Got it. Thanks",
        "Good morning",
    "Nice to meet you, Sir I am Simson"

  ];

   complet_mic(){
    setState(() {
      message++;
      play_anim;
    });
}

stop_anim(person){
     person();
}

play_anim(person){
     person();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.bookmark_border, color: Colors.orange),
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //         content: Text('Book bookmarked!'),
          //         backgroundColor: Colors.orange,
          //         duration: Duration(seconds: 2),
          //       ),
          //     );
          //   },
          // ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(20),
              ),
              child:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.videocam, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    '1/10',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

    Container(
            decoration: BoxDecoration(
              // color: Colors.red.shade600,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ),

          ]
            ),

          // IconButton(
          //   icon: const Icon(Icons.share, color: Colors.white),
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //         content: Text('Sharing book...'),
          //         backgroundColor: Colors.orange,
          //         duration: Duration(seconds: 2),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            // Top decoration bar
            Container(
              width: double.infinity,
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade400,
                    Colors.purple.shade400,
                    Colors.pink.shade400,
                  ],
                ),
              ),
            ),

            // Header with counter and close button
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //         decoration: BoxDecoration(
            //           color: Colors.blue.shade600,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: const Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Icon(Icons.videocam, color: Colors.white, size: 20),
            //             SizedBox(width: 8),
            //             Text(
            //               '1/10',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       Container(
            //         decoration: BoxDecoration(
            //           color: Colors.red.shade600,
            //           shape: BoxShape.circle,
            //         ),
            //         child: IconButton(
            //           onPressed: () {},
            //           icon: const Icon(Icons.close, color: Colors.white),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Video placeholder container with decorative elements

              Container(

                width: 400,
                height: 240,
                child:   VideoFormat(
                 person_stop:stop_anim,
                  person_play:play_anim,
                ),
              ),

              // Container(
              //   width: double.infinity,
              //   margin: const EdgeInsets.symmetric(horizontal: 16),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFF2A2A2A),
              //     borderRadius: BorderRadius.circular(16),
              //     border: Border.all(
              //       color: Colors.grey.shade700,
              //       width: 1,
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.3),
              //         blurRadius: 10,
              //         offset: const Offset(0, 4),
              //       ),
              //     ],
              //   ),
              //   child: Stack(
              //     children: [
              //       // Background pattern
              //       Positioned.fill(
              //         child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(16),
              //             gradient: LinearGradient(
              //               begin: Alignment.topLeft,
              //               end: Alignment.bottomRight,
              //               colors: [
              //                 Colors.grey.shade800.withOpacity(0.3),
              //                 Colors.grey.shade900.withOpacity(0.1),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       // Video placeholder icon
              //       const Center(
              //         child: Icon(
              //           Icons.videocam_off,
              //           size: 80,
              //           color: Colors.grey,
              //         ),
              //       ),
              //       // YouTube logo overlay
              //       Positioned(
              //         bottom: 16,
              //         right: 16,
              //         child: Container(
              //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //           decoration: BoxDecoration(
              //             color: Colors.black.withOpacity(0.7),
              //             borderRadius: BorderRadius.circular(4),
              //           ),
              //           child: const Text(
              //             'YouTube',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 12,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // ),
            // ),

            const SizedBox(height: 44),


            // Text input container with decorative elements
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  // color: Colors.blue.shade600.withOpacity(0.3),
                  color: Colors.blueAccent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade600.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Cloud icon decoration
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Icon(
                      Icons.cloud_outlined,
                      size: 40,
                      color: Colors.blue.shade400,
                    ),
                  ),

                  // Text content
                   Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      UserSpeak[message],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const  Spacer(),

            // const SizedBox(height: 24),

            // Tap to speak text
            const Text(
              'Tap to speak',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 10),

            // Microphone button
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
              ),


              child:
                 Speakbutt(
                     messageList:UserSpeak[message],
                     complete_speak:complet_mic
                 )
              ),



            // Padding(
            //   padding: const EdgeInsets.only(bottom: 32),
            //   child: GestureDetector(
            //     onTapDown: (_) {
            //       setState(() {
            //         isListening = true;
            //       });
            //     },
            //     onTapUp: (_) {
            //       setState(() {
            //         isListening = false;
            //       });
            //     },
            //     onTapCancel: () {
            //       setState(() {
            //         isListening = false;
            //       });
            //     },
            //     child: Container(
            //       width: 80,
            //       height: 80,
            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //           colors: isListening
            //               ? [Colors.red.shade400, Colors.red.shade600]
            //               : [Colors.blue.shade400, Colors.blue.shade600],
            //         ),
            //         shape: BoxShape.circle,
            //         boxShadow: [
            //           BoxShadow(
            //             color: (isListening ? Colors.red : Colors.blue).withOpacity(0.3),
            //             blurRadius: 20,
            //             offset: const Offset(0, 4),
            //           ),
            //         ],
            //       ),
            //       child: Icon(
            //         isMuted ? Icons.mic_off : Icons.mic,
            //         color: Colors.white,
            //         size: 32,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),

            // Warning stripe at bottom
            // Container(
            //   width: double.infinity,
            //   height: 20,
            //   decoration: BoxDecoration(
            //     color: Colors.yellow.shade600,
            //     gradient: LinearGradient(
            //       colors: [
            //         Colors.black,
            //         Colors.yellow.shade600,
            //         Colors.black,
            //         Colors.yellow.shade600,
            //         Colors.black,
            //       ],
            //       stops: const [0.0, 0.2, 0.4, 0.6, 0.8],
            //     ),
            //   ),
            //   child: const Center(
            //     child: Text(
            //       'BOTTOM OVERFLOWED BY 16 PIXELS',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 10,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}