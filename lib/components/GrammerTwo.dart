
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hi/Providers/path_provier/data_provider.dart';

class LanguageLearningScreen extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  // final String data;


  LanguageLearningScreen({required this.onNext,
    // required this.data
  });


  @override
  ConsumerState<LanguageLearningScreen> createState() => _LanguageLearningScreenState();
}

class _LanguageLearningScreenState extends ConsumerState<LanguageLearningScreen> {
  String? selectedAnswer;
  bool showResult = false;
  var info;
  var unique_sentence;

  late List<Map<String,dynamic>> question  = [
    {
      'dash_question':unique_sentence[0]['hindi_word'],
      'meaning':unique_sentence[0]['english_mean'],
      'option_list':unique_sentence[0]['opt'],
      'correct_ans':unique_sentence[0]['corr_ans'],
    }
  ];

  FlutterTts flutterTts  = FlutterTts();

  Future _speak() async {


    await flutterTts.setLanguage("en");
    await flutterTts.setPitch(5);
    await flutterTts.speak(question[0]['meaning']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speak();
    final data =  ref.read(Path_data).data;
    info = data;
    var extract_data = info['complete_hindi_sentence'];
    unique_sentence= extract_data;

  }


  void _checkAnswer() {
    // setState(() {
    //   showResult = true;
    // });

    // Show result dialog or navigate to next question
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       selectedAnswer == 'is' ? 'Correct!' : 'Try again!',
    //     ),
    //     backgroundColor: selectedAnswer == 'is'
    //         ? const Color(0xFF4CAF50)
    //         : const Color(0xFFFF5722),
    //   ),
    // );

      final isCorrect = selectedAnswer == question[0]['correct_ans'];
      if(isCorrect){
        widget.onNext();
      }
      else{
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color(0xFF2A2A2A),
              title: Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                  SizedBox(width: 8),
                  Text(
                    isCorrect ? 'Correct!' : 'Incorrect',
                    style: TextStyle(
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              content: Text(
                isCorrect
                    ? 'Well done! You selected the correct answer.'
                    : 'The correct answer is =>${question[0]['correct_ans']}<=. Try again next time!',
                style: TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Move to next question or handle completion
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Color(0xFF00BCD4)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onNext();
                    // Move to next question or handle completion
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Color(0xFF00BCD4)),
                  ),
                ),
              ],

            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: SafeArea(
        child:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Complete the sentence',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 60),

              // Main content area
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Hindi sentence with blank
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.baseline,
                            // textBaseline: TextBaseline.alphabetic,
                            children: [
                              Column(
                                children: [
                                  // Text(
                                  //   'main',
                                  //   style: TextStyle(
                                  //     color: Colors.grey[400],
                                  //     fontSize: 16,
                                  //   ),
                                  // ),
                                   Text(
                                    question[0]['dash_question'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                ],
                              ),
                              // const SizedBox(width: 10),
                              // // Blank space
                              // Container(
                              //   width: 80,
                              //   height: 3,
                              //   // margin: const EdgeInsets.symmetric(horizontal: 10),
                              //   margin: const EdgeInsets.only(top: 34.0),
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius: BorderRadius.circular(2),
                              //   ),
                              // ),
                              // const SizedBox(width: 10),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     // Text(
                              //     //   'hoon',
                              //     //   style: TextStyle(
                              //     //     color: Colors.grey[400],
                              //     //     fontSize: 16,
                              //     //   ),
                              //     // ),
                              //     const Text(
                              //       'my house.gone hi gi shaui jhdwub wjhe7',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 22,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Text(
                            question[0]['meaning'],
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Answer options
              Column(
                children: [
                  _buildAnswerOption(question[0]['option_list'][0],question[0]['option_list'][0]),
                  const SizedBox(height: 12),
                  _buildAnswerOption(question[0]['option_list'][1],  question[0]['option_list'][1]),
                ],
              ),

              const SizedBox(height: 30),

              // Check button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedAnswer != null ? _checkAnswer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedAnswer != null
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFF5A5A5A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'CHECK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerOption(String english, String value) {
    bool isSelected = selectedAnswer == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = value;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A90E2) : const Color(0xFF4A4A4A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF6BB6FF) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [

            const SizedBox(height: 4),
            Text(
              english,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }


}

