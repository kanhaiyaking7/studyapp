

import 'package:flutter/material.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  String feedbackType = '';
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isSubmitting = false;

  final List<Map<String, dynamic>> feedbackTypes = [
    {'id': 'bug', 'label': '🐛 Bug Report', 'color': const Color(0xFFFF6B6B)},
    {'id': 'feature', 'label': '💡 Feature Request', 'color': const Color(0xFF4ECDC4)},
    {'id': 'improvement', 'label': '⚡ Improvement', 'color': const Color(0xFF45B7D1)},
    {'id': 'compliment', 'label': '👍 Compliment', 'color': const Color(0xFF96CEB4)},
    {'id': 'other', 'label': '💬 Other', 'color': const Color(0xFFF39C12)},
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void handleGoBack() {
    Navigator.of(context).pop();
  }

  Future<void> handleSubmit() async {
    // Validation
    if (feedbackType.isEmpty) {
      _showAlert('Error', 'Please select a feedback type');
      return;
    }
    if (_subjectController.text.trim().isEmpty) {
      _showAlert('Error', 'Please enter a subject');
      return;
    }
    if (_messageController.text.trim().isEmpty) {
      _showAlert('Error', 'Please enter your feedback message');
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Handle successful submission
      if (mounted) {
        _showSuccessAlert();
      }
    } catch (error) {
      if (mounted) {
        _showAlert('Error', 'Failed to send feedback. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Color(0xFFCCCCCC)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK', style: TextStyle(color: Color(0xFF66D9EF))),
          ),
        ],
      ),
    );
  }

  void _showSuccessAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'Feedback Sent!',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Thank you for your feedback. We\'ll review it and get back to you soon.',
          style: TextStyle(color: Color(0xFFCCCCCC)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Reset form
              setState(() {
                feedbackType = '';
                _subjectController.clear();
                _messageController.clear();
                _emailController.clear();
              });
              Navigator.of(context).pop();
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF66D9EF))),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic>? getSelectedType() {
    return feedbackTypes.where((type) => type['id'] == feedbackType).isNotEmpty
        ? feedbackTypes.firstWhere((type) => type['id'] == feedbackType)
        : null;
  }

  bool get isFormValid {
    return feedbackType.isNotEmpty &&
        _subjectController.text.trim().isNotEmpty &&
        _messageController.text.trim().isNotEmpty &&
        !isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A),
                border: Border(
                  bottom: BorderSide(color: Color(0xFF333333), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: handleGoBack,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '← Back',
                        style: TextStyle(
                          color: Color(0xFF66D9EF),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Send Feedback',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Intro Section
                    Container(
                      width: screenWidth,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2A2A2A),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: const Center(
                              child: Text('📝', style: TextStyle(fontSize: 28)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'We Value Your Feedback',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Help us improve by sharing your thoughts, reporting bugs, or suggesting new features.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF999999),
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Feedback Type Selection
                    const Text(
                      'What type of feedback is this?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: feedbackTypes.map((type) {
                        final isSelected = feedbackType == type['id'];
                        final typeColor = type['color'] as Color;

                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                feedbackType = type['id'];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? typeColor.withOpacity(0.2)
                                    : const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected ? typeColor : const Color(0xFF333333),
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                type['label'],
                                style: TextStyle(
                                  color: isSelected ? typeColor : const Color(0xFFCCCCCC),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 25),

                    // Subject Input
                    const Text(
                      'Subject',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _subjectController,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Brief description of your feedback',
                          hintStyle: const TextStyle(color: Color(0xFF666666)),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF333333)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF333333)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF66D9EF)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        maxLength: 100,
                        onChanged: (value) => setState(() {}),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_subjectController.text.length}/100',
                        style: const TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Message Input
                    const Text(
                      'Your Feedback',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _messageController,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Please provide detailed feedback. The more information you share, the better we can help you.',
                          hintStyle: const TextStyle(color: Color(0xFF666666)),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF333333)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF333333)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF66D9EF)),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        maxLines: 6,
                        maxLength: 1000,
                        textAlignVertical: TextAlignVertical.top,
                        onChanged: (value) => setState(() {}),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_messageController.text.length}/1000',
                        style: const TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Email Input
                    const Text(
                      'Email (Optional)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Leave your email if you\'d like us to follow up with you',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'your.email@example.com',
                          hintStyle: const TextStyle(color: Color(0xFF666666)),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF333333)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF333333)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF66D9EF)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                      ),
                    ),

                    const SizedBox(height: 35),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isFormValid ? handleSubmit : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFormValid
                              ? const Color(0xFF66D9EF)
                              : const Color(0xFF333333),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: isFormValid ? 8 : 0,
                          shadowColor: const Color(0xFF66D9EF),
                        ),
                        child: Text(
                          isSubmitting ? 'Sending...' : 'Send Feedback',
                          style: TextStyle(
                            color: isFormValid ? Colors.black : const Color(0xFF666666),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Info Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(12),
                        border: const Border(
                          left: BorderSide(color: Color(0xFF66D9EF), width: 4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '📌 Quick Tips',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF66D9EF),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '• Be specific about the issue or suggestion\n'
                                '• Include steps to reproduce bugs\n'
                                '• Tell us your device model for technical issues\n'
                                '• We typically respond within 24-48 hours',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFCCCCCC),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}