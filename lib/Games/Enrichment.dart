
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Enrichment extends StatefulWidget {
  const Enrichment({Key? key}) : super(key: key);

  @override
  _EnrichmentState createState() => _EnrichmentState();
}

class _EnrichmentState extends State<Enrichment> with TickerProviderStateMixin {
  // Navigation
  int selectedIndex = 0;

  // Daily Word Challenge
  Map<String, dynamic> dailyWord = {
    'word': 'Serendipity',
    'pronunciation': '/ˌserənˈdipədē/',
    'meaning': 'The occurrence of events by chance in a happy or beneficial way',
    'example': 'Meeting my best friend at the coffee shop was pure serendipity.',
    'challenge': 'Create a sentence using this word about an unexpected discovery',
    'streak': 7,
    'completed': false
  };

  TextEditingController sentenceController = TextEditingController();
  bool isRecording = false;
  bool wordChallengeCompleted = false;

  // Audio Book Shadowing
  List<Map<String, dynamic>> audioBooks = [
    {
      'title': 'The Little Prince',
      'author': 'Antoine de Saint-Exupéry',
      'duration': '3:45',
      'currentProgress': 0.3,
      'shadowingScore': 85,
      'chapter': 'Chapter 1: The Drawing',
      'text': 'Once when I was six years old I saw a magnificent picture in a book...',
      'isPlaying': false
    },
    {
      'title': 'A Christmas Carol',
      'author': 'Charles Dickens',
      'duration': '4:20',
      'currentProgress': 0.6,
      'shadowingScore': 92,
      'chapter': 'Stave 1: Marley\'s Ghost',
      'text': 'Marley was dead, to begin with. There is no doubt whatever about that...',
      'isPlaying': false
    }
  ];

  int selectedBookIndex = 0;
  bool isPlayingAudio = false;
  bool isShadowing = false;
  double shadowingScore = 0.0;
  Timer? audioTimer;

  // Mini Podcast
  List<Map<String, dynamic>> podcasts = [
    {
      'title': 'The Science of Happiness',
      'duration': '2:30',
      'description': 'Exploring what makes us truly happy',
      'currentProgress': 0.0,
      'subtitles': [
        {
          'time': '00:00',
          'text': 'Welcome to today\'s mini podcast about happiness.'
        },
        {
          'time': '00:05',
          'text': 'Scientists have discovered that happiness isn\'t just about pleasure.'
        },
        {
          'time': '00:12',
          'text': 'It\'s about finding meaning and connection in our daily lives.'
        },
        {
          'time': '00:18',
          'text': 'Research shows that gratitude practices can increase well-being.'
        },
        {
          'time': '00:25',
          'text': 'Even small acts of kindness create lasting positive emotions.'
        }
      ],
      'quiz': [
        {
          'question': 'According to the podcast, happiness is primarily about:',
          'options': [
            'Pleasure only',
            'Meaning and connection',
            'Money and success',
            'Avoiding problems'
          ],
          'correct': 1
        },
        {
          'question': 'What practice can increase well-being according to research?',
          'options': ['Complaining', 'Gratitude', 'Isolation', 'Competition'],
          'correct': 1
        }
      ],
      'quizCompleted': false,
      'quizScore': 0
    },
    {
      'title': 'The Power of Sleep',
      'duration': '2:45',
      'description': 'Why sleep is crucial for learning',
      'currentProgress': 0.0,
      'subtitles': [
        {
          'time': '00:00',
          'text': 'Sleep is not just rest - it\'s when your brain consolidates memories.'
        },
        {
          'time': '00:07',
          'text': 'During deep sleep, your brain clears out toxins and waste.'
        },
        {
          'time': '00:14',
          'text': 'Students who get enough sleep perform better on tests.'
        },
        {
          'time': '00:21',
          'text': 'REM sleep is particularly important for creative thinking.'
        },
        {
          'time': '00:28',
          'text': 'A consistent sleep schedule helps regulate your body clock.'
        }
      ],
      'quiz': [
        {
          'question': 'What happens during deep sleep?',
          'options': [
            'Nothing important',
            'Brain clears toxins',
            'Muscles grow',
            'Dreams occur'
          ],
          'correct': 1
        },
        {
          'question': 'Which type of sleep is important for creativity?',
          'options': ['Light sleep', 'REM sleep', 'Deep sleep', 'Micro sleep'],
          'correct': 1
        }
      ],
      'quizCompleted': false,
      'quizScore': 0
    }
  ];

  int selectedPodcastIndex = 0;
  bool isPodcastPlaying = false;
  int currentSubtitleIndex = 0;
  Timer? podcastTimer;
  bool showQuiz = false;
  int selectedQuizAnswer = -1;
  int currentQuizQuestion = 0;

  // Animation Controllers
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    audioTimer?.cancel();
    podcastTimer?.cancel();
    sentenceController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // Daily Word Challenge Methods
  void submitSentence() {
    if (sentenceController.text.toLowerCase().contains(
        dailyWord['word'].toLowerCase())) {
      setState(() {
        wordChallengeCompleted = true;
        dailyWord['completed'] = true;
        dailyWord['streak'] = dailyWord['streak'] + 1;
      });
      _pulseController.forward().then((_) => _pulseController.reverse());
      _showSuccessDialog('Great sentence! Keep up the streak!');
    } else {
      _showErrorDialog(
          'Please use the word "${dailyWord['word']}" in your sentence.');
    }
  }

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      // Simulate recording for 3 seconds
      Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            isRecording = false;
            wordChallengeCompleted = true;
            dailyWord['completed'] = true;
          });
          _showSuccessDialog('Recording saved! Great pronunciation!');
        }
      });
    }
  }

  // Audio Book Shadowing Methods
  void toggleAudioBook() {
    setState(() {
      isPlayingAudio = !isPlayingAudio;
      audioBooks[selectedBookIndex]['isPlaying'] = isPlayingAudio;
    });

    if (isPlayingAudio) {
      startAudioProgress();
    } else {
      audioTimer?.cancel();
    }
  }

  void startAudioProgress() {
    audioTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        audioBooks[selectedBookIndex]['currentProgress'] += 0.01;
        if (audioBooks[selectedBookIndex]['currentProgress'] >= 1.0) {
          audioBooks[selectedBookIndex]['currentProgress'] = 0.0;
          isPlayingAudio = false;
          audioBooks[selectedBookIndex]['isPlaying'] = false;
          timer.cancel();
        }
      });
    });
  }

  void startShadowing() {
    setState(() {
      isShadowing = true;
      shadowingScore = 0.0;
    });

    // Simulate shadowing score progression
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (isShadowing && shadowingScore < 100) {
        setState(() {
          shadowingScore += Random().nextDouble() * 5;
          if (shadowingScore > 100) shadowingScore = 100;
        });
      } else {
        timer.cancel();
        if (isShadowing) {
          setState(() {
            isShadowing = false;
            audioBooks[selectedBookIndex]['shadowingScore'] =
                shadowingScore.round();
          });
          _showSuccessDialog(
              'Shadowing complete! Score: ${shadowingScore.round()}%');
        }
      }
    });
  }

  // Mini Podcast Methods
  void togglePodcast() {
    setState(() {
      isPodcastPlaying = !isPodcastPlaying;
    });

    if (isPodcastPlaying) {
      startPodcastProgress();
    } else {
      podcastTimer?.cancel();
    }
  }

  void startPodcastProgress() {
    podcastTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        currentSubtitleIndex++;
        podcasts[selectedPodcastIndex]['currentProgress'] += 0.2;

        if (currentSubtitleIndex >=
            podcasts[selectedPodcastIndex]['subtitles'].length) {
          isPodcastPlaying = false;
          showQuiz = true;
          currentSubtitleIndex = 0;
          timer.cancel();
        }
      });
    });
  }

  void submitQuizAnswer() {
    final isCorrect = selectedQuizAnswer ==
        podcasts[selectedPodcastIndex]['quiz'][currentQuizQuestion]['correct'];

    if (isCorrect) {
      podcasts[selectedPodcastIndex]['quizScore']++;
    }

    setState(() {
      currentQuizQuestion++;
      selectedQuizAnswer = -1;
    });

    if (currentQuizQuestion >= podcasts[selectedPodcastIndex]['quiz'].length) {
      setState(() {
        showQuiz = false;
        currentQuizQuestion = 0;
        podcasts[selectedPodcastIndex]['quizCompleted'] = true;
      });
      _showSuccessDialog(
          'Quiz completed! Score: ${podcasts[selectedPodcastIndex]['quizScore']}/${podcasts[selectedPodcastIndex]['quiz']
              .length}');
    }
  }

  // Dialog Methods
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            backgroundColor: const Color(0xFF2D2D2D),
            title: const Text(
                'Success!', style: TextStyle(color: Colors.green)),
            content: Text(message, style: const TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            backgroundColor: const Color(0xFF2D2D2D),
            title: const Text('Oops!', style: TextStyle(color: Colors.red)),
            content: Text(message, style: const TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
    );
  }

  // UI Builders
  Widget buildDailyWordChallenge() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Word of the Day Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3D5AFE), Color(0xFF1E88E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Word of the Day',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + (_pulseController.value * 0.1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '🔥 ${dailyWord['streak']} day streak',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  dailyWord['word'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dailyWord['pronunciation'],
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  dailyWord['meaning'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '💡 ${dailyWord['example']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Challenge Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today\'s Challenge',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  dailyWord['challenge'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),

                // Text Input Challenge
                TextField(
                  controller: sentenceController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Write your sentence here...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[700]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: wordChallengeCompleted
                            ? null
                            : submitSentence,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: wordChallengeCompleted
                              ? Colors.green
                              : Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          wordChallengeCompleted
                              ? 'Completed ✅'
                              : 'Submit Sentence',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: toggleRecording,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isRecording ? Colors.red : Colors
                            .purple,
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Icon(
                        isRecording ? Icons.stop : Icons.mic,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                if (isRecording) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.fiber_manual_record, color: Colors.red,
                          size: 16),
                      const SizedBox(width: 8),
                      const Text(
                          'Recording...', style: TextStyle(color: Colors.red)),
                      const Spacer(),
                      Container(
                        width: 20,
                        height: 20,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAudioBookShadowing() {
    final currentBook = audioBooks[selectedBookIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Selection
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: audioBooks.length,
              itemBuilder: (context, index) {
                final book = audioBooks[index];
                final isSelected = index == selectedBookIndex;

                return GestureDetector(
                  onTap: () => setState(() => selectedBookIndex = index),
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[900] : Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected ? Border.all(
                          color: Colors.blue, width: 2) : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          book['author'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              book['duration'],
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Score: ${book['shadowingScore']}%',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // Current Book Player
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentBook['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentBook['chapter'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),

                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                            'Progress', style: TextStyle(color: Colors.grey)),
                        Text(
                          '${(currentBook['currentProgress'] * 100).toInt()}%',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: currentBook['currentProgress'],
                      backgroundColor: Colors.grey[800],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.blue),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Text Preview
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    currentBook['text'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Controls
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: toggleAudioBook,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Icon(
                          isPlayingAudio ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        label: Text(
                          isPlayingAudio ? 'Pause' : 'Play',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: isShadowing ? null : startShadowing,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isShadowing ? Colors.grey : Colors
                              .purple,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Icon(
                          isShadowing ? Icons.stop : Icons.record_voice_over,
                          color: Colors.white,
                        ),
                        label: Text(
                          isShadowing ? 'Shadowing...' : 'Shadow',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),

                if (isShadowing) ...[
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Shadowing Score', style: TextStyle(
                              color: Colors.grey)),
                          Text(
                            '${shadowingScore.toInt()}%',
                            style: const TextStyle(color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: shadowingScore / 100,
                        backgroundColor: Colors.grey[800],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.purple),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMiniPodcast() {
    final currentPodcast = podcasts[selectedPodcastIndex];

    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Podcast Selection
          Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: podcasts.length,
            itemBuilder: (context, index) {
              final podcast = podcasts[index];
              final isSelected = index == selectedPodcastIndex;

              return GestureDetector(
                onTap: () => setState(() => selectedPodcastIndex = index),
                child: Container(
                  width: 250,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green[900] : Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected ? Border.all(
                        color: Colors.green, width: 2) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        podcast['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        podcast['description'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            podcast['duration'],
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                          if (podcast['quizCompleted'])
                            Text(
                              'Quiz: ${podcast['quizScore']}/${podcast['quiz']
                                  .length}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
        ]
    )
        );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}