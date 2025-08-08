

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Mean extends StatefulWidget {

  final Function onNext;
  const Mean({
    Key? key,
    required this.onNext

  }) : super(key: key);

  @override
  _MeanState createState() => _MeanState();
}

class _MeanState extends State<Mean> {

  var english_word = "Ability";

  FlutterTts flutterTts  = FlutterTts();

  Future _speak() async {

    await flutterTts.setLanguage("en");
    await flutterTts.setPitch(5);
    await flutterTts.speak(english_word);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speak();
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
                    'Ability',
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xFF4A5568),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'क्षमता',
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
              _buildSentenceItem('⚫उसकी ability (योग्यता) कमाल की है।'),
              SizedBox(height: 15),
              _buildSentenceItem('⚫ गणित में मेरी ability (क्षमता) बढ़ रही है।'),
              SizedBox(height: 15),
              _buildSentenceItem('⚫ हर किसी में कोई न कोई ability (काबिलियत) होती है।'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSentenceItem(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w200,
        color: Colors.white,
      ),
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