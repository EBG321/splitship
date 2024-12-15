import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletPageController extends GetxController {
  var firstName = ''.obs; // New variable for first name
  var lastName = ''.obs;  // New variable for last name
  var balance = 0.0.obs;
  var profilePicture = ''.obs;
  var notifications = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          var data = userDoc.data() as Map<String, dynamic>;

          // Assign data to variables
          firstName.value = data['f_name'] ?? ''; // Fetch `f_name` for first name
          lastName.value = data['l_name'] ?? '';  // Fetch `l_name` for last name
          balance.value = (data['card_info']['amount'] ?? 0).toDouble(); // Get balance
          profilePicture.value = data['profile_picture'] ?? ''; // Fetch profile picture

          // Fetch notifications, ensure notification is a map
          if (data['notification'] is Map<String, dynamic>) {
            notifications.value = [data['notification']['type'] ?? '']; // Extract `type`
          }
        } else {
          print('No user document found for UID: ${user.uid}');
        }
      } else {
        print('No authenticated user found.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


}
