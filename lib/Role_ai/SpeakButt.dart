import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class VoiceInputBottomUI extends StatefulWidget {
  final  messageList;
  final view_message;
  final change_run;
   VoiceInputBottomUI({Key? key ,required this.messageList ,
   required this.view_message,
   required this.change_run}) : super(key: key);

  @override
  State<VoiceInputBottomUI> createState() => _VoiceInputBottomUIState();
}

class _VoiceInputBottomUIState extends State<VoiceInputBottomUI> {
  bool isRecording = false;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "";
  bool TrigerError = false;

  late String english_text = widget.messageList[widget.view_message.length].text;
  late String hindi_text = widget.messageList[widget.view_message.length].hindi_text;

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

        var current_chat_no = widget.view_message.length - 1;
        List logic = [
          widget.messageList[current_chat_no + 1],
          widget.messageList[current_chat_no + 2]
        ];
        print("++++++++++");
        var firchange = widget.messageList[current_chat_no + 1]
            .text
            .toLowerCase()
            .replaceAll(RegExp(r'[^\w\s]'), '');
        print(firchange);
        print(firchange == changetext);

        if (changetext == firchange) {
          // setState(() {
          //   widget.view_message.addAll(logic);
          //   _speak();
          // });
          widget.change_run(logic);
          setState(() {
            english_text = widget.messageList[widget.view_message.length].text;
            hindi_text = widget.messageList[widget.view_message.length].hindi_text;
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



  void onTextFormatPressed() {
    print("Text format button pressed");
    // Add your text formatting functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(

          child:   TrigerError == true ? Text('Speak again',
              style:TextStyle(color: Colors.red,fontSize: 20))
              :Container(),
        ),

      Container(
      height: 180,
      width: double.infinity,

      decoration:  BoxDecoration(
        color: Color(0xFF1E1E1E),
        // color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

        child: Column(
          children: [


            // Top indicator bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),


            // Main content area
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Status text
                  Text(
                    english_text,
                    style: TextStyle(
                      color:  TrigerError
                          ? Colors.red[400]: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle text
                  // TrigerError == true ? Text('Speak again',
                  //     style:TextStyle(color: Colors.red,fontSize: 20))
                  //     :Container(),
                  // Text(
                  //   hindi_text,
                  //   style: TextStyle(
                  //     color: Colors.grey[400],
                  //     fontSize: 14,
                  //   ),
                  // ),
                  // const SizedBox(height: 24),

                  // Control buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Speaker button
                      GestureDetector(
                        onTap: onSpeakerPressed,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.volume_up,
                            color: Colors.grey[300],
                            size: 24,
                          ),
                        ),
                      ),

                      // Microphone button (main/larger)

                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: TrigerError
                                ? [Colors.red[400]!, Colors.red[600]!]
                                : [Colors.blue[400]!, Colors.blue[600]!],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: (TrigerError? Colors.red : Colors.blue).withOpacity(0.3),
                              blurRadius: 12,
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


                      // Text format button
                      GestureDetector(
                        onTap: onTextFormatPressed,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.text_fields,
                                color: Colors.grey[300],
                                size: 20,
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[700],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'A',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    )
      ],
    );


      Container(
      height: 210,
      width: double.infinity,

      decoration:  BoxDecoration(
        color: Color(0xFF1E1E1E),
        // color: Colors.red[600],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

        child: Column(
          children: [


            // Top indicator bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),


            // Main content area
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Status text
                  Text(
                    english_text,
                    style: TextStyle(
                      color:  TrigerError
                      ? Colors.red[400]: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle text
                  TrigerError == true ? Text('Speak again',
                      style:TextStyle(color: Colors.red,fontSize: 20))
                      :Container(),
                  // Text(
                  //   hindi_text,
                  //   style: TextStyle(
                  //     color: Colors.grey[400],
                  //     fontSize: 14,
                  //   ),
                  // ),
                  // const SizedBox(height: 24),

                  // Control buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Speaker button
                      GestureDetector(
                        onTap: onSpeakerPressed,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.volume_up,
                            color: Colors.grey[300],
                            size: 24,
                          ),
                        ),
                      ),

                      // Microphone button (main/larger)

              Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: TrigerError
                                  ? [Colors.red[400]!, Colors.red[600]!]
                                  : [Colors.blue[400]!, Colors.blue[600]!],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: (TrigerError? Colors.red : Colors.blue).withOpacity(0.3),
                                blurRadius: 12,
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


                      // Text format button
                      GestureDetector(
                        onTap: onTextFormatPressed,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.text_fields,
                                color: Colors.grey[300],
                                size: 20,
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[700],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'A',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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