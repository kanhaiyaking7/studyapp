import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:speech_to_text/speech_to_text.dart';





class Speaking_english extends StatefulWidget {

  final VoidCallback onNext;


  Speaking_english({required this.onNext});


  @override
  State<Speaking_english> createState() => _Speaking_englishState();


}
class _Speaking_englishState extends State<Speaking_english>{

  final SpeechToText _speechToText = SpeechToText();


  bool _speechEnabled = false;
  String _wordsSpoken = " ";
  double _confidenceLevel = 0;

  bool _sucessfull = false;

  String dd = "done";
  
  FlutterTts flutterTts  = FlutterTts();

Future _speak() async {
  print("ggg");
 await flutterTts.setLanguage("hi");
 await flutterTts.setPitch(5);
 await flutterTts.speak("किताब मेज पर है");
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled =  await _speechToText.initialize();
    setState(() {

    });
  }

  void _startListening() async{
    await _speechToText.listen(onResult: _onSpeechResult);

  }

  void _onSpeechResult(result){
    // print(result.recognizedWords);
    var storage = result.recognizedWords;
    // setState(() {
    //   _wordsSpoken = "${result.recognizedWords}";
    //   _confidenceLevel = result.confidence;
    // });

    if(storage == 'the book is on the table'){
      print("perfect");
      setState(() {
        // dd="ho gay";
        _sucessfull = true;
      });
    }

  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E6EE9),
      body: SafeArea(
        child: Column(
          children: [
            // Top section with back button, title, question count and progress bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),

                      // Title and question count
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        width: 250,
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: 0.7,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
                            backgroundColor: Color(0xffD6D6D6),
                          ),
                        ),
                      ),
                      // Grid button
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.grid_view,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // const SizedBox(height: 16),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: 20),
                  //   width: 300,
                  //   height: 20,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     child: LinearProgressIndicator(
                  //       value: 0.7,
                  //       valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
                  //       backgroundColor: Color(0xffD6D6D6),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),

            // Robot image
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Robot image placeholder
                  Container(
                    width: 120,
                    height: 120,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Icon(
                      Icons.smart_toy,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  // Shadow below robot
                  Container(
                    width: 80,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // English text
                   Text(
                    "The book is ${dd} on the table",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Hindi text
              ElevatedButton(
                onPressed: () {_speak();},
                child:    const Text(
                  'किताब मेज पर है',

                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ), )

                ],
              ),
            ),

            // Blue button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ElevatedButton(
                onPressed: () {_speak();},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child:_sucessfull ?  Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      child:  Text(
                        'deH!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                    ),

                    ),
                    Text(
                      'नमस्ते',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ):null,
              ),
            ),

            // Audio control buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Speaker button
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF333333),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.volume_up,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  // Microphone button
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF8C00),
                      shape: BoxShape.circle,
                    ),
                    child:
                    FloatingActionButton(onPressed: _speechToText.isListening ? _stopListening : _startListening,tooltip: 'Listen',
                      child:  const Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 30,
                      ), )


                  ),
                ],
              ),
            ),

            // Home indicator bar
            Container(
              width: 150,
              height: 5,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



