//
//
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
//
//
// class Translationmatchbutton extends StatefulWidget {
//
//   final result;
//     Translationmatchbutton({required this.result});
//
//   @override
//   State<Translationmatchbutton> createState() => _TranslationmatchbuttonState();
// }
//
// class _TranslationmatchbuttonState extends State<Translationmatchbutton> {
//   bool isRecording = false;
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = "";
//   bool TrigerError = false;
//
//   late String english_text = widget.messageList[widget.view_message.length].text;
//   late String hindi_text = widget.messageList[widget.view_message.length].hindi_text;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _speech = stt.SpeechToText();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _stopListening();
//   }
//
// }
//
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
//         var current_chat_no = widget.view_message.length - 1;
//         List logic = [
//           widget.messageList[current_chat_no + 1],
//           widget.messageList[current_chat_no + 2]
//         ];
//         print("++++++++++");
//         var firchange = widget.messageList[current_chat_no + 1]
//             .text
//             .toLowerCase()
//             .replaceAll(RegExp(r'[^\w\s]'), '');
//         print(firchange);
//         print(firchange == changetext);
//
//         if (changetext == firchange) {
//           // setState(() {
//           //   widget.view_message.addAll(logic);
//           //   _speak();
//           // });
//           widget.change_run(logic);
//           setState(() {
//             english_text = widget.messageList[widget.view_message.length].text;
//             hindi_text = widget.messageList[widget.view_message.length].hindi_text;
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
//
//
//   Future<void> _stopListening() async {
//     if (_isListening) {
//       await _speech.stop();
//       setState(() => _isListening = false);
//     }
//   }
//   ///done
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:
//
//         Column(
//           children: [
//             Container(
//                       width: 90,
//                       height: 90,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: isListening
//                               ? [const Color(0xFFFF6B6B), const Color(
//                               0xFFFF8E53)
//                           ]
//                               : [const Color(0xFF4CAF50), const Color(
//                               0xFF45A049)
//                           ],
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: isListening
//                                 ? const Color(0xFFFF6B6B).withOpacity(0.3)
//                                 : const Color(0xFF4CAF50).withOpacity(0.3),
//                             blurRadius: 20,
//                             spreadRadius: 5,
//                           ),
//                         ],
//                       ),
//                       child:  IconButton(
//                             icon: const Icon(Icons.mic, color: Colors.white),
//                       onPressed:_isListening ? _stopListening : _startListening,
//
//                             iconSize: 38,
//                             ),
//
//     ),
//     ]
//     ),
//     );
//
//
//
//   }
//
