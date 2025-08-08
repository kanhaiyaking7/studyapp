import 'package:flutter/material.dart';

class Choice extends StatelessWidget {
  final VoidCallback onNext;

  Choice({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0), // Light grey background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            // Top Section with Question and Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onNext,
                  child: const Text(
                    "Q5 Question",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                Row(
                  children: [
                    const Text(
                      "3", // Current Question Number
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      " of 7", // Total Questions
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Robot Image Placeholder
            Center(
              child: SizedBox(
                width: 200, // Adjust size as needed
                height: 150, // Adjust size as needed
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Placeholder
                    //  Add image here
                  ),
                  child: const Center(child: Text("Robot Image", style: TextStyle(fontSize: 12, color: Colors.grey))),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Question Text
            const Text(
              "The book is on the table",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Text(
              "किताब मेज पर है।", // Translated Text
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Choose your answer
            const Text(
              "Choose your answer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            // Answer Options
            _buildAnswerOption(text: "A. 5 apples"),
            _buildAnswerOption(text: "B. 6 apples"),
            _buildAnswerOption(text: "C. 7 apples"),
            _buildAnswerOption(text: "D. 8 apples"),

            const SizedBox(height: 20),
            // Previous and Next Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400], // Light gray
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Answer Options
  Widget _buildAnswerOption({required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
