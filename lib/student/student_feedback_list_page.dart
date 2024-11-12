import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'student_feedback_form_page.dart';

class StudentFeedbackListPage extends StatefulWidget {
  @override
  _StudentFeedbackListPageState createState() =>
      _StudentFeedbackListPageState();
}

class _StudentFeedbackListPageState extends State<StudentFeedbackListPage> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future<Map<String, bool>> _getSubmittedFeedbacks() async {
    // Get feedback submissions by the current user
    QuerySnapshot submissionsSnapshot = await FirebaseFirestore.instance
        .collection('feedbackSubmissions')
        .where('studentId', isEqualTo: currentUserId)
        .get();

    Map<String, bool> submittedForms = {};

    for (var doc in submissionsSnapshot.docs) {
      submittedForms[doc['formId']] = true;
    }

    return submittedForms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Feedback Forms'),
      ),
      body: FutureBuilder<Map<String, bool>>(
        future: _getSubmittedFeedbacks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          // List of feedbacks already submitted by the student
          Map<String, bool> submittedForms = snapshot.data!;

          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('feedbackForms')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> formSnapshot) {
              if (!formSnapshot.hasData) return CircularProgressIndicator();

              var feedbackForms = formSnapshot.data!.docs;

              if (feedbackForms.isEmpty) {
                return Center(child: Text('No feedback forms available.'));
              }

              return ListView.builder(
                itemCount: feedbackForms.length,
                itemBuilder: (context, index) {
                  var form = feedbackForms[index];
                  bool hasSubmitted = submittedForms.containsKey(form.id);

                  return Card(
                    child: ListTile(
                      title: Text(form['formName']),
                      subtitle: hasSubmitted
                          ? Text('You have already submitted this feedback.')
                          : Text('Tap to submit feedback.'),
                      trailing: hasSubmitted
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : Icon(Icons.arrow_forward),
                      enabled: !hasSubmitted,
                      onTap: hasSubmitted
                          ? null
                          : () {
                              // Navigate to feedback form page for filling
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentFeedbackFormPage(
                                    formId: form.id,
                                  ),
                                ),
                              );
                            },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
