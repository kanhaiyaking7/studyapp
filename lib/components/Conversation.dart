

import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  final Function onNext;
  const Conversation({Key? key,required this.onNext}) : super(key: key);

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Orange progress bar
          Container(
            width: double.infinity,
            height: 4,
            color: Colors.grey[800],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(2)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Chat messages
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildMessage(
                    text: "¡Hola!",
                    subtitle: "Hi!",
                    isUser: true,
                    avatar: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  _buildMessage(
                    text: "¡Buenos días!",
                    subtitle: "Good morning!",
                    isUser: false,
                    avatar: Icons.account_circle,
                  ),
                  const SizedBox(height: 20),
                  _buildMessage(
                    text: "¿Qué tal?",
                    subtitle: "What's up?",
                    isUser: true,
                    avatar: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  _buildMessage(
                    text: "¡Bien, gracias! ¿Y tú?",
                    subtitle: "Good, thanks! And you?",
                    isUser: false,
                    avatar: Icons.account_circle,
                  ),
                  const SizedBox(height: 20),
                  _buildMessage(
                    text: "¡Muy bien!",
                    subtitle: "",
                    isUser: true,
                    avatar: Icons.person,
                  ),
                  const SizedBox(height: 100), // Space for footer
                ],
              ),
            ),
          ),

          // Footer with response buttons and mic
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black,
            child: Column(
              children: [
                // Response buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildResponseButton("Bien"),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildResponseButton("¡Adiós"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Microphone section
                Row(
                  children: [
                    // Empty box for mic answer
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[700]!),
                        ),
                        child: Center(
                          child: Text(
                            _isRecording ? "Recording..." : "Tap mic to speak",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Microphone button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRecording = !_isRecording;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _isRecording ? Colors.red : Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: (_isRecording ? Colors.red : Colors.blue).withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          _isRecording ? Icons.stop : Icons.mic,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),

                // Bottom indicator
                const SizedBox(height: 16),
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage({
    required String text,
    required String subtitle,
    required bool isUser,
    required IconData avatar,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (isUser) ...[
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.orange,
            child: Icon(avatar, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
        ],
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (!isUser) ...[
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.purple,
            child: Icon(avatar, color: Colors.white, size: 20),
          ),
        ],
      ],
    );
  }

  Widget _buildResponseButton(String text) {
    return GestureDetector(
      onTap: () {
        // Handle response button tap
        print("Response: $text");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[700]!),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}