
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hi/Speaking/ShowVideo.dart';
import 'package:speech_to_text/speech_to_text.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StudyStep {
  final String title;
  final String englishText;
  final String hindiText;
  final bool isActive;

  StudyStep({
    required this.title,
    required this.englishText,
    required this.hindiText,
    this.isActive = false,
  });
}

class VideoStudy extends StatefulWidget {
  const VideoStudy({Key? key}) : super(key: key);

  @override
  State<VideoStudy> createState() => _VideoStudyState();
}

class _VideoStudyState extends State<VideoStudy> {
  int currentStep = 1; // 0 = Step 1, 1 = Step 2, 2 = Step 3
  int currentQuestionIndex = 0;
  double playbackSpeed = 1.0;
  bool isPlaying = false;

  final SpeechToText _speechToText = SpeechToText();
  var speaking_word = "";

  FlutterTts flutterTts  = FlutterTts();

  Future _speak() async {

    await flutterTts.setLanguage("en");
    await flutterTts.setPitch(5);
    await flutterTts.speak("ji");
  }

  void initSpeech() async {
    var  _speechEnabled =  await _speechToText.initialize();
  }

  void _startListening() async{
    var wwe =   await _speechToText.listen(onResult: _onSpeechResult);
  }

  void _onSpeechResult(result){

    var storage = result.recognizedWords;
    setState(() {
      speaking_word = storage;
    });
    if(storage == questions[0]['english'] ){
      setState(() {
        currentQuestionIndex++ ;
      });

    }

  }

  void _stopListening() async {
    var result =    await _speechToText.stop();
  }


  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeech();
  }

  final List<StudyStep> steps = [
    StudyStep(
      title: 'Step 1',
      englishText: 'Listen and repeat',
      hindiText: 'सुनें और दोहराएं',
    ),
    StudyStep(
      title: 'Step 2',
      englishText: 'Who said that?',
      hindiText: 'किसने कहा कि?',
      isActive: true,
    ),
    StudyStep(
      title: 'Step 3',
      englishText: 'Fill in the blanks',
      hindiText: 'रिक्त स्थान भरें',
    ),
  ];

  final List<Map<String, String>> questions = [
    {'english': 'hello', 'hindi': 'नमस्ते'},
    {'english': 'I am here for a job interview', 'hindi': 'मैं यहाँ नौकरी के लिए साक्षात्कार देने आया हूँ'},
    {'english': 'how are you', 'hindi': 'आप कैसे हैं?'},
    {'english': 'Where are you going?', 'hindi': 'आप कहाँ जा रहे हैं?'},
    {'english': 'What time is it', 'hindi': 'समय क्या है?'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 400,
                height: 250,
              child:   VideoFormat(),
            ),
            // Status bar info

            // Study content area
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Step indicators


                      const SizedBox(height: 30),

                      // Study content
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Speed control


                              const SizedBox(height: 20),

                              // Question content
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      questions[currentQuestionIndex]['english']!,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),

                                    Container(
                                      height: 3,
                                      width: 100,
                                      color: Colors.black,
                                      margin: const EdgeInsets.symmetric(vertical: 16),
                                    ),

                                    Text(
                                      questions[currentQuestionIndex]['hindi']!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              // Navigation and progress
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (currentQuestionIndex > 0) {
                                        setState(() {
                                          currentQuestionIndex--;
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(Icons.arrow_back_ios, size: 20),
                                    ),
                                  ),

                                  Text(
                                    '${currentQuestionIndex + 1}/${questions.length}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      if (currentQuestionIndex < questions.length - 1) {
                                        setState(() {
                                          currentQuestionIndex++;
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(Icons.arrow_forward_ios, size: 20),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Add button

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom complete button
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  if(speaking_word.length > 2)
                    Container(
                      // width: double.infinity,
                      // height: 70,
                      // color: Colors.black,
                      child:   Center(
                        child: Container(
                          // child: QuickAlertButtons(options: options)),
                          child:   Text('${speaking_word}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),),
                      ),


                    ) ,

                  // SizedBox(height: 8),
                  // Text(
                  //   "\"Nice to meet you!\"",
                  //   style: TextStyle(
                  //     color: Colors.white54,
                  //     fontSize: 14,
                  //   ),
                  // ),

                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        width: 75,
                        height: 76,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9500),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.mic, color: Colors.white),
                          onPressed: _speechToText.isListening ? _stopListening : _startListening,
                          // onPressed: (){},
                          iconSize: 38,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}