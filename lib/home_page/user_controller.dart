import 'package:get/get.dart';

class UserController extends GetxController {
  var isLoggedIn = false.obs; // Observable boolean variable to track login status

  void login() {
    isLoggedIn.value = true; // Log the user in
  }

  void logout() {
    isLoggedIn.value = false; // Log the user out
  }
}
