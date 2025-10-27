import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:hi/ImageReading/Imagespeak.dart';

class Imagereading extends StatefulWidget {
  const Imagereading({Key? key}) : super(key: key);

  @override
  State<Imagereading> createState() => _ImagereadingState();
}

class _ImagereadingState extends State<Imagereading>
    with TickerProviderStateMixin {
  // Sample sentences with translations
  final List<Map<String, dynamic>> sentences = [
    {
      'english': 'BANG! SPLAT!',
      'hindi': 'धमाका! धड़ाम!',
      'words': [ 'how','are','you', 'you','are', 'the','best','you','are'],
    },
    {
      'english': 'What is that?',
      'hindi': 'वह क्या है?',
      'words': ['What', 'is', 'that?'],
    },
    {
      'english': 'The cat is sleeping.',
      'hindi': 'बिल्ली सो रही है।',
      'words': ['The', 'cat', 'is', 'sleeping.'],
    },
  ];

 late  String speaktext = sentences[0]['words'][0];
 int textno  = 0;

  int currentSentenceIndex = 0;
  int score = 0;
  Set<int> spokenWordIndices = {};
  bool isListening = false;
  bool showTranslation = true;

  late AnimationController _micController;
  late AnimationController _wordController;
  late AnimationController _imageController;
  late Animation<double> _micAnimation;
  late Animation<double> _wordAnimation;
  late Animation<double> _imageAnimation;

  @override
  void initState() {
    super.initState();

    _micController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _wordController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _imageController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _micAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _micController, curve: Curves.easeInOut),
    );

    _wordAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _wordController, curve: Curves.elasticOut),
    );

    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeOutBack),
    );

    _imageController.forward();
  }

  @override
  void dispose() {
    _micController.dispose();
    _wordController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      isListening = !isListening;
    });

    if (isListening) {
      _micController.repeat(reverse: true);
      // Simulate speech recognition - mark random words as spoken
      _simulateSpeechRecognition();
    } else {
      _micController.stop();
      _micController.reset();
    }
  }

  void _simulateSpeechRecognition() {
    // Simulate word by word recognition
    final words = sentences[currentSentenceIndex]['words'] as List<String>;
    int currentWord = spokenWordIndices.length;

    if (currentWord < words.length) {
      print(currentWord);
      Future.delayed(Duration(milliseconds: 800), () {
          setState(() {
            spokenWordIndices.add(currentWord);
            score += 10;
            textno+=1;
            speaktext = sentences[0]['words'][textno];
          });
          _wordController.forward(from: 0);

          if (spokenWordIndices.length < words.length) {
            print("ww");
            // _simulateSpeechRecognition();
          } else {
            // All words spoken
            // _toggleListening();
            _showCompletionDialog();
          }



      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6a00ff),
                Color(0xFF9d00ff),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF6a00ff).withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.celebration,
                  color: Color(0xFFffd369),
                  size: 60,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Excellent!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You read the sentence perfectly!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _nextSentence();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFffd369),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Next Sentence',
                  style: TextStyle(
                    color: Color(0xFF1a1a2e),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextSentence() {
    setState(() {
      currentSentenceIndex = (currentSentenceIndex + 1) % sentences.length;
      spokenWordIndices.clear();
    });
    _imageController.forward(from: 0);
  }

  void completespeak(){
    print("done");
    _simulateSpeechRecognition();
  }

  @override
  Widget build(BuildContext context) {
    final currentSentence = sentences[currentSentenceIndex];
    final words = currentSentence['words'] as List<String>;
    print("aa");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        elevation: 0,
        title: Text(
          "Reading Book",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFe3f2fd),
              Color(0xFFbbdefb),
              Color(0xFF90caf9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildImageCard(),
                        SizedBox(height: 25),
                        _buildSentenceCard(words, currentSentence),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              // _buildSpeakingButton(),
              //  Spacer(),
              //  Imagespeak(english_word: speaktext, sucessfully_speak:completespeak ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6a00ff), Color(0xFF9d00ff)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Image Reading',
                  style: TextStyle(
                    color: Color(0xFF1a1a2e),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Speak the words aloud!',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFffd369), Color(0xFFff9a3c)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFffd369).withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.white, size: 20),
                SizedBox(width: 6),
                Text(
                  '$score',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard() {
    return ScaleTransition(
      scale: _imageAnimation,
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFc8e6c9),
              Color(0xFFa5d6a7),
            ],
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Image.network('https://vwpuplztcmyhtzlzbylf.supabase.co/storage/v1/object/public/practice/tttt.webp',
        fit: BoxFit.cover,)
   
      ),
    );
  }

  Widget _buildSentenceCard(List<String> words, Map<String, dynamic> sentence) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.all(30),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(25),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.08),
      //       blurRadius: 20,
      //       offset: Offset(0, 10),
      //     ),
      //   ],
      // ),
      child: Column(
        children: [
          // English text with word highlighting
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: List.generate(words.length, (index) {
              final isSpoken = spokenWordIndices.contains(index);
              return ScaleTransition(
                scale: isSpoken ? _wordAnimation : AlwaysStoppedAnimation(1.0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),

                  child: Text(
                    words[index],
                    style: TextStyle(
                      color: isSpoken ?  Colors.greenAccent : Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              );
            }),
          ),

          // Toggle translation button
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                showTranslation = !showTranslation;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  showTranslation ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xFF6a00ff),
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  showTranslation ? 'Hide Translation' : 'Show Translation',
                  style: TextStyle(
                    color: Color(0xFF6a00ff),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Hindi translation
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: showTranslation ? null : 0,
            child: showTranslation
                ? Column(
              children: [
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFffd369).withOpacity(0.2),
                        Color(0xFFff9a3c).withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Color(0xFFffd369),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.translate,
                        color: Color(0xFFff9a3c),
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          sentence['hindi'],
                          style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeakingButton() {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isListening)
            Text(
              'Tap to start speaking',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          if (isListening)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFFff6b6b).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color(0xFFff6b6b),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Listening...',
                    style: TextStyle(
                      color: Color(0xFFff6b6b),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 15),
          ScaleTransition(
            scale: _micAnimation,
            child: GestureDetector(
              onTap: _toggleListening,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isListening
                        ? [Color(0xFFff6b6b), Color(0xFFee5a6f)]
                        : [Color(0xFF4CAF50), Color(0xFF45a049)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (isListening
                          ? Color(0xFFff6b6b)
                          : Color(0xFF4CAF50))
                          .withOpacity(0.5),
                      blurRadius: 25,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  isListening ? Icons.stop : Icons.mic,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}