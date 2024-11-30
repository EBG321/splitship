import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitshipv01/account%20setup/account_setup_screen.dart';
import '../password recovery/password_recovery_screen.dart';
import 'auth_controller.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController()); // Ensure controller is initialized
  final _formKey = GlobalKey<FormState>(); // Key to validate the form

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(50, 0, 45, 83),
      body: Center(
        child: SingleChildScrollView( // Ensures scrolling in case screen height is small
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500), // Limits the width of the form for larger screens
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, // Use the form key for validation
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, // Center the contents
                  children: [
                    Text(
                      'Let\'s you in',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    _socialLoginButton('Continue with Facebook'),
                    _socialLoginButton('Continue with Google'),
                    _socialLoginButton('Continue with Apple'),
                    SizedBox(height: 40),
                    Text('or'),
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
                              value: authController.isChecked.value, // Use reactive variable
                              onChanged: (value) {
                                authController.isChecked.value = value!;
                              },
                            ),
                            Text('Remember me'),
                          ],
                        ),
                        TextButton(onPressed: () {
                          Get.to(PasswordRecoveryScreen());
                        }, child: Text('Forgot password?')),
                      ],
                    )),
                    SizedBox(height: 20),
                    Obx(() => authController.isLoading.value
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () {
                        // Validate the form before attempting login
                        if (_formKey.currentState?.validate() ?? false) {
                          // If valid, attempt login
                          authController.login(
                            emailController.text,
                            passwordController.text,
                          );
                          Get.to(AccountSetupScreen());
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

  Widget _socialLoginButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(text),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50), // Full-width button
        ),
      ),
    );
  }
}
