import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/ImageReading/Imageresult.dart';
import 'package:hi/ImageReading/Imagespeak.dart';
import 'package:hi/Providers/ImageReading/imageread.dart';

class SeeImage extends ConsumerStatefulWidget {
  final data;
  const SeeImage({Key? key, required this.data}) : super(key: key);

  @override
  ConsumerState<SeeImage> createState() => _SeeImageState();
}

class _SeeImageState extends ConsumerState<SeeImage> {
  bool isHintExpanded = false;
  bool isRecording = false;
  String spokenText = "";
  int lineCount = 0;

  int level = 0;


  // [
  //  "They are sitting inside a room with a large window.",
  //   "Describe what you see in the image",
  //   "Talk about the children and their activities",
  //   "Mention the background and setting",
  // ];


 // late String speaktext = "";




  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
      if (isRecording) {
        // Simulate recording - In real app, integrate speech recognition
        spokenText = "Listening...";
      }
    });
  }

  // void simulateSpeechInput(String text) {
  //   setState(() {
  //     if (lineCount < 2) {
  //       if (spokenText == "Listening...") {
  //         spokenText = text;
  //       } else {
  //         spokenText += "\n" + text;
  //       }
  //       lineCount++;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print("reprint++++++++");
    print(level);
    late List<String> hints = widget.data[level].content;

     String currentimage = widget.data[level].Imageread;

      List<String> realhints = [
      "💡 ${hints[0]}",
      "💡 ${hints[1]}",
      "🎯 ${hints[2]}",
      "🌟 ${hints[3]}",
      "🌟 ${hints[4]}",

    ];
    void _showHintDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFFF7FAFC),
            title:  Column(
              children: [
                Text("Hint", style: TextStyle(
                  color: Color(0xFF2D3748),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                Container(
                  // padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: realhints.map((hint) {
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                hint,
                                style: const TextStyle(
                                  color: Color(0xFF4A5568),
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

          );
        },
      );
    }

    nextquestion(){
      if(level >= widget.data.length - 1){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            Imageresult(score: 55, totalQuestions: 100, correctAnswers: 77)));
      }else{
        print("nextqus");
        setState(() {
          isHintExpanded = false;
          spokenText = "";
          lineCount=0;
          level++;

        });

      }

    }

    void completespeak(indexnu){
      print("sucess");

      setState(() {
        spokenText+= "\n" + realhints[indexnu];
        print("${lineCount}" + "aaaaaaaaal");
        lineCount++;

        // speaktext
      });

      if(lineCount==2){
        print("kokoko");
        Future.delayed(const Duration(milliseconds: 1500),(){
          if(mounted) {
            nextquestion();
          }
        });
      }

    }

    var currentQuestion = 5;
  var   totalQuestions = 55;

    return Scaffold(
      backgroundColor:Colors.black.withOpacity(0.2),
      // const Color(0xFFF5F7FA),
      appBar: AppBar(

        backgroundColor: Colors.black.withOpacity(0.2),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2D3748)),
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Imageresult(score: 55, totalQuestions: 100, correctAnswers: 77)))
              // Navigator.pop(context)
          ,
        ),
        title: const Text(
          'Speak About Image',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$currentQuestion/$totalQuestions',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // Image Section
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  // 'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/practice/30095.webp',
                  widget.data[level].Imageread,
                // 'https://cdn.shopify.com/s/files/1/2081/8163/files/Image--1.jpg?v=1606459201',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 80, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Speaking Lines Section
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Line $lineCount/2',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),

                      const Icon(
                        Icons.mic_none,
                        color: Color(0xFF667EEA),
                        size: 20,
                      ),
                      // const SizedBox(width: 4),
                      //
                      // const Text(
                      //   'Speak clearly',
                      //   style: TextStyle(
                      //     color: Color(0xFF667EEA),
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                  // const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        spokenText.isEmpty
                            ? 'Press the microphone button and speak 2 lines about the image...'
                            : spokenText,
                        style: TextStyle(
                          color: spokenText.isEmpty
                              ? Colors.white
                              : const Color(0xFF2D3748),
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Hints Section
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    _showHintDialog();
                    // setState(() {
                    //   isHintExpanded = !isHintExpanded;
                    // });
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBD38D).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.lightbulb_outline,
                            color: Color(0xFFF6AD55),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Need Help? View Hints',
                          style: TextStyle(
                            color: Color(0xFF2D3748),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          isHintExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: const Color(0xFF667EEA),
                        ),
                      ],
                    ),
                  ),
                ),
                // if (isHintExpanded)
                //   Container(
                //     padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                //     child: Column(
                //       children: realhints.map((hint) {
                //         return Container(
                //           margin: const EdgeInsets.only(top: 8),
                //           padding: const EdgeInsets.all(12),
                //           decoration: BoxDecoration(
                //             color: const Color(0xFFF7FAFC),
                //             borderRadius: BorderRadius.circular(12),
                //             border: Border.all(
                //               color: const Color(0xFFE2E8F0),
                //             ),
                //           ),
                //           child: Row(
                //             children: [
                //               Expanded(
                //                 child: Text(
                //                   hint,
                //                   style: const TextStyle(
                //                     color: Color(0xFF4A5568),
                //                     fontSize: 14,
                //                     height: 1.4,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         );
                //       }).toList(),
                //     ),
                //   ),
              ],
            ),
          ),

          // Microphone Button
          Imagespeak( sucessfully_speak:completespeak, hints :hints ),
          // Container(
          //   padding: const EdgeInsets.all(24),
          //   child: GestureDetector(
          //     onTap: toggleRecording,
          //     child: Container(
          //       width: 80,
          //       height: 80,
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           colors: isRecording
          //               ? [const Color(0xFFFC8181), const Color(0xFFF56565)]
          //               : [const Color(0xFF667EEA), const Color(0xFF764BA2)],
          //           begin: Alignment.topLeft,
          //           end: Alignment.bottomRight,
          //         ),
          //         shape: BoxShape.circle,
          //         boxShadow: [
          //           BoxShadow(
          //             color: (isRecording
          //                 ? const Color(0xFFFC8181)
          //                 : const Color(0xFF667EEA))
          //                 .withOpacity(0.4),
          //             blurRadius: 20,
          //             offset: const Offset(0, 10),
          //           ),
          //         ],
          //       ),
          //       child: Icon(
          //         isRecording ? Icons.stop : Icons.mic,
          //         color: Colors.white,
          //         size: 36,
          //       ),
          //     ),
          //   ),
          // ),
          //
          // // Demo Button (Remove in production)
          // if (isRecording && lineCount < 2)
          //   Padding(
          //     padding: const EdgeInsets.only(bottom: 16),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         simulateSpeechInput(
          //           lineCount == 0
          //               ? "I can see children studying together in a classroom."
          //               : "They are reading books with a beautiful mountain view in the background.",
          //         );
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: const Color(0xFF48BB78),
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 24,
          //           vertical: 12,
          //         ),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //       ),
          //       child: const Text('Demo: Add Line'),
          //     ),
          //   ),
        ],
      ),
    );
  }

}



class LevelDatainfo {
  final String name;
  final int level;

  LevelDatainfo({required this.name, required this.level});
}

class ResultDataInfo {
  final String title;
  final String id;

  ResultDataInfo({required this.title, required this.id});
}



