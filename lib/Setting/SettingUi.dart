

import 'package:flutter/material.dart';
import 'package:hi/Setting/AboutUs.dart';
import 'package:hi/Setting/HelpSupport.dart';
import 'package:hi/Setting/ProfileEdit.dart';
import 'package:hi/Setting/TermsService.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool notificationsEnabled = true;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              // _buildProfileSection(),
              // const SizedBox(height: 30),

              // Settings Options
              _buildSettingsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Profile Image Placeholder
          // Container(
          //   width: 60,
          //   height: 60,
          //   decoration: BoxDecoration(
          //     color: const Color(0xFF3A3A3C),
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: const Icon(
          //     Icons.person,
          //     color: Color(0xFF8E8E93),
          //     size: 32,
          //   ),
          // ),
          // const SizedBox(width: 16),

          // Profile Info
          // Expanded(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Alex Mitchell',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 20,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       const SizedBox(height: 4),
          //       const Text(
          //         'alex.mitchell@email.com',
          //         style: TextStyle(
          //           color: Color(0xFF8E8E93),
          //           fontSize: 16,
          //         ),
          //       ),
          //       const SizedBox(height: 8),
          //       Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //         decoration: BoxDecoration(
          //           color: const Color(0xFFFFCC02),
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         child: const Text(
          //           'Premium Member',
          //           style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 12,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // Edit Profile Button
          // IconButton(
          //   onPressed: () => _onProfileTap(),
          //   icon: const Icon(
          //     Icons.edit,
          //     color: Color(0xFF007AFF),
          //     size: 24,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      children: [
        // Account Settings
        _buildSettingsGroup('Account', [
          _buildSettingItem(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            subtitle: 'Manage your profile information',
            onTap: () => _onProfileTap(),
            showArrow: true,
          ),
          _buildSettingItem(
            icon: Icons.language,
            title: 'Language',
            subtitle: selectedLanguage,
            onTap: () => _showLanguageSelector(),
            showArrow: true,
          ),

        _buildSettingItem(
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          subtitle: 'Push notifications and alerts',
          onTap: () => _toggleNotifications(),
          trailing: Switch(
            value: notificationsEnabled,
            onChanged: (value) => _toggleNotifications(),
            activeColor: const Color(0xFF007AFF),
          ),
        ),

          _buildSettingItem(
            icon: Icons.credit_card_outlined,
            title: 'Manage Subscription',
            subtitle: 'Info Subscription',
            onTap: () => _onProfileTap(),
            showArrow: true,
          ),

          _buildSettingItem(
            icon: Icons.help_outline_outlined,
            title: 'Help & Support',
            subtitle: 'Get help and find answers',
            onTap: () => _onHelp(),
            showArrow: true,
          ),

          _buildSettingItem(
            icon: Icons.group_add_outlined,
            title: 'About Us',
            subtitle: 'Version 2.1.0',
            onTap: () => _onAboutUs(),
            showArrow: true,
          ),

          // _buildSettingItem(
          //   icon: Icons.privacy_tip_outlined,
          //   title: 'Privacy Policy',
          //   subtitle: 'Read our privacy policy',
          //   onTap: () => _onTerms(),
          //   showArrow: true,
          // ),

          _buildSettingItem(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            subtitle: 'Read terms and conditions',
            onTap: () => _onTerms(),
            showArrow: true,
          ),


        ]),

        const SizedBox(height: 24),



        const SizedBox(height: 24),

        // Logout
        _buildSettingItem(
          icon: Icons.logout,
          iconColor: const Color(0xFFFF3B30),
          title: 'Logout',
          titleColor: const Color(0xFFFF3B30),
          subtitle: 'Sign out of your account',
          onTap: () => _showLogoutDialog(),
          showArrow: false,
        ),
      ],
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          // decoration: BoxDecoration(
          //   color: const Color(0xFF2C2C2E),
          //   borderRadius: BorderRadius.circular(16),
          // ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              int index = entry.key;
              Widget item = entry.value;

              return Column(
                children: [
                  item,
                  if (index < items.length - 1)
                    const Divider(
                      color: Color(0xFF3A3A3C),
                      height: 1,
                      thickness: 0.5,
                      indent: 60,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
    Color? iconColor,
    Color? titleColor,
    Widget? trailing,
    bool showArrow = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            // Icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: (iconColor ?? const Color(0xFF007AFF)).withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor ?? const Color(0xFF007AFF),
                size: 25,
              ),
            ),
            const SizedBox(width: 16),

            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor ?? Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing



            // Trailing Widget

          ],
        ),
      ),
    );
  }

  // Action Methods
  void _onProfileTap() {
 Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileEdit()));
  }

  void _onTerms(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsService()));
  }
  void _onHelp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpSupport()));
  }

  void _onAboutUs(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
  }
  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Language',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            ...[
              'English',
              'Spanish',
              'French',
              'German',
              'Japanese',
            ].map((language) => ListTile(
              title: Text(
                language,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: selectedLanguage == language
                  ? const Icon(Icons.check, color: Color(0xFF007AFF))
                  : null,
              onTap: () {
                setState(() {
                  selectedLanguage = language;
                });
                Navigator.pop(context);
              },
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _onManageSubscriptionTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Manage subscription opened'),
        backgroundColor: Color(0xFF007AFF),
      ),
    );
  }

  void _toggleNotifications() {
    setState(() {
      notificationsEnabled = !notificationsEnabled;
    });
  }

  void _onHelpSupportTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Help & Support opened'),
        backgroundColor: Color(0xFF007AFF),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: const Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Color(0xFF8E8E93)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF007AFF)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Color(0xFFFF3B30),
                ),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Color(0xFFFF3B30)),
            ),
          ),
        ],
      ),
    );
  }
}