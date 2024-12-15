import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:splitshipv01/auth_screen/login_screen.dart';
import 'package:splitshipv01/auth_screen/signup_screen.dart';
import 'package:splitshipv01/home_page/home_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var isChecked = false.obs;

  // Reactive user
  var user = Rxn<User>();

  @override
  void onInit() async {
    super.onInit();

    // Set persistence to local
    await _auth.setPersistence(Persistence.LOCAL);

    // Bind user stream
    user.bindStream(_auth.authStateChanges());
    ever(user, _navigateToInitialPage);
  }

  // Navigate based on auth state
  void _navigateToInitialPage(User? user) {
    if (user == null) {
      Get.offAll(() => SignupScreen()); // Replace with your LoginPage
    } else {
      Get.offAll(() => SplitShipPage()); // Replace with your HomePage
    }
  }

  // Signup method
  Future<void> signup(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Account created successfully', snackPosition: SnackPosition.BOTTOM);

      // After successful signup, navigate to the HomePage (Replace with your desired page)
      Get.offAll(() => SplitShipPage());  // Use your HomePage or Dashboard page here
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Something went wrong', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }


  // Login method
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Logged in successfully', snackPosition: SnackPosition.BOTTOM);

      // After successful login, navigate to the HomePage (Replace with your desired page)
      Get.offAll(() => SplitShipPage());  // Use your HomePage or Dashboard page here
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Invalid credentials', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Logout method
  Future<void> logout() async {
    await _auth.signOut();
  }
}
