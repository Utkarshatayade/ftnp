import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For formatting date and time

class AdminChatPage extends StatefulWidget {
  final String recipientEmail; // The student email

  AdminChatPage({required this.recipientEmail});

  @override
  _AdminChatPageState createState() => _AdminChatPageState();
}

class _AdminChatPageState extends State<AdminChatPage> {
  final _messageController = TextEditingController();

  void _sendMessage(String message) async {
    if (message.isEmpty) return;

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return;

    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'sender': currentUser.email,
        'recipient': widget.recipientEmail,
        'message': message,
        'timestamp': Timestamp.now(),
      });
      _messageController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.recipientEmail}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _getMessagesStream(),
              builder: (context,
                  AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                var messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var msg = messages[index];
                    bool isSender = msg['sender'] ==
                        FirebaseAuth.instance.currentUser?.email;
                    return ListTile(
                      title: Text(msg['message']),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Align the elements
                        children: [
                          Text(isSender ? 'You' : widget.recipientEmail),
                          Text(
                            DateFormat('EEE, MMM d, y h:mm a').format(
                              (msg['timestamp'] as Timestamp).toDate(),
                            ),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      tileColor:
                          isSender ? Colors.lightGreenAccent : Colors.white,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stream<List<QueryDocumentSnapshot>> _getMessagesStream() async* {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    var sentMessagesQuery = FirebaseFirestore.instance
        .collection('messages')
        .where('sender', isEqualTo: currentUser.email)
        .where('recipient', isEqualTo: widget.recipientEmail);

    var receivedMessagesQuery = FirebaseFirestore.instance
        .collection('messages')
        .where('sender', isEqualTo: widget.recipientEmail)
        .where('recipient', isEqualTo: currentUser.email);

    var sentMessagesStream = sentMessagesQuery.snapshots();
    var receivedMessagesStream = receivedMessagesQuery.snapshots();

    await for (var sentSnapshot in sentMessagesStream) {
      var sentMessages = sentSnapshot.docs;
      await for (var receivedSnapshot in receivedMessagesStream) {
        var receivedMessages = receivedSnapshot.docs;
        var allMessages = [...sentMessages, ...receivedMessages];
        allMessages.sort((a, b) {
          Timestamp timestampA = a['timestamp'] as Timestamp;
          Timestamp timestampB = b['timestamp'] as Timestamp;
          return timestampA.compareTo(timestampB);
        });

        yield allMessages;
      }
    }
  }
}

// ------------------------------------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AdminChatPage extends StatefulWidget {
//   final String recipientEmail; // The student email

//   AdminChatPage({required this.recipientEmail});

//   @override
//   _AdminChatPageState createState() => _AdminChatPageState();
// }

// class _AdminChatPageState extends State<AdminChatPage> {
//   final _messageController = TextEditingController();

//   void _sendMessage(String message) async {
//     if (message.isEmpty) return;

//     final currentUser = FirebaseAuth.instance.currentUser;

//     if (currentUser == null) return;

//     try {
//       await FirebaseFirestore.instance.collection('messages').add({
//         'sender': currentUser.email,
//         'recipient': widget.recipientEmail,
//         'message': message,
//         'timestamp': Timestamp.now(),
//       });
//       _messageController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to send message: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with ${widget.recipientEmail}'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: _getMessagesStream(),
//               builder: (context,
//                   AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
//                 if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//                 var messages = snapshot.data!;
//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var msg = messages[index];
//                     bool isSender = msg['sender'] == FirebaseAuth.instance.currentUser?.email;
//                     return ListTile(
//                       title: Text(msg['message']),
//                       subtitle: Text(isSender ? 'You' : widget.recipientEmail),
//                       trailing: Text(
//                         (msg['timestamp'] as Timestamp).toDate().toString(),
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       tileColor: isSender ? Colors.lightGreenAccent : Colors.white,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () => _sendMessage(_messageController.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Stream<List<QueryDocumentSnapshot>> _getMessagesStream() async* {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;

//     var sentMessagesQuery = FirebaseFirestore.instance
//         .collection('messages')
//         .where('sender', isEqualTo: currentUser.email)
//         .where('recipient', isEqualTo: widget.recipientEmail);

//     var receivedMessagesQuery = FirebaseFirestore.instance
//         .collection('messages')
//         .where('sender', isEqualTo: widget.recipientEmail)
//         .where('recipient', isEqualTo: currentUser.email);

//     var sentMessagesStream = sentMessagesQuery.snapshots();
//     var receivedMessagesStream = receivedMessagesQuery.snapshots();

//     await for (var sentSnapshot in sentMessagesStream) {
//       var sentMessages = sentSnapshot.docs;
//       await for (var receivedSnapshot in receivedMessagesStream) {
//         var receivedMessages = receivedSnapshot.docs;
//         var allMessages = [...sentMessages, ...receivedMessages];
//         allMessages.sort((a, b) {
//           Timestamp timestampA = a['timestamp'] as Timestamp;
//           Timestamp timestampB = b['timestamp'] as Timestamp;
//           return timestampA.compareTo(timestampB);
//         });

//         yield allMessages;
//       }
//     }
//   }
// }
