

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/features/auth/provider/User_provider.dart';

class ProfileEdit extends ConsumerStatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends ConsumerState<ProfileEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();

  bool _isLoading = false;
  String _selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    // Initialize with existing data
    final user = ref.read(UserDetails);
    _nameController.text = user.username;
    _ageController.text = user.age.toString();
    _emailController.text = user.email;
    _phoneController.text = user.phone_Number.toString();
    _bioController.text = user.bio;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _nameFocus.dispose();
    _ageFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _bioFocus.dispose();
    super.dispose();
  }

  void _onsubmit(){
    final complete_user = ref.read(UserDetails.notifier).complete_user_detils(
        _nameController.text, int.parse(_ageController.text), _emailController.text,
       int.parse( _phoneController.text), _bioController.text);
    _showSnackBar('Profile updated successfully!');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Photo Section
              _buildProfilePhotoSection(),
              const SizedBox(height: 32),

              // Form Fields
              _buildFormSection(),

              const SizedBox(height: 32),

              // Save Button
              _buildSaveButton(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1C1C1E),
      elevation: 0,
      title: const Text(
        'Edit Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        TextButton(
          onPressed: _resetForm,
          child: const Text(
            'Reset',
            style: TextStyle(
              color: Color(0xFF007AFF),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePhotoSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              // Profile Image Container
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF3A3A3C),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF8E8E93),
                  size: 60,
                ),
              ),

              // Edit Photo Button
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _showPhotoOptions,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF007AFF),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1C1C1E),
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Tap to change profile photo',
            style: TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personal Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),

        // Name Field
        _buildTextField(
          controller: _nameController,
          focusNode: _nameFocus,
          label: 'Full Name',
          icon: Icons.person_outline,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),

        // Age Field
        _buildTextField(
          controller: _ageController,
          focusNode: _ageFocus,
          label: 'Age',
          icon: Icons.cake_outlined,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),

        // Email Field
        _buildTextField(
          controller: _emailController,
          focusNode: _emailFocus,
          label: 'Email Address',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),

        // Phone Field
        _buildTextField(
          controller: _phoneController,
          focusNode: _phoneFocus,
          label: 'Phone Number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),

        // Gender Selector
        _buildGenderSelector(),
        const SizedBox(height: 16),

        // Bio Field
        _buildTextField(
          controller: _bioController,
          focusNode: _bioFocus,
          label: 'Bio',
          icon: Icons.description_outlined,
          maxLines: 4,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: focusNode.hasFocus
              ? const Color(0xFF007AFF)
              : const Color(0xFF3A3A3C),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        keyboardType: keyboardType,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: focusNode.hasFocus
                ? const Color(0xFF007AFF)
                : const Color(0xFF8E8E93),
            fontSize: 16,
          ),
          prefixIcon: Icon(
            icon,
            color: focusNode.hasFocus
                ? const Color(0xFF007AFF)
                : const Color(0xFF8E8E93),
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        onChanged: (value) => setState(() {}),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3A3A3C),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.people_outline,
                color: Color(0xFF8E8E93),
                size: 22,
              ),
              const SizedBox(width: 12),
              const Text(
                'Gender',
                style: TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildGenderOption('Male'),
              const SizedBox(width: 20),
              _buildGenderOption('Female'),
              const SizedBox(width: 20),
              _buildGenderOption('Other'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    bool isSelected = _selectedGender == gender;

    return GestureDetector(
      onTap: () => setState(() => _selectedGender = gender),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF007AFF) : const Color(0xFF8E8E93),
                width: 2,
              ),
              color: isSelected ? const Color(0xFF007AFF) : Colors.transparent,
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            gender,
            style: TextStyle(
              color: isSelected ? const Color(0xFF007AFF) : Colors.white,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF007AFF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),

        child:
        GestureDetector(
          onTap: (){
            _saveProfile();
          },
          child: _isLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ):
          const Text(
              'Save Changes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        )

        ),
      ),
    );
  }

  void _showPhotoOptions() {
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
          children: [
            const Text(
              'Change Profile Photo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF007AFF)),
              title: const Text('Camera', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Camera selected');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFF007AFF)),
              title: const Text('Photo Library', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Photo library selected');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Color(0xFFFF3B30)),
              title: const Text('Remove Photo', style: TextStyle(color: Color(0xFFFF3B30))),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Photo removed');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);
    _onsubmit();

    // _showSnackBar('Profile updated successfully!');
  }

  void _resetForm() {
    _nameController.text = 'Alex Mitchell';
    _ageController.text = '28';
    _emailController.text = 'alex.mitchell@email.com';
    _phoneController.text = '+1 (555) 123-4567';
    _bioController.text = 'Software developer passionate about creating amazing user experiences.';
    setState(() => _selectedGender = 'Male');
    _showSnackBar('Form reset to original values');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF007AFF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}