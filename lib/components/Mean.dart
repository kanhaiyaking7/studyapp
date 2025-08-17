

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hi/Providers/path_provier/data_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Mean extends ConsumerStatefulWidget{

  final Function onNext;
  // final String data;
  const Mean({
    Key? key,
    required this.onNext,
    // required this.data

  }) : super(key: key);

  @override

  ConsumerState<Mean> createState() => _MeanState();
}

class _MeanState extends ConsumerState<Mean> {

  var english_word = "Ability";
  var info ;

  // List<Map<String,dynamic>> Unique_word = [
  //   {
  //     'english_word':"Ability",
  //     'hindi_meaning':'्षमता',
  //     'some_sentence':['उसकी ability (योग्यता) कमाल की है।',
  //       'गणित में मेरी ability (क्षमता) बढ़ रही है।',
  //     'हर किसी में कोई न कोई ability (काबिलियत) होती है।']
  //   }
  // ];
 var Unique_word  ;

  FlutterTts flutterTts  = FlutterTts();

  Future _speak() async {

    await flutterTts.setLanguage("en");
    await flutterTts.setPitch(1.5);
    await flutterTts.speak(Unique_word[0]['new_word']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speak();
   final data =  ref.read(Path_data).data;
    info = data;

    var extract_data = info['Learn_newword'];

    Unique_word = extract_data;
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;



    return Scaffold(
      backgroundColor: Colors.black,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Column(
            children: [
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
              // _buildHeader(screenWidth),

              // Learn New Word Title
              _buildTitle(),

              // Teacher and Dialog Box
              _buildTeacherDialog(screenWidth),

              // Sentence Section
              _buildSentenceSection(),

              // Spacer to push Next button to bottom
              Spacer(),

              // Next Button
              _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }





  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        'Learn New Word',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTeacherDialog(double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Teacher Image
          Container(
            width: 120,
            height: 230,
            child: Image.asset(
              'assets/images/teacher.png', // Make sure to add this image to your assets
              width: 120,
              height: 230,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback if image not found
                return Container(
                  width: 120,
                  height: 230,
                  color: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),

          // Dialog Box
          Container(
            width: screenWidth * 0.5,
            height: 140,
            margin: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: Color(0xFFFBDB93),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Unique_word[0]['new_word'],
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xFF4A5568),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    Unique_word[0]['hindi_mean'],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentenceSection() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sentence',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSentenceItem(Unique_word[0]['Sentence'][0]),
              SizedBox(height: 15),
              _buildSentenceItem(Unique_word[0]['Sentence'][1]),
              // SizedBox(height: 15),
              //
              // _buildSentenceItem(Unique_word[0]['Sentence'][2]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSentenceItem(String text) {
    return Row(
      children: [
        Text("⚫"),
    Text(
    text, style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w200,
    color: Colors.white,),
    )
      ],
    );

  }

  Widget _buildNextButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: (){widget.onNext(); },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF79B72),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          alignment: Alignment.center,
          child: Text(
            'Next',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
