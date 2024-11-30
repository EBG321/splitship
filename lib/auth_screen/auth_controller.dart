import 'package:get/get.dart';

class AuthController extends GetxController {
  var isChecked = false.obs;  // Reactive variable for checkbox state

  var isLoading = false.obs;

  // Handle login
  void login(String email, String password) async {
    isLoading.value = true;
    try {
      // Simulate API request (replace with actual login logic)
      await Future.delayed(Duration(seconds: 2));
      Get.snackbar('Success', 'Logged in successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to login');
    } finally {
      isLoading.value = false;
    }
  }

  // Handle signup
  void signup(String email, String password) async {
    isLoading.value = true;
    try {
      // Simulate API request (replace with actual signup logic)
      await Future.delayed(Duration(seconds: 2));
      Get.snackbar('Success', 'Account created successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create account');
    } finally {
      isLoading.value = false;
    }
  }
}
