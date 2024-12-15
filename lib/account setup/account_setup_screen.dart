import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_page/home_page.dart';
import 'account_setup_controller.dart';

class AccountSetupScreen extends StatelessWidget {
  final AccountSetupController accountSetupController =
  Get.put(AccountSetupController());
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final usernameController = TextEditingController();
    final phoneController = TextEditingController();
    final companyNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Account Setup',
          style: TextStyle(color: Colors.teal),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background decoration (optional)
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/background_pattern.png', // Subtle background pattern image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Create Your Account with SplitShip',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          labelText: 'First Name',
                          icon: Icons.person,
                          controller: firstNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          labelText: 'Last Name',
                          icon: Icons.person_outline,
                          controller: lastNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          labelText: 'Username',
                          icon: Icons.account_circle,
                          controller: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          labelText: 'Phone Number',
                          icon: Icons.phone,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          labelText: 'Company Name (if applicable)',
                          icon: Icons.business,
                          controller: companyNameController,
                          validator: (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                value.length < 3) {
                              return 'Company name must be at least 3 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Obx(
                              () => accountSetupController.isLoading.value
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ??
                                  false) {
                                accountSetupController
                                    .setupAccount(
                                  firstNameController.text,
                                  lastNameController.text,
                                  usernameController.text,
                                  phoneController.text,
                                  companyNameController.text,
                                )
                                    .then((_) {
                                  Get.snackbar('Success',
                                      'Account created successfully!');
                                  Get.to(SplitShipPage());
                                }).catchError((error) {
                                  Get.snackbar(
                                    'Error',
                                    'Account setup failed: $error',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'SplitShip helps you share container space and save money!',
                          style:
                          TextStyle(fontSize: 16, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[900]?.withOpacity(0.7),
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.teal),
        ),
      ),
      validator: validator,
    );
  }
}
