import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitshipv01/password%20recovery/password_recovery_controller.dart';
import 'package:splitshipv01/password%20recovery/recovery_digits_screen.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  final PasswordRecoveryController recoveryController = Get.put(PasswordRecoveryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Recovery'),
        backgroundColor: Color.fromARGB(50, 0, 45, 83),
      ),
      backgroundColor: Color.fromARGB(50, 0, 45, 83),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Recover Your Password',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Phone Number Button
                  Obx(() => ElevatedButton(
                    onPressed: () {
                      recoveryController.setContactMethod('Phone');
                    },
                    child: Text('Phone: ...321'), // Replace with actual phone number logic
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50), backgroundColor: recoveryController.selectedContactMethod.value == 'Phone'
                          ? Colors.blueAccent
                          : Colors.grey, // Highlight selected button
                    ),
                  )),
                  SizedBox(height: 10), // Space between buttons
                  // Email Button
                  Obx(() => ElevatedButton(
                    onPressed: () {
                      recoveryController.setContactMethod('Email');
                    },
                    child: Text('Email: ...example@mail.com'), // Replace with actual email logic
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50), backgroundColor: recoveryController.selectedContactMethod.value == 'Email'
                          ? Colors.blueAccent
                          : Colors.grey, // Highlight selected button
                    ),
                  )),
                  SizedBox(height: 20), // Space before send button
                  // Send Recovery Button
                  Obx(() => recoveryController.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      if (recoveryController.selectedContactMethod.isNotEmpty) {
                        // Here we can send the recovery based on the selected method
                        // but without a text field, you might want to show a message or a dialog
                        recoveryController.recoverPassword(recoveryController.selectedContactMethod.value);
                      } else {
                        Get.snackbar('Error', 'Please select a contact method.',
                            snackPosition: SnackPosition.BOTTOM);
                      }
                      Get.to(RecoveryDigitsScreen());
                    },
                    child: Text('Send Recovery'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50), // Full-width button
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
