import 'package:flutter/material.dart';
import 'package:hi/Reading/BookHome.dart';

const bookfront = 'assets/images/bookcover.jpg';

class Book {
  final String title;
  final String description;
  final double rating;
  final IconData icon;
  final String category;

  Book({
    required this.title,
    required this.description,
    required this.rating,
    required this.icon,
    required this.category,
  });
}

class BookStore extends StatefulWidget {
  const BookStore({Key? key}) : super(key: key);

  @override
  State<BookStore> createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  String selectedCategory = 'Child';

  final List<String> categories = ['Child', 'Humanities', 'Education', 'Science'];

  final List<Book> books = [
    Book(
      title: 'The Giant Kingdom',
      description: 'Explore fantasy reading - unwary fantastic literature',
      rating: 4.1,
      icon: Icons.castle,
      category: 'Child',
    ),
    Book(
      title: 'Bear\'s wish',
      description: 'Adventure reading - Only for children ages 3 to 6',
      rating: 4.6,
      icon: Icons.pets,
      category: 'Child',
    ),
    Book(
      title: 'Animal adventures',
      description: 'Adventure reading',
      rating: 4.4,
      icon: Icons.forest,
      category: 'Child',
    ),
    Book(
      title: 'Growing story',
      description: 'Adventure reading - Only for children ages 3 to 6',
      rating: 4.2,
      icon: Icons.eco,
      category: 'Child',
    ),
    Book(
      title: 'Philosophy 101',
      description: 'Introduction to philosophical thinking and reasoning',
      rating: 4.3,
      icon: Icons.psychology,
      category: 'Humanities',
    ),
    Book(
      title: 'Ancient History',
      description: 'Discover the mysteries of ancient civilizations',
      rating: 4.5,
      icon: Icons.museum,
      category: 'Humanities',
    ),
    Book(
      title: 'Learning Mathematics',
      description: 'Master the fundamentals of mathematical concepts',
      rating: 4.0,
      icon: Icons.calculate,
      category: 'Education',
    ),
    Book(
      title: 'Teaching Methods',
      description: 'Modern approaches to effective teaching',
      rating: 4.2,
      icon: Icons.school,
      category: 'Education',
    ),
    Book(
      title: 'Physics Fundamentals',
      description: 'Understanding the laws of nature and physics',
      rating: 4.4,
      icon: Icons.science,
      category: 'Science',
    ),
    Book(
      title: 'Chemistry Lab',
      description: 'Practical experiments and chemical reactions',
      rating: 4.1,
      icon: Icons.biotech,
      category: 'Science',
    ),
  ];

  List<Book> get filteredBooks {
    return books.where((book) => book.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: const Text(
          'BOOK LENDING',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Column(
        children: [
          // Category tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: categories.map((category) =>
                  _buildCategoryTab(category)
              ).toList(),
            ),
          ),

          // Book count indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              '${filteredBooks.length} books found in $selectedCategory',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
          ),

          // Book list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildBookCard(filteredBooks[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String category) {
    bool isSelected = category == selectedCategory;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.orange : Colors.grey,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildBookCard(Book book) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Book cover placeholder
          Hero(
            tag: 'book_${book.title}',
            child: Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Image.asset(bookfront,width: 80,height: 100, fit:BoxFit.fill),
              // Icon(
              //   book.icon,
              //   color: Colors.orange,
              //   size: 32,
              // ),
            ),
          ),

          const SizedBox(width: 16),

          // Book details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.description,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      book.rating.toString(),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BookHome()));


                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text('Borrowed "${book.title}"'),
                        //     backgroundColor: Colors.orange,
                        //     duration: const Duration(seconds: 2),
                        //   ),
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Read',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}