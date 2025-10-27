import 'package:flutter/material.dart';
import 'dart:math';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class Imagespeak extends StatefulWidget {
  final sucessfully_speak;
  final List hints;

  Imagespeak({Key? key ,
    required this.sucessfully_speak,
    required this.hints

  }) : super(key: key);

  @override
  State<Imagespeak> createState() => _VoiceInputBottomUIState();
}

class _VoiceInputBottomUIState extends State<Imagespeak> {
  bool isRecording = false;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "";
  bool TrigerError = false;
  var actualtext = "";





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
      onError: (error) {
        print("Speech error: $error");
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
        TrigerError = false;
        _text = "";
      });
      _speech.listen(
        listenFor: const Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });

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

        var changetext = recognizedText.toLowerCase().replaceAll(
            RegExp(r'[^\w\s]'), '');

        // if(  widget.view_message.length + 2 >= widget.messageList.length  ){
        //   Navigator.pushReplacement(context,
        //       MaterialPageRoute(builder: (_)=>
        //           RolePlayCompletionScreen(resultinfo: widget.  resultinfo)));
        // }
        List second =   changetext.split(' ').toList();



        var d1 = [0,0,0,0,0];
        var held1 = 0;

        for(var a  in widget.hints){
          String  firch = a
              .toLowerCase()
              .replaceAll(RegExp(r'[^\w\s]'), '');

         List first =  firch.split(' ').toList();

        for(var j in second){
            var okk =   first.contains(j);
            if(okk){
              d1[held1] += 1;
            }
        }

        held1++;

        }

        //
        // var firchange = english_text
        //     .toLowerCase()
        //     .replaceAll(RegExp(r'[^\w\s]'), '');


        var ss =    d1.reduce((currentMax, element) => element > currentMax ? element : currentMax);
        
        var hokk = d1.indexOf(ss);

        var filtertext = widget.hints[hokk].toLowerCase().replaceAll(
            RegExp(r'[^\w\s]'), '');


        var autoii  = filtertext.split(' ').toList();

        actualtext = filtertext;
        print(changetext);
        print(actualtext);
        print(autoii);

        if (changetext == actualtext  || autoii.length - ss < 3) {

          widget.sucessfully_speak(hokk);
          setState(() {
            _text = "";
            // english_text = widget.english_word;

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
  }

  void onTextFormatPressed() {
    print("Text format button pressed");

  }

  @override
  Widget build(BuildContext context) {


    return
      Container(
                width: double.infinity,
                // height: 190,

                // color: Colors.black,
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [
                //       Color(0xFF6366F1),
                //       Color(0xFF8B5CF6),
                //       // Color(0xFFEC4899),
                //     ],
                //   ),
                // ),

                child: Column(

                  children: [

                    Container(
                      child:   TrigerError  ? Text('Speak again 👉🏽${actualtext}',
                          style:TextStyle(color: Colors.red,fontSize: 20))
                          :Container(),
                    ),

                    Container(
                      height: 140,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),

                        child:     SingleChildScrollView(

                          physics: BouncingScrollPhysics(),
                        child:
                        Column(
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
                            Container(
                              alignment: Alignment.center,
                              child:  Text(
                                _text.isNotEmpty ? _text : "...",
                                style: TextStyle(
                                  color:  TrigerError
                                      ? Colors.red[400]: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                              ,
                            ),

                            // const Spacer(),



                            // Main content area

                            // const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Container(
                                  width: 85,
                                  height: 85,
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
                                    iconSize: 40,
                                  ),

                                ),

                              ],
                            ),




                          ],
                        ),
                        )
                      ),
                    )
                  ],
                ),
              );



  }
}