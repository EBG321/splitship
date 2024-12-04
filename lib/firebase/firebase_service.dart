import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Fetch container data from Firestore
  Future<List<Map<String, dynamic>>> getContainers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('containers').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error fetching containers: $e');
      return [];
    }
  }

  // Fetch image from Firebase Storage (returns image URL)
  Future<String> getImageUrl(String imagePath) async {
    try {
      String imageUrl = await _storage.ref(imagePath).getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error fetching image: $e');
      return '';
    }
  }
}