import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Add student data to the respective collection (based on year)
  Future<void> addStudentData({
    required String name,
    required String email,
    required String year,
    required double highSchoolPercentage,
    required double skillsScore,
  }) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('students')
        .doc(year)
        .collection('yearly_students')
        .doc(user.uid)
        .set({
      'name': name,
      'email': email,
      'highSchoolPercentage': highSchoolPercentage,
      'skillsScore': skillsScore,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Retrieve students list (Admin view)
  Stream<QuerySnapshot> getStudentsByYear(String year) {
    return _firestore
        .collection('students')
        .doc(year)
        .collection('yearly_students')
        .snapshots();
  }

  // Add admin data
  Future<void> addAdminData({
    required String name,
    required String email,
  }) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('admins').doc(user.uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> sendMessage(String chatId, String message) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'message': message,
      'sentAt': FieldValue.serverTimestamp(),
    });
  }

// Fetch messages for a chat
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('sentAt')
        .snapshots();
  }

// Schedule event (Admin-side)
  Future<void> scheduleEvent({
    required String title,
    required String description,
    required DateTime date,
  }) async {
    await _firestore.collection('events').add({
      'title': title,
      'description': description,
      'date': date,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

// Fetch scheduled events (Student-side)
  Stream<QuerySnapshot> getScheduledEvents() {
    return _firestore
        .collection('events')
        .orderBy('date', descending: false)
        .snapshots();
  }

// Submit feedback (Student-side)
  Future<void> submitFeedback(String feedback) async {
    await _firestore.collection('feedback').add({
      'feedback': feedback,
      'submittedAt': FieldValue.serverTimestamp(),
    });
  }

// Fetch feedback (Admin-side)
  Stream<QuerySnapshot> getFeedback() {
    return _firestore
        .collection('feedback')
        .orderBy('submittedAt', descending: true)
        .snapshots();
  }



}



// Send a message to Firestore



