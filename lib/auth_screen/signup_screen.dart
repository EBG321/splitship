import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../account setup/account_setup_screen.dart';
import 'auth_controller.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(50, 0, 45, 83),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500), // Limit the form width for larger screens
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // Center content
                children: [
                  Text(
                    'Create your Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
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
                    ],
                  )),
                  SizedBox(height: 20),
                  Obx(() => authController.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      authController.signup(
                        emailController.text,
                        passwordController.text,
                      );
                      Get.to(AccountSetupScreen());
                    },
                    child: Text('Sign up'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50), // Full-width button
                    ),
                  )),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: Text('Already have an account? Sign in'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
