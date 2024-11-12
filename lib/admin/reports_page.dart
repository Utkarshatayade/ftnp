import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsPage extends StatelessWidget {
  Future<int> _getStudentCount() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'student')
        .get();
    return snapshot.docs.length;
  }

  Future<int> _getPostCount() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('communityPosts').get();
    return snapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: FutureBuilder(
        future: Future.wait([_getStudentCount(), _getPostCount()]),
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          int studentCount = snapshot.data![0];
          int postCount = snapshot.data![1];

          return ListView(
            children: [
              Card(
                child: ListTile(
                  title: Text('Total Students'),
                  trailing: Text(studentCount.toString()),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Total Posts'),
                  trailing: Text(postCount.toString()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
