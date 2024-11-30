import 'package:get/get.dart';

class PasswordRecoveryController extends GetxController {
  var selectedContactMethod = ''.obs;
  var isLoading = false.obs;

  void setContactMethod(String method) {
    selectedContactMethod.value = method;
  }

  void recoverPassword(String method) {
    // Logic to send recovery information based on the method
  }

  void validateRecoveryDigits(String digits) {
    // Logic to validate the recovery digits entered by the user
    if (digits == "123456") { // Replace with actual validation logic
      Get.snackbar('Success', 'Digits validated successfully. You can reset your password now.');
    } else {
      Get.snackbar('Error', 'Invalid recovery digits. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
