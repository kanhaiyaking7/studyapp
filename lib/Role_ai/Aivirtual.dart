

import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hi/Providers/Aichat_provider/Aichat_provider.dart';
import 'package:hi/Role_ai/Animation.dart';
import 'package:hi/Role_ai/SpeakButt.dart';
import 'package:hi/Role_ai/VideoAnim.dart';
import 'package:hi/Role_ai/logic_ai.dart';
import 'package:video_player/video_player.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AIVirtual extends ConsumerStatefulWidget {
  final result;
  final resultinfo;
  AIVirtual({required this.result, required this.resultinfo});
  @override
  ConsumerState<AIVirtual> createState() => _AIVirtualState();
}

class _AIVirtualState extends ConsumerState<AIVirtual> {
  final TextEditingController _messageController = TextEditingController();
  // final SpeechToText _speechToText = SpeechToText();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "";
  bool TrigerError = false;

  ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }


  FlutterTts flutterTts  = FlutterTts();

  // print(widget.result[0].output[0].hindiMean);
  ////
  late List josh = widget.result;
  late List<dynamic> _messages = josh;
  late var questionlength = _messages.length;
  // [
  //
  //   ChatMessage(
  //     text: "Hello! What's your name?",
  //     isUser: false,
  //   hindi_text: 'नमस्ते! आपका नाम क्या है?',
  //      chat_no: 1
  //   ),
  //   ChatMessage(
  //     text: "Hello! My name is Amit. And you?",
  //     isUser: true,
  //    hindi_text: 'नमस्ते! मेरा नाम अमित है। और आप?',
  //     chat_no: 2
  //   ),
  //   ChatMessage(
  //     text: "My name is Rakesh. It's nice to meet you.",
  //     isUser: false,
  //     hindi_text: 'मेरा नाम राकेश है। आपसे मिलकर अच्छा लगा।',
  //     chat_no: 3
  //
  //   ),
  //   // ChatMessage(
  //   //   text: "It's nice to meet you too.",
  //   //   isUser: true,
  //   // hindi_text: 'मुझे भी आपसे मिलकर ख़ुशी हुई।',
  //   //   chat_no: 4
  //   // ),
  //   ChatMessage(
  //     text: "Hello. I am fine.",
  //     isUser: true,
  //    hindi_text: 'नमस्ते। मैं ठीक हूँ। टेबल खाली है क्या?',
  //     chat_no: 4
  //   ),
  //   ChatMessage(
  //       text: "Yes, of course. How many people are you?",
  //       isUser: false,
  //       hindi_text: 'मजी, बिलकुल। कितने लोग हैं आप?',
  //     chat_no: 5
  //
  //   ),
  //   ChatMessage(
  //       text: "We are two people.",
  //       isUser: true,
  //       hindi_text: 'हम दो लोग हैं।',
  //       chat_no: 6
  //
  //   ),
  //   ChatMessage(
  //       text: "Come this way, sir. This table will be perfect for you.",
  //       isUser: false,
  //       hindi_text: 'इधर आइये, सर। यह टेबल आपके लिए सही रहेगी।',
  //       chat_no: 7
  //
  //   ),
  //   ChatMessage(
  //       text: "Yes, of course. How many people are you?",
  //       isUser: true,
  //       hindi_text: 'इधर आइये, सर। यह टेबल आपके लिए सही रहेगी|',
  //       chat_no: 8
  //
  //   ),
  //   ChatMessage(
  //       text: "Thank you.",
  //       isUser: false,
  //       hindi_text: 'शुक्रिया।',
  //       chat_no: 9
  //
  //   ),
  //
  // ];

  late List message_data = [
    _messages[0],
  ];

  late FlickManager flickManager;

  var speaking_word = "";


  var speak_complete  = false;

  void speak_done(){
    setState(() {
    speak_complete = !speak_complete;
    });

}




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // initSpeech();
    _speech = stt.SpeechToText();
    _speak();
    flickManager = FlickManager(videoPlayerController:
    VideoPlayerController.asset('assets/video/avator_ai.mp4'));

  }

  Future _speak() async {


    // pitch = 1.0;
   var voice = 'en-us-x-sfg#female_1-local';

    await flutterTts.setLanguage("en");
    await flutterTts.setPitch(1.0);
   await flutterTts.setVoice({'name': voice, 'locale': 'en-US'});


  var done =   await flutterTts.speak(message_data.last.text);
 var wwe =  await flutterTts.awaitSpeakCompletion(true);

 if(wwe == 1){
   speak_done();
 }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flickManager.dispose();
    // _stopListening();
    _scrollController.dispose();
  }

  void re_run(query){

    setState(() {
      message_data.addAll(query);
      _speak();
    });

    _scrollToBottom();
  }

  // void initSpeech() async {
  // var  _speechEnabled =  await _speechToText.initialize();
  //
  //
  //   setState(() {
  //     _messages.add(
  //       ChatMessage(
  //       text: "😊😊hi",
  //       isUser: true,
  //       timestamp: DateTime.now().subtract(Duration(minutes: 5)),
  //     ),
  //     );
  //
  //
  //   });
  // }

 //  void _startListening() async{
 // var wwe =   await _speechToText.listen(onResult: _onSpeechResult),listenfor:Duration(se);
 //
 //  }
  ///////////////////////////////////////////////
//   Future<void> _startListening() async {
//     bool available = await _speech.initialize(
//       // It's generally better to handle errors and status changes, but don't stop the mic here
//       // based on "notListening" or "done" if you expect a final result.
//       onError: (error) {
//         print("Speech error: $error");
//       },
//     );
//
//     if (available) {
//       setState(() {
//         _isListening = true;
//         TrigerError = false;
//       });
//       _speech.listen(
//         listenFor: const Duration(seconds: 30),
//         pauseFor: Duration(seconds: 5),
//         onResult: (result) {
//           // This callback is where you get the recognized words.
//           // It might be called multiple times with partial results.
//           setState(() {
//             _text = result.recognizedWords;
//           });
//
//           // The key is to check if this is the final result.
//           // Once the final result is in, you can process the text and stop listening.
//           if (result.finalResult) {
//             // This ensures you only process the complete, final sentence.
//             _stopAndProcessText(result.recognizedWords);
//           }
//         },
//       );
//     }
//   }
//
// // A new function to handle processing after the final result is in
//   Future<void> _stopAndProcessText(String recognizedText) async {
//     if (_isListening) {
//       await _speech.stop();
//       setState(() => _isListening = false);
//
//       if (recognizedText.isNotEmpty) {
//         var changetext = recognizedText.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
//         print(changetext);
//
//         var current_chat_no = message_data.length - 1;
//         List logic = [
//           _messages[current_chat_no + 1],
//           _messages[current_chat_no + 2]
//         ];
//         print("++++++++++");
//         var firchange = _messages[current_chat_no + 1]
//             .text
//             .toLowerCase()
//             .replaceAll(RegExp(r'[^\w\s]'), '');
//         print(firchange);
//         print(firchange == changetext);
//
//         if (changetext == firchange) {
//           setState(() {
//             message_data.addAll(logic);
//             _speak();
//           });
//         } else {
//           print("@@@@@@");
//           setState(() {
//             TrigerError = true;
//           });
//         }
//       }
//     }
//   }
//
//   Future<void> _stopListening() async {
//     if (_isListening) {
//       await _speech.stop();
//       setState(() => _isListening = false);
//     }
//   }
  ////////////////////////////////////////////

////////////////real code
  // Future<void> _startListening() async {
  //   bool available = await _speech.initialize(
  //     onStatus: (status) {
  //       if (status == "done" || status == "notListening") {
  //         // Mic stopped automatically when user stopped speaking
  //
  //         _stopListening();
  //       }
  //     },
  //     onError: (error) {
  //       print("Speech error: $error");
  //     },
  //   );
  //
  //   if (available) {
  //     setState(
  //           () =>( _isListening = true,
  //           TrigerError = false)
  //
  //     );
  //     _speech.listen(
  //       listenFor: const Duration(seconds: 30),
  //       pauseFor: Duration(seconds: 5),
  //       onResult: (result) {
  //         setState(() {
  //           _text = result.recognizedWords;
  //         });
  //       },
  //     );
  //   };
  // }
  //
  // Future<void> _stopListening() async {
  //   if (_isListening) {
  //     await _speech.stop();
  //     setState(() => _isListening = false);
  //
  //     if (_text.isNotEmpty) {
  // var changetext = _text.toLowerCase().replaceAll(new RegExp(r'[^\w\s]'), '');
  //       print(changetext);
  //
  //       var current_chat_no = message_data.length - 1;//0
  //       var data_chat_no  = _messages.length;//6
  //       List logic = [_messages[current_chat_no + 1] , _messages[current_chat_no+ 2] ];
  //       print("++++++++++");
  //       var firchange = _messages[current_chat_no + 1].text.toLowerCase().replaceAll(new RegExp(r'[^\w\s]'), '');
  //       print(firchange);
  //
  //       if(changetext == firchange){
  //         setState(() {
  //           message_data.addAll(logic);
  //           _speak();
  //
  //         });
  //       }
  //       else{
  //         print("@@@@@@");
  //         setState(() {
  //           TrigerError = true;
  //         });
  //       }
  //
  //
  //
  //       // _sendToServer(_text);
  //     }
  //   }
  // }
  ////end code

 //  void _onSpeechResult(result){
 //    // print(result.recognizedWords);
 //    var storage = result.recognizedWords;
 //
 //
 //    setState(() {
 //      speaking_word = storage;
 //    });
 //    // setState(() {
 //    //   _wordsSpoken = "${result.recognizedWords}";
 //    //   _confidenceLevel = result.confidence;
 //    // });
 //
 //
 //
 //  }
 //
 //  void _stopListening() async {
 // var result =    await _speechToText.stop();
 //
 //
 //    setState(() {
 //      // dd="ho gay";
 //
 //    });
 //  }
 //
 //



  @override
  Widget build(BuildContext context) {
    // final data =  ref.watch(AiChat_provider);
    // print(widget.result[0].output[0].hindiMean);
    // print("OOOOOOOOO");
    return Scaffold(
      // backgroundColor: Color(0xFF1E1E1E),
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF2D2D2D),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: Row(
      //     children: [
      //       // CircleAvatar(
      //       //   radius: 20,
      //       //   backgroundColor: Color(0xFF3D3D3D),
      //       //   child: Icon(Icons.person, color: Colors.white70),
      //       // ),
      //       // SizedBox(width: 12),
      //       Expanded(
      //         child:
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               "Bane Gibsonwa",
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.w600,
      //               ),
      //             ),
      //             // Text(
      //             //   "Online",
      //             //   style: TextStyle(
      //             //     color: Colors.green,
      //             //     fontSize: 12,
      //             //   ),
      //             // ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     // IconButton(
      //     //   icon: Icon(Icons.videocam, color: Colors.white),
      //     //   onPressed: () {},
      //     // ),
      //     // IconButton(
      //     //   icon: Icon(Icons.call, color: Colors.white),
      //     //   onPressed: () {},
      //     // ),
      //     IconButton(
      //       icon: Icon(Icons.more_vert, color: Colors.white),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Positioned.fill(child: Videoanim(speak:speak_complete)),



      Column(
        children: [
          // Video Call Section
          // Container(
          //   width: double.infinity,
          //   height: 300,//190
          //   child:  Videoanim(),
          // ),

          // Container(
          //   width: double.infinity,
          //   height: 200,
          //   // margin: EdgeInsets.all(16),
          //   // decoration: BoxDecoration(
          //   //   color: Color(0xFF2D2D2D),
          //   //   borderRadius: BorderRadius.circular(12),
          //   //   border: Border.all(color: Color(0xFF3D3D3D)),
          //   // ),
          //   child: Stack(
          //     children: [
          //       Center(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             // AspectRatio(aspectRatio: 5/2,
          //             //   child: FlickVideoPlayer(flickManager: flickManager),)
          //
          //             // Icon(
          //             //   Icons.videocam_off,
          //             //   size: 48,
          //             //   color: Colors.white54,
          //             // ),
          //             // SizedBox(height: 8),
          //             // Text(
          //             //   "Video call not active",
          //             //   style: TextStyle(
          //             //     color: Colors.white54,
          //             //     fontSize: 16,
          //             //   ),
          //             // ),
          //           ],
          //         ),
          //       ),
          //       // Positioned(
          //       //   top: 12,
          //       //   right: 12,
          //       //   child: Container(
          //       //     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //       //     decoration: BoxDecoration(
          //       //       color: Colors.blue,
          //       //       borderRadius: BorderRadius.circular(12),
          //       //     ),
          //       //     child: Text(
          //       //       "Wanna Talk?",
          //       //       style: TextStyle(
          //       //         color: Colors.white,
          //       //         fontSize: 12,
          //       //         fontWeight: FontWeight.w500,
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),

          // Messages Section
          // if(message_data.length > 2){
          //
          // }
          const SizedBox(height: 40),
          Container(
            alignment: Alignment.topRight,
            child: IconButton(

        icon: Icon(Icons.close, color: Colors.black, size: 30,),
    onPressed: () => Navigator.pop(context),),
          ),

          // const SizedBox(height: 350),
          const SizedBox(height: 280),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: message_data.length,
              itemBuilder: (context, index) {
                final message = message_data[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          TrigerError == true ? Text('Speak again',
    style:TextStyle(color: Colors.red,fontSize: 20))
        : Container(),




          // Voice Message Section
          // BottomVoiceUI(),
          VoiceInputBottomUI(
              messageList:_messages,
              view_message :message_data,
              change_run :re_run,
              speak_complete: speak_complete,
              speak_fun: speak_done,
              resultinfo:widget.resultinfo
          ),
    //       Container(
    //         margin: EdgeInsets.all(12),
    //         padding: EdgeInsets.all(12),
    //         decoration: BoxDecoration(
    //           color: Color(0xFF2D2D2D),
    //           borderRadius: BorderRadius.circular(12),
    //         ),
    //         child: Column(
    //           children: [
    //             // if(_text.length > 2)
    //
    //               Container(
    //                 // width: double.infinity,
    //                 // height: 70,
    //                 // color: Colors.black,
    //                 child:   Center(
    //                   child: Container(
    //                     // child: QuickAlertButtons(options: options)),
    //                     //   child:   Text('${speaking_word}',
    //                        child:  Column(children: [
    //                          Text(_messages[message_data.length].text,
    //                                   // " ${_text}",
    //                               style: TextStyle(
    //                                     color: Colors.white,
    //                               fontSize: 20,
    //                        fontWeight: FontWeight.w500,
    //     ),
    //   ),
    //
    // ],
    // )
    //                        ),
    //
    //                 ),
    //
    //
    //               ) ,
    //
    //             // SizedBox(height: 8),
    //             // Text(
    //             //   "\"Nice to meet you!\"",
    //             //   style: TextStyle(
    //             //     color: Colors.white54,
    //             //     fontSize: 14,
    //             //   ),
    //             // ),
    //
    //             SizedBox(height: 16),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //
    //                 Container(
    //                   width: 75,
    //                   height: 76,
    //                   decoration: BoxDecoration(
    //                     color: const Color(0xFFFF9500),
    //                     borderRadius: BorderRadius.circular(36),
    //                   ),
    //                   child: IconButton(
    //                     icon: const Icon(Icons.mic, color: Colors.white),
    //                     onPressed:_isListening ? _stopListening : _startListening,
    //                     // onPressed: (){},
    //                     iconSize: 38,
    //                   ),
    //                 ),
    //
    //                 // IconButton(
    //                 //   icon: Icon(Icons.send_rounded, color: Colors.white54),
    //                 //   onPressed: () {},
    //                 // ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),

          ///Message Input
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
          //           onPressed: (){},
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
        ],
      )
    );
  }

  Widget _buildMessageBubble( message) {
    // print(message.text);
    // print("qq");
    return Container(
      // margin: EdgeInsets.only(bottom: 56),
      margin: EdgeInsets.only(top:30),

      child: Row(
        mainAxisAlignment:
        message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[

            SizedBox(width: 1),
          ],
          Flexible(
            child: Container(
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue.withOpacity(0.2) : Color(0xFF3D3D3D).withOpacity(0.8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
    children: [
      Text(
        message.text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,

        ),
      ),
      Text(
        message.hindi_text,
        style: TextStyle(
          // color: Colors.grey,
          color: message.isUser ? Colors.black : Colors.grey,
          fontSize: 12,

        ),
      ),
    ],
    )

            ),
          ),
          if (message.isUser) ...[
            SizedBox(width: 1),

          ],
        ],
      ),
    );
  }
}

// class ChatMessage {
//   final String text;
//   final String hindi_text;
//   final bool isUser;
//   final int chat_no;
//
//
//   ChatMessage({
//     required this.text,
//     required this.hindi_text,
//     required this.isUser,
//     required this.chat_no
//
//   });
// }

