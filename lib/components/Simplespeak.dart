

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SimpleSpeak extends StatefulWidget {
  final Function onNext;
  const SimpleSpeak({required this.onNext});
  @override
  _SimpleSpeakState createState() => _SimpleSpeakState();
}

class _SimpleSpeakState extends State<SimpleSpeak>
    with TickerProviderStateMixin {

  final SpeechToText _speechToText = SpeechToText();


  var english_word = 'how are you';
  var hindi_word =  'आप कैसे हैं?';
  var speaking_word = "";
  bool _speechEnabled = false;
  String _wordsSpoken = " ";
  double _confidenceLevel = 0;

  bool _sucessfull = false;

  String dd = "done";

  FlutterTts flutterTts  = FlutterTts();

  Future _speak() async {

    await flutterTts.setLanguage("hi");
    await flutterTts.setPitch(5);
    await flutterTts.speak(hindi_word);
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glowController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    // Create color animation
    _textColorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.yellow,
    ).animate(_glowController);

    // Start the animation loop
    _glowController.repeat(reverse: true);
    initSpeech();
    _speak();
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
    setState(() {
      speaking_word = storage;
    });
    // setState(() {
    //   _wordsSpoken = "${result.recognizedWords}";
    //   _confidenceLevel = result.confidence;
    // });


    if(storage == english_word){
      print("perfect");
      widget.onNext();
      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.success,
      //   text: 'Transaction Completed Successfully!',
      // );
      // setState(() {
      //
      //   _sucessfull = true;
      // });
    }

  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      // dd="ho gay";

    });
  }







  bool isRecording = false;
  late AnimationController _glowController;
  late Animation<Color?> _textColorAnimation;


  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Color(0xFF1A1A1A),
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              // _buildHeader(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.close_sharp,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  Container(child:
                  new LinearPercentIndicator(
                    width: 250.0,
                    lineHeight: 8.0,
                    percent: 0.2,
                    backgroundColor: Colors.white,
                    progressColor: Colors.blue,
                    barRadius: Radius.circular(10.0),
                    animation: true,
                    animationDuration: 1000,
                    curve: Curves.easeInOut,
                    animateFromLastPercent: true,


                  ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.grid_view,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),

              // Chat Message
              _buildChatMessage(),

              // Center Content
              Expanded(
                child: _buildCenterContent(),
              ),
            if(speaking_word.length > 2)
        Container(
        width: double.infinity,
        height: 70,
        color: Colors.black,
        child:   Center(
          child: Container(
            // child: QuickAlertButtons(options: options)),
              child: Text('${speaking_word}',style: TextStyle(fontSize: 30,color: Colors.white),)),
        ),),

      Container(
        color: Colors.black,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Speaker button
            Container(
              width: 59,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF333333),
                borderRadius: BorderRadius.circular(27),
              ),
              child: IconButton(
                icon: const Icon(Icons.volume_up, color: Colors.white),
                onPressed: () {_speak();},
                iconSize: 22,
              ),
            ),
            const SizedBox(width: 40),

            // Microphone button
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
                iconSize: 38,
              ),
            ),
            const SizedBox(width: 80),
          ],
        ),

              // Voice Controls
              // _buildVoiceControls(),

              // Bottom Indicator
      ) // _buildBottomIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          // Close Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          // Progress Container
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFF333333),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6B35),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Header Right
          Row(
            children: [
              // Lock Icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 16,
                ),
              ),

              SizedBox(width: 10),

              // Coin Container
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBBF24),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '15',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFF333333),
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedBuilder(
          animation: _textColorAnimation,
          builder: (context, child) {
            return Text(
              'How are you?',
              style: TextStyle(
                color: _textColorAnimation.value,
                fontSize: 16,
                shadows: [
                  Shadow(
                    color: Colors.yellow.withOpacity(0.75),
                    blurRadius: 10,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }

  Widget _buildCenterContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _textColorAnimation,
            builder: (context, child) {
              return Text(
                english_word,
                style: TextStyle(
                  color: _textColorAnimation.value,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.yellow.withOpacity(0.75),
                      blurRadius: 10,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              );
            },
          ),

          SizedBox(height: 10),

          Text(
           hindi_word,
            style: TextStyle(
              color: Color(0xFF888888),
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceControls() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Record Button
          GestureDetector(
            onTap: toggleRecording,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFFFF6B35),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFF6B35).withOpacity(isRecording ? 0.8 : 0.5),
                    blurRadius: isRecording ? 30 : 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                isRecording ? Icons.pause : Icons.volume_up,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),

          // Mic Button
          GestureDetector(
            onTap: () {
              // Handle mic button tap
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF333333),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.mic,
                color: Color(0xFF666666),
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomIndicator() {
    return Container(
      width: 134,
      height: 5,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}