import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'admin_chat_page.dart';

class AdminMessagingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User to Chat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isNotEqualTo: 'admin') // Show only non-admin users
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          var users = snapshot.data!.docs;

          if (users.isEmpty) {
            return Center(child: Text('No users available to chat.'));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              return ListTile(
                title: Text(user['email']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminChatPage(
                        recipientEmail: user['email'],
                      ),
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
