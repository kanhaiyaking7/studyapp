

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class AIVirtual extends StatefulWidget {
  @override
  _AIVirtualState createState() => _AIVirtualState();
}

class _AIVirtualState extends State<AIVirtual> {
  final TextEditingController _messageController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "😊😊\nnice to know you~",
      isUser: true,
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    ChatMessage(
      text: "Sure~",
      isUser: false,
      timestamp: DateTime.now().subtract(Duration(minutes: 4)),
    ),
    ChatMessage(
      text: "What's your name?",
      isUser: true,
      timestamp: DateTime.now().subtract(Duration(minutes: 3)),
    ),
    ChatMessage(
      text: "Nice to meet you!",
      isUser: false,
      timestamp: DateTime.now().subtract(Duration(minutes: 2)),
    ),
    ChatMessage(
      text: "Nice to meet you!",
      isUser: false,
      timestamp: DateTime.now().subtract(Duration(minutes: 2)),
    ),
    ChatMessage(
      text: "Nice to meet you!",
      isUser: false,
      timestamp: DateTime.now().subtract(Duration(minutes: 2)),
    ),

  ];
  late FlickManager flickManager;


  var speaking_word = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeech();
    flickManager = FlickManager(videoPlayerController: VideoPlayerController.asset('assets/video/avator_ai.mp4'));

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flickManager.dispose();
  }

  void initSpeech() async {
  var  _speechEnabled =  await _speechToText.initialize();


    setState(() {
      _messages.add(
        ChatMessage(
        text: "😊😊hi",
        isUser: true,
        timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      ),
      );


    });
  }

  void _startListening() async{
 var wwe =   await _speechToText.listen(onResult: _onSpeechResult);

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



  }

  void _stopListening() async {
 var result =    await _speechToText.stop();


    setState(() {
      // dd="ho gay";

    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF2D2D2D),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFF3D3D3D),
              child: Icon(Icons.person, color: Colors.white70),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bane Gibsonwa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Online",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Video Call Section
          Container(
            width: double.infinity,
            height: 200,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF3D3D3D)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(aspectRatio: 16/7,child: FlickVideoPlayer(flickManager: flickManager),)
                      // Icon(
                      //   Icons.videocam_off,
                      //   size: 48,
                      //   color: Colors.white54,
                      // ),
                      // SizedBox(height: 8),
                      // Text(
                      //   "Video call not active",
                      //   style: TextStyle(
                      //     color: Colors.white54,
                      //     fontSize: 16,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Wanna Talk?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Messages Section
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Voice Message Section
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
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: IconButton(
                    //     icon: Icon(Icons.mic, color: Colors.white, size: 28),
                    //     onPressed: () {},
                    //   ),
                    // ),
                    // IconButton(
                    //   icon: Icon(Icons.send_rounded, color: Colors.white54),
                    //   onPressed: () {},
                    // ),
                  ],
                ),
              ],
            ),
          ),

          // Message Input
          // Container(
          //   padding: EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     color: Color(0xFF2D2D2D),
          //     border: Border(
          //       top: BorderSide(color: Color(0xFF3D3D3D), width: 1),
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           controller: _messageController,
          //           style: TextStyle(color: Colors.white),
          //           decoration: InputDecoration(
          //             hintText: "Type a message...",
          //             hintStyle: TextStyle(color: Colors.white54),
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(25),
          //               borderSide: BorderSide(color: Color(0xFF3D3D3D)),
          //             ),
          //             enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(25),
          //               borderSide: BorderSide(color: Color(0xFF3D3D3D)),
          //             ),
          //             focusedBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(25),
          //               borderSide: BorderSide(color: Colors.blue),
          //             ),
          //             filled: true,
          //             fillColor: Color(0xFF3D3D3D),
          //             contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //           ),
          //         ),
          //       ),
          //       SizedBox(width: 8),
          //       Container(
          //         decoration: BoxDecoration(
          //           color: Colors.blue,
          //           shape: BoxShape.circle,
          //         ),
          //         child: IconButton(
          //           icon: Icon(Icons.send, color: Colors.white),
          //           onPressed: () {
          //             if (_messageController.text.trim().isNotEmpty) {
          //               setState(() {
          //                 _messages.add(
          //                   ChatMessage(
          //                     text: _messageController.text.trim(),
          //                     isUser: true,
          //                     timestamp: DateTime.now(),
          //                   ),
          //                 );
          //                 _messageController.clear();
          //               });
          //             }
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
        message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[

            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue : Color(0xFF3D3D3D),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            SizedBox(width: 8),

          ],
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

// Example usage in main.dart:
/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Virtual Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AIVirtual(),
    );
  }
}
*/