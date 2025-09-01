import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Speakbutt extends StatefulWidget {

  final messageList;
  final complete_speak;

   Speakbutt({super.key,
   required this.messageList,
   required this.complete_speak});

  @override
  State<Speakbutt> createState() => _SpeakbuttState();
}

class _SpeakbuttState extends State<Speakbutt> {

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "";
  bool TrigerError = false;

  late var user_message = widget.messageList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stopListening();
  }


  Future<void> _startListening() async {
    bool available = await _speech.initialize(
      // It's generally better to handle errors and status changes, but don't stop the mic here
      // based on "notListening" or "done" if you expect a final result.
      onError: (error) {
        print("Speech error: $error");
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
        TrigerError = false;
      });
      _speech.listen(
        listenFor: const Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        onResult: (result) {
          // This callback is where you get the recognized words.
          // It might be called multiple times with partial results.
          setState(() {
            _text = result.recognizedWords;
          });

          // The key is to check if this is the final result.
          // Once the final result is in, you can process the text and stop listening.
          if (result.finalResult) {
            // This ensures you only process the complete, final sentence.
            _stopAndProcessText(result.recognizedWords);
          }
        },
      );
    }
  }

// A new function to handle processing after the final result is in
  Future<void> _stopAndProcessText(String recognizedText) async {
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);

      if (recognizedText.isNotEmpty) {
        var changetext = recognizedText.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
        print(changetext);


        var firchange = widget.messageList
            .toLowerCase()
            .replaceAll(RegExp(r'[^\w\s]'), '');
        print(firchange);
        print("WWWWWWW");

        if (changetext == firchange) {
          // setState(() {
          //   widget.view_message.addAll(logic);
          //   _speak();
          // });
          widget.complete_speak();
          setState(() {
           user_message = widget.messageList;
          });
        } else {
          print("@@@@@@");
          setState(() {
            TrigerError = true;
          });
        }
      }
    }
  }



  Future<void> _stopListening() async {
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
    }
  }
  ///done

  void onSpeakerPressed() {
    print("Speaker button pressed");

    // Add your speaker functionality here
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:

          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade600],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color:  Colors.blue.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.mic, color: Colors.white),
              onPressed:_isListening ? _stopListening : _startListening,
              // onPressed: (){},
              iconSize: 38,
            ),
          ),


    );
  }
}
