import 'package:get/get.dart';

class AccountSetupController extends GetxController {
  var isLoading = false.obs;

  void setupAccount(String name,  String phone, String companyName) {
    // Logic to set up account
    isLoading.value = true;

    // Simulate a network call
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      // Handle account setup response
      Get.snackbar('Success', 'Account created successfully!');
    });
  }
}
