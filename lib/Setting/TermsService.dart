import 'package:flutter/material.dart';

class TermsService extends StatefulWidget {
  const TermsService({Key? key}) : super(key: key);

  @override
  State<TermsService> createState() => _TermsServiceState();
}

class _TermsServiceState extends State<TermsService> {
  double scrollOffset = 0.0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void handleGoBack() {
    Navigator.of(context).pop();
  }

  void handleAgree() {
    print('User agreed to terms');
    Navigator.of(context).pop();
  }

  void handleDecline() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final headerOpacity = (scrollOffset / 50).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    width: screenWidth,
                    color: const Color(0xFF111111),
                    padding: const EdgeInsets.only(
                      top: 100,
                      left: 20,
                      right: 20,
                      bottom: 40,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Center(
                            child: Text(
                              '📋',
                              style: TextStyle(fontSize: 32),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Please review our terms of service before using the application',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF999999),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Effective Date: June 26, 2025',
                            style: TextStyle(
                              color: Color(0xFF66D9EF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content Sections
                  Container(
                    width: screenWidth,
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 120,
                    ),
                    child: Column(
                      children: [
                        _buildSection(
                          '01',
                          'Agreement to Terms',
                          [
                            'Welcome to our application. By accessing or using our mobile app, you agree to comply with and be bound by these Terms and Conditions. This agreement is effective immediately upon your first use of the application.',
                            'If you disagree with any part of these terms, you should discontinue use of our application immediately. We may update these terms periodically, and continued use constitutes acceptance of any modifications.',
                          ],
                        ),
                        _buildSection(
                          '02',
                          'User Registration & Account',
                          [
                            'To access premium features, you may need to create a user account. You are responsible for maintaining the security of your account credentials and all activities that occur under your account.',
                            'Users must be at least 13 years of age to register. Minors under 18 require parental consent to use our services. You agree to provide accurate information during registration and keep it updated.',
                          ],
                        ),
                        _buildSection(
                          '03',
                          'Application Usage',
                          [
                            'Our application is provided for personal, non-commercial use. You may not use the app for any illegal purposes or in violation of local, state, national, or international laws and regulations.',
                            'You agree not to interfere with or disrupt the app\'s functionality, servers, or networks. Any attempt to gain unauthorized access to our systems may result in immediate account termination and legal action.',
                          ],
                        ),
                        _buildSection(
                          '04',
                          'Privacy & Data Collection',
                          [
                            'We collect and process your personal data in accordance with our Privacy Policy. This includes information you provide during registration, usage analytics, and device information necessary for app functionality.',
                            'We implement industry-standard security measures to protect your data. However, no method of electronic transmission is 100% secure, and we cannot guarantee absolute data security.',
                          ],
                        ),
                        _buildSection(
                          '05',
                          'User Content & Conduct',
                          [
                            'You retain ownership of content you create or upload through our app. However, you grant us a license to use, modify, and display your content as necessary to provide our services.',
                            'You agree not to post or transmit content that is illegal, harmful, threatening, abusive, defamatory, obscene, or otherwise objectionable. We reserve the right to remove such content without notice.',
                          ],
                        ),
                        _buildSection(
                          '06',
                          'Intellectual Property Rights',
                          [
                            'All app content, including but not limited to text, graphics, logos, images, software, and design elements, are owned by us or our licensors and protected by copyright, trademark, and other intellectual property laws.',
                            'You may not reproduce, distribute, modify, or create derivative works from any part of our application without explicit written permission from our legal team.',
                          ],
                        ),
                        _buildSection(
                          '07',
                          'Disclaimers & Limitations',
                          [
                            'Our application is provided "as is" without warranties of any kind. We disclaim all warranties, express or implied, including merchantability, fitness for a particular purpose, and non-infringement.',
                            'We shall not be liable for any indirect, incidental, special, or consequential damages arising from your use of the application, even if we have been advised of the possibility of such damages.',
                          ],
                        ),
                        _buildSection(
                          '08',
                          'Account Termination',
                          [
                            'We may suspend or terminate your account at any time for violations of these terms or for any other reason at our sole discretion. You may also delete your account at any time through the app settings.',
                            'Upon termination, you must cease all use of the application and delete it from your devices. Certain provisions of these terms will survive termination, including intellectual property rights and limitation of liability clauses.',
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Dynamic Header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: screenWidth,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A).withOpacity(headerOpacity),
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFF333333).withOpacity(headerOpacity),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: handleGoBack,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            '✕',
                            style: TextStyle(
                              color: Color(0xFFFF6B6B),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Terms of Service',
                      style: TextStyle(
                        color: Colors.white.withOpacity(headerOpacity),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     width: screenWidth,
            //     padding: const EdgeInsets.all(20),
            //     decoration: const BoxDecoration(
            //       color: Color(0xFF1A1A1A),
            //       border: Border(
            //         top: BorderSide(
            //           color: Color(0xFF333333),
            //           width: 1,
            //         ),
            //       ),
            //     ),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         SizedBox(
            //           width: double.infinity,
            //           child: ElevatedButton(
            //             onPressed: handleAgree,
            //             style: ElevatedButton.styleFrom(
            //               backgroundColor: const Color(0xFF66D9EF),
            //               padding: const EdgeInsets.symmetric(vertical: 16),
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(12),
            //               ),
            //               elevation: 8,
            //               shadowColor: const Color(0xFF66D9EF),
            //             ),
            //             child: const Text(
            //               'Accept Terms',
            //               style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //         ),
            //         const SizedBox(height: 12),
            //         // SizedBox(
            //         //   width: double.infinity,
            //         //   child: OutlinedButton(
            //         //     onPressed: handleDecline,
            //         //     style: OutlinedButton.styleFrom(
            //         //       padding: const EdgeInsets.symmetric(vertical: 16),
            //         //       shape: RoundedRectangleBorder(
            //         //         borderRadius: BorderRadius.circular(12),
            //         //       ),
            //         //       side: const BorderSide(
            //         //         color: Color(0xFFFF6B6B),
            //         //         width: 1,
            //         //       ),
            //         //     ),
            //         //     child: const Text(
            //         //       'Decline',
            //         //       style: TextStyle(
            //         //         color: Color(0xFFFF6B6B),
            //         //         fontSize: 16,
            //         //         fontWeight: FontWeight.w600,
            //         //       ),
            //         //     ),
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String number, String title, List<String> paragraphs) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(
            color: Color(0xFF66D9EF),
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF66D9EF),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          ...paragraphs.map((paragraph) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              paragraph,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFFCCCCCC),
                height: 1.6,
              ),
              textAlign: TextAlign.justify,
            ),
          )),
        ],
      ),
    );
  }
}