import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import Firebase Auth

class AccountSetupController extends GetxController {
  var isLoading = false.obs;

  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to setup account
  Future<void> setupAccount(String firstName, String lastName, String username, String phone, String companyName) async {
    isLoading.value = true;

    try {
      // Fetch the current user's UID from Firebase Authentication
      User? user = _auth.currentUser; // Get the currently authenticated user

      if (user == null) {
        // If user is not authenticated, show error and return
        Get.snackbar('Error', 'No authenticated user found.');
        return;
      }

      String userId = user.uid; // Use the UID of the authenticated user

      // Save the user data to Firestore under 'users' collection
      await _firestore.collection('users').doc(userId).set({
        'f_name': firstName, // First name
        'l_name': lastName,  // Last name
        'username': username,  // User's chosen username
        'phone': phone,
        'company_name': companyName,
        'profile_picture': "", // You can provide default or allow user to upload later
        'container': {
          'id': "", // Placeholder for container ID
        },
        'card_info': {
          'amount': 0, // Initial balance
        },
        'notification': {
          'time': Timestamp.now(),  // Set the current time as a default
          'type': 'account_created', // Type of notification
        },
      });

      // After saving user data, show success message
      Get.snackbar('Success', 'Account created successfully!');
    } catch (e) {
      // Handle any errors that occur
      Get.snackbar('Error', 'Account setup failed: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
