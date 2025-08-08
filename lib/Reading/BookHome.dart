
import 'package:flutter/material.dart';
import 'package:hi/Reading/Reading.dart';

class Chapter {
  final String title;
  final int number;
  final bool isCompleted;

  Chapter({
    required this.title,
    required this.number,
    required this.isCompleted,
  });
}

class BookHome extends StatefulWidget {
  const BookHome({Key? key}) : super(key: key);

  @override
  State<BookHome> createState() => _BookHomeState();
}

class _BookHomeState extends State<BookHome> {
  String bookTitle = "The Giant Kingdom";
  String bookDescription = "Embark on an enchanting journey through the mystical Giant Kingdom, where courage meets magic and friendship conquers all. This captivating tale follows young heroes as they navigate through ancient forests, towering castles, and face legendary giants in their quest to save their homeland. Perfect for children who love adventure and fantasy stories filled with wonder and excitement.";
  IconData bookIcon = Icons.castle;

  List<Chapter> chapters = [
    Chapter(title: "The Beginning of Adventure", number: 1, isCompleted: true),
    Chapter(title: "Meeting the Giants", number: 2, isCompleted: true),
    Chapter(title: "The Enchanted Forest", number: 3, isCompleted: true),
    Chapter(title: "Castle in the Clouds", number: 4, isCompleted: true),
    Chapter(title: "The Magic Crystal", number: 5, isCompleted: true),
    Chapter(title: "Friendship and Courage", number: 6, isCompleted: false),
    Chapter(title: "The Dark Valley", number: 7, isCompleted: false),
    Chapter(title: "Battle of the Kingdoms", number: 8, isCompleted: false),
    Chapter(title: "The Final Challenge", number: 9, isCompleted: false),
    Chapter(title: "Victory and Peace", number: 10, isCompleted: false),
    Chapter(title: "Return Home", number: 11, isCompleted: false),
    Chapter(title: "Epilogue: New Beginnings", number: 12, isCompleted: false),
  ];

  int get completedChapters => chapters.where((chapter) => chapter.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.orange),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Book bookmarked!'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sharing book...'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover and basic info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Book cover
                  Hero(
                    tag: 'book_cover',
                    child: Container(
                      width: 180,
                      height: 240,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        bookIcon,
                        color: Colors.orange,
                        size: 80,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Book title
                  Text(
                    bookTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  // Progress indicator
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange, width: 1),
                    ),
                    child: Text(
                      '$completedChapters/${chapters.length} Chapters Complete',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Description section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    bookDescription,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Chapters section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Chapters',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: completedChapters / chapters.length,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Chapter list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: chapters.length,
                    itemBuilder: (context, index) {
                      return _buildChapterTile(chapters[index]);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100), // Space for floating button
          ],
        ),
      ),

      // Floating Read Button
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: FloatingActionButton.extended(
          onPressed: () {
            int nextChapter = completedChapters + 1;
            if (nextChapter <= chapters.length) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening Chapter $nextChapter...'),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Book completed! Great job!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          backgroundColor: Colors.orange,
          icon: const Icon(Icons.menu_book, color: Colors.white),
          label:
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Reading()));
            },
            child: Text(
              completedChapters < chapters.length ? 'Continue Reading' : 'Read Again',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ) ,
          )

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildChapterTile(Chapter chapter) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: chapter.isCompleted
              ? Colors.orange.withOpacity(0.5)
              : Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          // Chapter number
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: chapter.isCompleted
                  ? Colors.orange
                  : Colors.grey[700],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                chapter.number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Chapter title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chapter ${chapter.number}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  chapter.title,
                  style: TextStyle(
                    color: chapter.isCompleted ? Colors.white : Colors.grey[500],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Completion status
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: chapter.isCompleted
                  ? Colors.green
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: chapter.isCompleted
                    ? Colors.green
                    : Colors.grey[600]!,
              ),
            ),
            child: chapter.isCompleted
                ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 18,
            )
                : null,
          ),
        ],
      ),
    );
  }
}