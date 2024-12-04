import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../account setup/account_setup_screen.dart';
import '../password recovery/password_recovery_screen.dart';
import 'auth_controller.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController()); // Initialize controller
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(50, 0, 45, 83),
      body: Center(
        child: SingleChildScrollView( // Allow scrolling for smaller screens
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500), // Limit form width
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, // Attach form key
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Let\'s you in',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // Email field with validation
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Password field with validation
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: authController.isChecked.value, // Reactive variable
                              onChanged: (value) {
                                authController.isChecked.value = value!;
                              },
                            ),
                            Text('Remember me'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(PasswordRecoveryScreen());
                          },
                          child: Text('Forgot password?'),
                        ),
                      ],
                    )),
                    SizedBox(height: 20),
                    Obx(() => authController.isLoading.value
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          authController.login(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                      child: Text('Sign in'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50), // Full-width button
                      ),
                    )),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Get.to(SignupScreen());
                      },
                      child: Text('Don\'t have an account? Sign up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
