import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitshipv01/password%20recovery/password_recovery_controller.dart';

class RecoveryDigitsScreen extends StatelessWidget {
  final PasswordRecoveryController recoveryController = Get.put(PasswordRecoveryController());

  @override
  Widget build(BuildContext context) {
    final recoveryDigitsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Recovery Digits'),
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
                    'Enter the recovery digits sent to your',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Obx(() => Text(
                    recoveryController.selectedContactMethod.value == 'Phone'
                        ? 'Phone: ...321'
                        : 'Email: ...example@mail.com', // Display selected method
                    style: TextStyle(fontSize: 18),
                  )),
                  SizedBox(height: 20),
                  TextField(
                    controller: recoveryDigitsController,
                    decoration: InputDecoration(
                      labelText: 'Recovery Digits',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  Obx(() => recoveryController.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      if (recoveryController.selectedContactMethod.isNotEmpty) {
                        // Navigate to the recovery digits screen
                        Get.to(RecoveryDigitsScreen());
                      } else {
                        Get.snackbar('Error', 'Please select a contact method.',
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: Text('Continue'),
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
