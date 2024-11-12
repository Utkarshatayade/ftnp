// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FeedbackForm extends StatefulWidget {
//   @override
//   _FeedbackFormState createState() => _FeedbackFormState();
// }

// class _FeedbackFormState extends State<FeedbackForm> {
//   final TextEditingController _feedbackController = TextEditingController();

//   void _submitFeedback() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (_feedbackController.text.isEmpty || user == null) return;

//     try {
//       await FirebaseFirestore.instance.collection('feedback').add({
//         'email': user.email,
//         'feedback': _feedbackController.text,
//         'timestamp': Timestamp.now(),
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Feedback submitted successfully!'),
//       ));
//       _feedbackController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error submitting feedback: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Submit Feedback')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _feedbackController,
//               decoration: InputDecoration(
//                 labelText: 'Your Feedback',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 4,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submitFeedback,
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() async {
    final user = FirebaseAuth.instance.currentUser;
    if (_feedbackController.text.isEmpty || user == null) return;

    try {
      await FirebaseFirestore.instance.collection('feedback').add({
        'email': user.email,
        'feedback': _feedbackController.text,
        'timestamp': Timestamp.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Feedback submitted successfully!'),
        backgroundColor: Colors.green, // Green for success
      ));
      _feedbackController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting feedback: $e'),
          backgroundColor: Colors.red, // Red for error
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Blue AppBar color
        title: Text(
          'Submit Feedback',
          style: TextStyle(color: Colors.white), // White text color in AppBar
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                labelStyle: TextStyle(color: Colors.blue[900]), // Blue label color
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]!), // Blue border on focus
                ),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Blue button background
              ),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white), // White text color in button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
