
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hi/Reading/ChapterCompletion.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:video_player/video_player.dart';


const String bookcover = 'assets/images/bookcover.jpg';

class Reading extends StatefulWidget {
  final content;
  final cover;

  const Reading({required this.content,required this.cover});
  @override
  _ReadingState createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {


  bool isPlaying = false;
  double progress = 0.0;
  late FlickManager flickManager;
  int currentIndex = 0;

  FlutterTts flutterTts  = FlutterTts();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // flickManager = FlickManager(videoPlayerController: VideoPlayerController.asset('assets/video/avator_ai.mp4'));
    _speak();

  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flickManager.dispose();

  }





  late List contents = widget.content;
  // [
  //   ReadingContent(
  //     englishText: "Once upon a time there lived 4 cows in a forest. Every day they used to graze together.",
  //     hindiText: "एक समय की बात है जंगल में 4 गाय रहती थी।  हर दिन वे एक साथ चरते थे।",
  //   ),
  //   ReadingContent(
  //     englishText: "They were very close friends and always stood by each other in a times of need",
  //     hindiText: "वे बहुत करीबी दोस्त थे और जरूरत के समय हमेशा एक-दूसरे के साथ खड़े रहते थे",
  //   ),
  //   ReadingContent(
  //     englishText: "Whenever some wiled animals tried to attack them, all of them got together and chased them away.",
  //     hindiText: " जब भी कुछ जंगली जानवरों ने उन पर हमला करने की कोशिश की, वे सभी एकजुट हो जाते और उसका पीछा करते थे",
  //   ),
  //   ReadingContent(
  //     englishText: "There lived a big lion in the forest who wished to kill and eat cows.",
  //     hindiText: "जंगल में एक बड़ा शेर रहता था जो गायों को मारने और खाने की इच्छा रखता था।",
  //   ),
  //   ReadingContent(
  //     englishText: "Whenever the lion tried to attack any one of the cows, all cows united together and fought with the lion.",
  //     hindiText: "जब भी शेर ने गायों में से किसी एक पर हमला करने की कोशिश की, सभी गायों ने एकजुट होकर शेर से लड़ाई की।",
  //   ),
  //   ReadingContent(
  //     englishText: "Though the lion had more strength than that of the cows, it could not stand in front of their unity",
  //     hindiText: "हालाँकि शेर गायों की तुलना में अधिक शक्तिशाली था , लेकिन यह उनकी एकता के सामने नहीं टिक सकता था।",
  //   ),
  //   ReadingContent(
  //     englishText: "He understood that it was not possible for him to kill any one of them as long as they are united.",
  //     hindiText: "वह समझ गया कि जब तक वे एकजुट होंगे, उनमें से किसी एक को मारना उसके लिए संभव नहीं था।",
  //   ),
  //   ReadingContent(
  //     englishText: "There lived a big lion in the forest who wished to kill and eat cows.",
  //     hindiText: "जंगल में एक बड़ा शेर रहता था जो गायों को मारने और खाने की इच्छा रखता था।",
  //   ),
  //   ReadingContent(
  //     englishText: "There lived a big lion in the forest who wished to kill and eat cows.",
  //     hindiText: "जंगल में एक बड़ा शेर रहता था जो गायों को मारने और खाने की इच्छा रखता था।",
  //   ),
  // ];

   ready(){
    _speak();
}

  Future _speak() async {
print(contents[currentIndex].hindiText);
print("___________");
    await flutterTts.setLanguage("hi");
    await flutterTts.setPitch(1);
    await flutterTts.speak(contents[currentIndex].hindiText);
    await flutterTts.awaitSpeakCompletion(true);
    print("LLLLLLLL");
    // await  Future.delayed(const Duration(seconds: 1));

    _speakEnglish();
  }

  Future _speakEnglish() async {
    await flutterTts.setLanguage("en");
    await flutterTts.setPitch(1);
    await flutterTts.speak(contents[currentIndex].englishText);
    print("--------------");
    print(currentIndex);
    setState(() {
      currentIndex++;
      if(currentIndex < contents.length - 1){
        _speak();
      }else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder:
            (_)=>ChapterCompletionScreen(cover:widget.cover)));

      }

    });

  }



  @override
  Widget build(BuildContext context) {
     print(widget.content);
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        elevation: 0,
        title: Text(
          "Reading Book",
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
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Divider line
          Container(
            height: 1,
            color: Colors.grey[800],
            margin: EdgeInsets.symmetric(horizontal: 16),
          ),

          SizedBox(height: 24),

          // Image/Avatar section
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFF3D3D3D), width: 1),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // AspectRatio(aspectRatio: 16/7, child: FlickVideoPlayer(flickManager: flickManager),)
                    // Image.asset(
                    //     bookcover,
                    //     width: 340,
                    //     height: 190,
                    //     fit:BoxFit.fill
                    // ),
                    Image.network(widget.cover.coverUrl,width: 340,height: 190,fit: BoxFit.fill,)
                    // Image.network(
                    //     'https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/BookCover/images/bookcover1.jpg',
                    //   width: 340,
                    //   height: 190,
                    //   fit: BoxFit.fill,
                    // ),
                    // Icon(
                    //   Icons.person,
                    //   size: 80,
                    //   color: Colors.white54,
                    // ),
                    // SizedBox(height: 8),
                    // Text(
                    //   "Image Placeholder",
                    //   style: TextStyle(
                    //     color: Colors.white54,
                    //     fontSize: 16,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 32),

          // Content section
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // English text
                  Text(
                    contents[currentIndex].englishText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: 16),
                  Column(crossAxisAlignment:CrossAxisAlignment.start
                    ,children: [

                    Text(

                    contents[currentIndex].hindiText,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),],),


                  // Hindi text


                  SizedBox(height: 24),

                  // Additional content if there are more items
                  if (currentIndex < contents.length - 1) ...[
                    SizedBox(height: 16),
                    Text(
                      contents[currentIndex + 1].englishText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Text(
                    //   contents[currentIndex + 1].hindiText,
                    //   style: TextStyle(
                    //     color: Colors.white70,
                    //     fontSize: 15,
                    //     height: 1.5,
                    //   ),
                    // ),
                  ],
                ],
              ),
            ),
          ),

          // Navigation buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: currentIndex > 0 ? Colors.white : Colors.grey,
                  ),
                  onPressed: currentIndex > 0 ? () {
                    setState(() {
                      currentIndex--;
                    });
                  } : null,
                ),
                Text(
                  "${currentIndex + 1} / ${contents.length}",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: currentIndex < contents.length - 1 ? Colors.white : Colors.grey,
                  ),
                  onPressed: currentIndex < contents.length - 1 ? () {
                    setState(() {
                      currentIndex++;
                    });
                  } : null,
                ),
              ],
            ),
          ),

          // Speak button
          // Container(
          //   width: double.infinity,
          //   margin: EdgeInsets.all(24),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       setState(() {
          //         isPlaying = !isPlaying;
          //       });
          //       // Add text-to-speech functionality here
          //       _simulatePlayback();
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.blue,
          //       foregroundColor: Colors.white,
          //       padding: EdgeInsets.symmetric(vertical: 16),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //       elevation: 4,
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(
          //           isPlaying ? Icons.pause : Icons.volume_up,
          //           size: 24,
          //         ),
          //         SizedBox(width: 8),
          //         Text(
          //           isPlaying ? "Pause" : "Speak",
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // Progress indicator


          // Bottom navigation indicator
          Container(
            height: 4,
            width: 60,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }


}

class ReadingContent {
  final String englishText;
  final String hindiText;

  ReadingContent({
    required this.englishText,
    required this.hindiText,
  });
}




