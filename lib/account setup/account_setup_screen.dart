import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_page/home_page.dart';
import 'account_setup_controller.dart';

class AccountSetupScreen extends StatelessWidget {
  final AccountSetupController accountSetupController = Get.put(AccountSetupController());
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final companyNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Setup'),
        backgroundColor: Color.fromARGB(50, 0, 45, 83),
      ),
      backgroundColor: Color.fromARGB(50, 0, 45, 83),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, // Assign the form key for validation
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Create Your Account with SplitShip',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    // Full Name field with validation
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Full Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Phone Number field with validation
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
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
                    SizedBox(height: 10),

                    // Company Name field with validation (optional)
                    TextFormField(
                      controller: companyNameController,
                      decoration: InputDecoration(labelText: 'Company Name (if applicable)'),
                    ),
                    SizedBox(height: 20),

                    // Submit button
                    Obx(() => accountSetupController.isLoading.value
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () {
                        // Validate the form before attempting account setup
                        if (_formKey.currentState?.validate() ?? false) {
                          // If valid, proceed to setup account
                          accountSetupController.setupAccount(
                            nameController.text,
                            phoneController.text,
                            companyNameController.text,
                          );
                          Get.to(SplitShipPage());
                        }
                      },
                      child: Text('Create Account'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50), // Full-width button
                      ),
                    )),
                    SizedBox(height: 20),
                    Text('SplitShip helps you share container space and save money!'),
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
