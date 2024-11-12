import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'messaging_page.dart'; // Import the student messaging page

class AdminListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admins'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          var admins = snapshot.data!.docs;

          return ListView.builder(
            itemCount: admins.length,
            itemBuilder: (context, index) {
              var admin = admins[index];
              return ListTile(
                title: Text(admin['email']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MessagingPage(recipientEmail: admin['email']),
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
