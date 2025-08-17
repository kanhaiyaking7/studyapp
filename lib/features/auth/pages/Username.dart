


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/features/auth/pages/Studytime.dart';
import 'package:hi/features/auth/provider/User_provider.dart';

class UserName extends ConsumerStatefulWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  ConsumerState<UserName> createState() => _UserNameState();
}

class _UserNameState extends ConsumerState<UserName> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();

  String name = '';
  String age = '';
  String? focusedField;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        name = _nameController.text;
      });
    });

    _ageController.addListener(() {
      setState(() {
        age = _ageController.text;
      });
    });

    _nameFocusNode.addListener(() {
      setState(() {
        focusedField = _nameFocusNode.hasFocus ? 'name' : null;
      });
    });

    _ageFocusNode.addListener(() {
      setState(() {
        focusedField = _ageFocusNode.hasFocus ? 'age' : null;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _nameFocusNode.dispose();
    _ageFocusNode.dispose();
    super.dispose();
  }

  bool get isFormValid {
    return name.trim().isNotEmpty &&
        age.trim().isNotEmpty &&
        int.tryParse(age) != null &&
        int.parse(age) > 0;
  }

  void handleContinue() {
    if (isFormValid) {
      ref.read(UserDetails.notifier).user_info(name, int.parse(age));
      // Userinfo().first_page(name: name, age: int.parse(age));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => StudyTime()),
      );
      // Handle navigation or next step
    }
  }

  void handleAgeChange(String text) {
    // Only allow numbers
    final numericValue = text.replaceAll(RegExp(r'[^0-9]'), '');
    _ageController.text = numericValue;
    _ageController.selection = TextSelection.fromPosition(
      TextPosition(offset: numericValue.length),
    );
  }

  bool get isAgeInvalid {
    return age.isNotEmpty && (int.tryParse(age) == null || int.parse(age) <= 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1f2e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1f2e),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF1a1f2e),
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Hide keyboard when tapping outside
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const Text(
                        'Tell us about yourself',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Help us personalize your learning experience.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF9ca3af),
                          height: 1.375,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Form Fields
                Column(
                  children: [
                    // Name Input
                    _buildInputField(
                      label: 'Your Name',
                      placeholder: 'Enter your name',
                      icon: Icons.person,
                      iconColor: const Color(0xFF4285F4),
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      fieldName: 'name',
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_ageFocusNode);
                      },
                    ),
                    const SizedBox(height: 24),

                    // Age Input
                    _buildInputField(
                      label: 'Your Age',
                      placeholder: 'Enter your age',
                      icon: Icons.cake,
                      iconColor: const Color(0xFFFF6B35),
                      controller: _ageController,
                      focusNode: _ageFocusNode,
                      fieldName: 'age',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) {
                        if (isFormValid) {
                          handleContinue();
                        }
                      },
                    ),

                    // Age validation message
                    if (isAgeInvalid)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 16,
                              color: Color(0xFFef4444),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Please enter a valid age',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFef4444),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isFormValid ? handleContinue : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      isFormValid
                          ? const Color(0xFF4285F4)
                          : const Color(0xFF374151),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: isFormValid ? 6 : 3,
                      shadowColor:
                      isFormValid
                          ? const Color(0xFF4285F4).withOpacity(0.3)
                          : Colors.black.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                            isFormValid
                                ? Colors.white
                                : const Color(0xFF9ca3af),
                          ),
                        ),
                        if (isFormValid) ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.white,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String placeholder,
    required IconData icon,
    required Color iconColor,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String fieldName,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextInputAction? textInputAction,
    Function(String)? onSubmitted,
  }) {
    final isFocused = focusedField == fieldName;
    final hasValue = controller.text.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isFocused ? const Color(0xFF2a3142) : const Color(0xFF252b3a),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
          hasValue
              ? const Color(0xFF10b981)
              : isFocused
              ? const Color(0xFF4285F4)
              : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color:
            isFocused
                ? const Color(0xFF4285F4).withOpacity(0.3)
                : Colors.black.withOpacity(0.1),
            blurRadius: isFocused ? 6 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(icon, size: 24, color: iconColor),
          ),
          const SizedBox(width: 16),

          // Input Wrapper
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9ca3af),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: const TextStyle(
                      color: Color(0xFF6b7280),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  textInputAction: textInputAction,
                  onSubmitted: onSubmitted,
                ),
              ],
            ),
          ),

          // Clear Button
          if (hasValue)
            GestureDetector(
              onTap: () {
                controller.clear();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(left: 12),
                child: const Icon(
                  Icons.clear,
                  size: 20,
                  color: Color(0xFF9ca3af),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
