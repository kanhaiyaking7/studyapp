
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Could not launch $url')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          'About Us',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Company Logo/Avatar
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: CircleAvatar(
                    radius: isMobile ? 50 : 70,
                    backgroundColor: theme.colorScheme.primary,
                    child: Icon(
                      Icons.business,
                      size: isMobile ? 50 : 70,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),

                // Company Name
                Text(
                  'TechCorp Solutions',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Tagline
                Text(
                  'Building Tomorrow\'s Technology Today',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // About Description
                Card(
                  elevation: 4,
                  color: theme.colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 40,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Our Story',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'We are a passionate team of developers and designers dedicated to creating innovative mobile and web applications. With over 5 years of experience in the industry, we\'ve helped hundreds of clients bring their digital dreams to life.',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Contact Info
                Card(
                  elevation: 4,
                  color: theme.colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.contact_mail,
                          size: 40,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Contact Information',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildContactRow(Icons.email, 'info@techcorp.com', theme),
                        _buildContactRow(Icons.phone, '+1 (555) 123-4567', theme),
                        _buildContactRow(Icons.web, 'www.techcorp.com', theme),
                        _buildContactRow(Icons.location_on, 'San Francisco, CA', theme),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Social Media Section
                Text(
                  'Connect With Us',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // Social Media Icons
                Wrap(
                  spacing: isMobile ? 16 : 24,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildSocialButton(
                      icon: Icons.language,
                      label: 'Website',
                      url: 'https://www.techcorp.com',
                      color: Colors.blue,
                      theme: theme,
                    ),
                    _buildSocialButton(
                      icon: Icons.work_outline,
                      label: 'LinkedIn',
                      url: 'https://www.linkedin.com/company/techcorp',
                      color: const Color(0xFF0077B5),
                      theme: theme,
                    ),
                    _buildSocialButton(
                      icon: Icons.camera_alt,
                      label: 'Instagram',
                      url: 'https://www.instagram.com/techcorp',
                      color: const Color(0xFFE4405F),
                      theme: theme,
                    ),
                    _buildSocialButton(
                      icon: Icons.facebook,
                      label: 'Facebook',
                      url: 'https://www.facebook.com/techcorp',
                      color: const Color(0xFF1877F2),
                      theme: theme,
                    ),
                    _buildSocialButton(
                      icon: Icons.alternate_email,
                      label: 'Twitter',
                      url: 'https://www.twitter.com/techcorp',
                      color: const Color(0xFF1DA1F2),
                      theme: theme,
                    ),
                    _buildSocialButton(
                      icon: Icons.video_library,
                      label: 'YouTube',
                      url: 'https://www.youtube.com/c/techcorp',
                      color: const Color(0xFFFF0000),
                      theme: theme,
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Footer
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '© 2024 TechCorp Solutions. All rights reserved.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required String url,
    required Color color,
    required ThemeData theme,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}