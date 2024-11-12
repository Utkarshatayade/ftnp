import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentManagementPage extends StatelessWidget {
  Future<void> _deleteStudent(String studentId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(studentId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Students'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'student')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              var student = snapshot.data!.docs[index];
              return ListTile(
                title: Text(student['email']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteStudent(student.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
