import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("No user logged in");
      }

      final uid = user.uid;
      final DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
  
      throw Exception("Error fetching profile: ${e.toString()}");
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Logout failed: ${e.toString()}");
    }
  }
}