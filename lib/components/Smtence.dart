

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hi/Providers/path_provier/Quiz_provider.dart';
import 'package:hi/Providers/path_provier/data_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Sentence extends ConsumerStatefulWidget{
  final Function onNext;
  // final String data;
 const Sentence({required this.onNext,
   // required this.data
 });
  @override
  ConsumerState<Sentence> createState() => _SentenceState();
}

class _SentenceState extends ConsumerState<Sentence> {
  String? selectedAnswer;
  var info;
  var unique_sentence;

 late List<Map<dynamic,dynamic>> Sentence_quiz = [
    {
      'hindi_question': unique_sentence[0]['hind_Sentence'],
      'options':[unique_sentence[0]['english_sentence'][0].toString()  ,
        unique_sentence[0]['english_sentence'][1].toString(),
        unique_sentence[0]['english_sentence'][2].toString()],
      // ['This book is good.','I like food.',
      //   'He is very cute.','I bought a new toy.'],
      'correct_ans':unique_sentence[0]['corr_sentence']

    },
  ];

  // final List<String> options = ['go', 'went', 'going', 'gone'];

  // var english_word = "I go to the park";

  FlutterTts flutterTts  = FlutterTts();

  Future _speak() async {

    await flutterTts.setLanguage("hi");
    await flutterTts.setPitch(1);
    await flutterTts.speak(Sentence_quiz[0]['hindi_question']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speak();

    final data =  ref.read(Path_data).data;
    info = data;
    var extract_data = info['choose_correct_sentence'];
    unique_sentence= extract_data;

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              // question 4/20 and time 18:45
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
              // Header



              // Question Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),

                      // Question Text
                      _buildQuestionText(),

                      SizedBox(height: 40),

                      // Answer Options
                      _buildAnswerOptions(),

                      Spacer(),

                      // Use Hint Button
                      _buildUseHintButton(),

                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              // Footer Check Button
              _buildFooterCheckButton(),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildQuestionText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose the correct Hindi sentence meaning in brackets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20),
        Text(
          Sentence_quiz[0]['hindi_question'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        // RichText(
        //   text: TextSpan(
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 16,
        //       height: 1.5,
        //     ),
        //     children: [
        //       TextSpan(text: 'I '),
        //       TextSpan(
        //         text: '______',
        //         style: TextStyle(
        //           decoration: TextDecoration.underline,
        //           decorationColor: Colors.white,
        //           decorationThickness: 2,
        //         ),
        //       ),
        //       TextSpan(text: ' (go) to the park eve...'),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _buildAnswerOptions() {
   final List<String> option =  Sentence_quiz[0]['options'];
    return Column(
      children: option.map((option) {
        final isSelected = selectedAnswer == option;
        final isCorrect = option == Sentence_quiz[0]['correct_ans']; // Assuming 'go' is the correct answer

        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 15),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedAnswer = option;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF00BCD4) : Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Color(0xFF00BCD4) : Color(0xFF3A3A3A),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUseHintButton() {
    return GestureDetector(
      onTap: () {
        // Handle hint button tap
        _showHintDialog();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: Color(0xFF00BCD4),
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            'Use Hint',
            style: TextStyle(
              color: Color(0xFF00BCD4),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterCheckButton() {
    final bool isAnswerSelected = selectedAnswer != null;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: isAnswerSelected ? () {
          // Handle check answer
          _checkAnswer();
        } : null,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: isAnswerSelected ? Color(0xFF4CAF50) : Color(0xFF3A3A3A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Check Answer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHintDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF2A2A2A),
          title: Row(
            children: [
              Icon(Icons.lightbulb, color: Color(0xFF00BCD4)),
              SizedBox(width: 8),
              Text(
                'Hint',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          content: Text(
            "Sorry ,I can't help you",
            // 'Think about the present tense form of the verb that matches with "I".',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Got it!',
                style: TextStyle(color: Color(0xFF00BCD4)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _checkAnswer() {
    final isCorrect = selectedAnswer == Sentence_quiz[0]['correct_ans'];
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
                  : 'The correct answer is ${Sentence_quiz[0]['correct_ans']}. Try again next time!',
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


}