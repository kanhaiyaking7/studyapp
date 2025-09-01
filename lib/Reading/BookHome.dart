
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/Providers/ReadingBook_provider/Bookdata_provider.dart';
import 'package:hi/Reading/ChapterCompletion.dart';
import 'package:hi/Reading/Reading.dart';

class Chapter {
  final String title;
  final int number;



  Chapter({
    required this.title,
    required this.number,

  });
}

class BookHome extends ConsumerStatefulWidget {
  final  book;
  const BookHome({Key? key ,required this.book}) : super(key: key);

  @override
  ConsumerState<BookHome> createState() => _BookHomeState();
}

class _BookHomeState extends ConsumerState<BookHome> {
  int chapter_completed = 1;
  String bookTitle = "The Giant Kingdom";
  String bookDescription = "Embark on an enchanting journey through the mystical Giant Kingdom, where courage meets magic and friendship conquers all. This captivating tale follows young heroes as they navigate through ancient forests, towering castles, and face legendary giants in their quest to save their homeland. Perfect for children who love adventure and fantasy stories filled with wonder and excitement.";
  IconData bookIcon = Icons.castle;

  List<Chapter> chapters = [
    Chapter(title: "The Beginning of Adventure", number: 1),
    Chapter(title: "Meeting the Giants", number: 2),
    Chapter(title: "The Enchanted Forest", number: 3),
    Chapter(title: "Castle in the Clouds", number: 4),
    Chapter(title: "The Magic Crystal", number: 5),
    Chapter(title: "Friendship and Courage", number: 6),
    Chapter(title: "The Dark Valley", number: 7),
    Chapter(title: "Battle of the Kingdoms", number: 8),
    Chapter(title: "The Final Challenge", number: 9),
    Chapter(title: "Victory and Peace", number: 10),
    Chapter(title: "Return Home", number: 11),
    Chapter(title: "Epilogue: New Beginnings", number: 12),
  ];

  // int get completedChapters => chapters.where((chapter) => chapter.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    final bookdata = ref.watch(BookData);
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
      body:
      SingleChildScrollView(
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
                  Image.network(
                    widget.book.coverUrl,
                    width: 180,
                    height: 240,
                    fit: BoxFit.fill,
                  ),
                  // Hero(
                  //   tag: 'book_cover',
                  //   child: Container(
                  //     width: 180,
                  //     height: 240,
                  //     decoration: BoxDecoration(
                  //       color: const Color(0xFF2A2A2A),
                  //       borderRadius: BorderRadius.circular(16),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.5),
                  //           blurRadius: 20,
                  //           offset: const Offset(0, 10),
                  //         ),
                  //       ],
                  //       border: Border.all(
                  //         color: Colors.orange.withOpacity(0.3),
                  //         width: 2,
                  //       ),
                  //     ),
                  //     child: Icon(
                  //       bookIcon,
                  //       color: Colors.orange,
                  //       size: 80,
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 20),

                  // Book title
                  Text(
                    widget.book.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  // Progress indicator
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   decoration: BoxDecoration(
                  //     color: Colors.orange.withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(20),
                  //     border: Border.all(color: Colors.orange, width: 1),
                  //   ),
                  //   child: Text(
                  //     '$chapter_completed/${chapters.length} Chapters Complete',
                  //     style: const TextStyle(
                  //       color: Colors.orange,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
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
                    widget.book.description,
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
              child:   bookdata.when(
                  data: (heading){
                    // print("PPPPPPP");
                    // print(heading[0].content[0].englishText);
                    // print(heading[0].content[0].hindiText);
                    return  Container(
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
                                  widthFactor: chapter_completed / heading.length,
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
                            itemCount: heading.length,
                            itemBuilder: (context, index) {
                              return _buildChapterTile(heading[index]);
                            },
                          ),
                        ],
                      ),
                    );

                  },
                  error: (e,stack)=>Text('error$e'),
                  loading: ()=>CircularProgressIndicator()
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
            int nextChapter = chapter_completed+ 1;
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

              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Reading()));
            },
            child: Text(
              chapter_completed < chapters.length ? 'Continue Reading' : 'Read Again',
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

  Widget _buildChapterTile( chapter) {


    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:
            (context)=>Reading(content:chapter.content, cover:widget.book)));

        // Navigator.push(context, MaterialPageRoute(builder:
        //     (context)=>ChapterCompletionScreen()));




      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:  chapter.orderNo <= chapter_completed
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
                color: chapter.orderNo <= chapter_completed
                    ? Colors.orange
                    : Colors.grey[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  chapter.orderNo.toString(),
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
                    'Chapter ${chapter.orderNo}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chapter.title,
                    style: TextStyle(
                      color:chapter.orderNo <= chapter_completed? Colors.white : Colors.grey[500],
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
                color:chapter.orderNo <= chapter_completed
                    ? Colors.green
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color:chapter.orderNo <= chapter_completed
                      ? Colors.green
                      : Colors.grey[600]!,
                ),
              ),
              child:chapter.orderNo <= chapter_completed
                  ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
              )
                  : null,
            ),
          ],
        ),
      ) ,
    );

  }
}