import 'package:flutter/material.dart';
import 'package:hi/Games/TranslationMatchButton.dart';

class TranslationMatchScreen extends StatefulWidget {
  const TranslationMatchScreen({Key? key}) : super(key: key);

  @override
  State<TranslationMatchScreen> createState() => _TranslationMatchScreenState();
}

class _TranslationMatchScreenState extends State<TranslationMatchScreen> {
  int currentQuestion = 1;
  int totalQuestions = 5;
  int score = 0;
  bool isGrammarHintExpanded = false;

  int currentIndex = 0;
  // Sample translation data
  List<Map<String, String>> translationData = [
    {
      'text': 'मुझे पानी चाहिए।',
      'translation': 'I need water.',
      'hint': 'Use "need" for necessity and "water" is uncountable noun.'
    },
    {
      'text': 'वह स्कूल जाता है।',
      'translation': 'He goes to school.',
      'hint': 'Present simple tense with third person singular.'
    },
    {
      'text': 'यह बहुत अच्छा है।',
      'translation': 'This is very good.',
      'hint': 'Demonstrative pronoun with adjective.'
    },
  ];

  // Question(

  // text: "मुझे पानी चाहिए।",
  // translation: "I need water.",
  // grammarHint: "Subject + need + Object",
  // difficulty: "Easy",
  // ),


  complete_speak(){
    setState(() {
      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Translation Match,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  score.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$currentQuestion/$totalQuestions',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Decorative top section
          Container(
            width: double.infinity,
            height: 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Main translation card
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Easy badge
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Easy',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),

                          // Score indicator
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.amber[600],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Instruction text
                          const Text(
                            'Translate to English:',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Text to translate
                          Text(
                            translationData[currentIndex]['text']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 30),

                          // Audio button
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF5C6BC0),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.volume_up,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                // Handle audio playback
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Audio playback'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),

                  // Grammar hint section
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3949AB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            isGrammarHintExpanded = !isGrammarHintExpanded;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.lightbulb,
                                color: Colors.amber,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'Grammar Hint',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                isGrammarHintExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Hint content (expandable)
                  if (isGrammarHintExpanded) ...[
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        translationData[0]['hint']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),

                  // Microphone button
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child:
                    TranslationButton(
                        messageList: translationData[currentIndex]['translation'],
                        complete_speak: complete_speak
                    ),


                    // IconButton(
                    //   icon: const Icon(
                    //     Icons.mic,
                    //     color: Colors.white,
                    //     size: 36,
                    //   ),
                    //   onPressed: () {
                    //     // Handle voice input
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text('Voice recording started'),
                    //         duration: Duration(seconds: 2),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Tap to speak',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}