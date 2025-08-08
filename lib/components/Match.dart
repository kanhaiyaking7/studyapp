import 'package:flutter/material.dart';

class Matcha extends StatefulWidget {


  final VoidCallback onNext;

  Matcha({required this.onNext});

  @override
  _MatchaState createState() => _MatchaState();
}

class _MatchaState extends State<Matcha> {
  // Selected cards tracking
  Set<int> selectedIndices = {};

  // Map of matched pairs (example pairs based on the image)
  final Map<String, String> matchPairs = {
    'including': 'incluyendo',
    'to dance': 'ballare',
    'cinema': 'cinema',
    'video': 'video',
    'line': 'fila',
  };

  // List of all cards to display
  late List<Map<String, dynamic>> cards;

  @override
  void initState() {
    super.initState();
    _initializeCards();
  }

  void _initializeCards() {
    // Create cards from matchPairs
    cards = [];
    matchPairs.forEach((key, value) {
      cards.add({'text': key, 'isSelected': false, 'isMatched': false});
      cards.add({'text': value, 'isSelected': false, 'isMatched': false});
    });

    // Shuffle cards
    cards.shuffle();
  }

  void _toggleCardSelection(int index) {
    setState(() { //wrap in set state
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
        cards[index]['isSelected'] = false;
      } else {
        // Only allow selecting two cards at a time
        if (selectedIndices.length < 2) {
          selectedIndices.add(index);
          cards[index]['isSelected'] = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E6EE9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top bar with back button and progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: [
                  // Back button
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.close,
                      color: Colors.black54,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Progress bar
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        // Background track
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        // Progress indicator
                        Container(
                          height: 10,
                          width: MediaQuery.of(context).size.width * 0.3, // 30% progress
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Progress counter
                  const Text(
                    '3/10',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            // Instruction text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                'Tap the matching pairs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            // Cards grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.0,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    final bool isSelected = card['isSelected'];
                    // Determine if this card is a match (based on image, some pairs are highlighted)
                    final bool isHighlighted =
                    (card['text'] == 'to dance' || card['text'] == 'ballare');

                    return GestureDetector(
                      onTap: () => _toggleCardSelection(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isHighlighted ? const Color(0xFFD2F5C8) : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: isSelected
                              ? Border.all(color: Colors.blue, width: 2)
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          card['text'].toString(),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Check button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF999999),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Check',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            // Home indicator
            Center(
              child: Container(
                width: 150,
                height: 5,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}









