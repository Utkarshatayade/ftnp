import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For formatting date and time

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  bool _isAdmin = false;
  final TextEditingController _postController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _checkUserRole() async {
    try {
      final userDoc = await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .get();
      setState(() {
        _isAdmin = userDoc.exists &&
            (userDoc.data() as Map<String, dynamic>)['role'] == 'admin';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking user role: $e')),
      );
    }
  }

  void _postToCommunity(String content, BuildContext context) async {
    if (content.isEmpty) return;

    try {
      await _firestore.collection('communityPosts').add({
        'content': content,
        'timestamp': Timestamp.now(),
        'postedBy': _auth.currentUser?.email,
      });
      _postController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error posting: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(title: Text('Community Posts')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            children: [
              if (_isAdmin) ...[
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: TextField(
                    controller: _postController,
                    decoration: InputDecoration(
                      labelText: 'Write a post',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: ElevatedButton(
                    onPressed: () =>
                        _postToCommunity(_postController.text, context),
                    child: Text('Post'),
                  ),
                ),
              ],
              SizedBox(
                height: isLandscape ? screenHeight * 0.5 : screenHeight * 0.6,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('communityPosts')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error loading posts: ${snapshot.error}'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No posts available.'));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (context, index) {
                        var post = snapshot.data!.docs[index];

                        // Get the posted timestamp and format it
                        Timestamp timestamp = post['timestamp'] as Timestamp;
                        DateTime dateTime = timestamp.toDate();
                        String formattedDate =
                            DateFormat('MM/dd/yyyy hh:mm a').format(dateTime);

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row for email and formatted date/time
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      post['postedBy'] ?? 'Unknown',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      formattedDate,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height:
                                        5), // Space between date and content
                                // Post content
                                Text(post['content']),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------------------------------------------
// In lib/admin/community_page.dart
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class CommunityPage extends StatefulWidget {
//   const CommunityPage({super.key});

//   @override
//   State<CommunityPage> createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   bool _isAdmin = false;
//   final TextEditingController _postController = TextEditingController();

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> _checkUserRole() async {
//     try {
//       final userDoc = await _firestore
//           .collection('users')
//           .doc(_auth.currentUser?.uid)
//           .get();
//       setState(() {
//         _isAdmin = userDoc.exists &&
//             (userDoc.data() as Map<String, dynamic>)['role'] == 'admin';
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error checking user role: $e')),
//       );
//     }
//   }

//   void _postToCommunity(String content, BuildContext context) async {
//     if (content.isEmpty) return;

//     try {
//       await _firestore.collection('communityPosts').add({
//         'content': content,
//         'timestamp': Timestamp.now(),
//         'postedBy': _auth.currentUser?.email,
//       });
//       _postController.clear();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Post added successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error posting: $e')),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _checkUserRole();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Scaffold(
//       appBar: AppBar(title: Text('Community Posts')),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: screenWidth * 0.05,
//             vertical: screenHeight * 0.02,
//           ),
//           child: Column(
//             children: [
//               if (_isAdmin) ...[
//                 Padding(
//                   padding: EdgeInsets.all(screenWidth * 0.02),
//                   child: TextField(
//                     controller: _postController,
//                     decoration: InputDecoration(
//                       labelText: 'Write a post',
//                       border: OutlineInputBorder(),
//                     ),
//                     maxLines: 3,
//                   ),
//                 ),
//                 SizedBox(
//                   width: screenWidth * 0.9,
//                   child: ElevatedButton(
//                     onPressed: () =>
//                         _postToCommunity(_postController.text, context),
//                     child: Text('Post'),
//                   ),
//                 ),
//               ],
//               SizedBox(
//                 height: isLandscape ? screenHeight * 0.5 : screenHeight * 0.6,
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: _firestore
//                       .collection('communityPosts')
//                       .orderBy('timestamp', descending: true)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return Center(
//                         child: Text('Error loading posts: ${snapshot.error}'),
//                       );
//                     }

//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     }

//                     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                       return Center(child: Text('No posts available.'));
//                     }

//                     return ListView.builder(
//                       itemCount: snapshot.data?.docs.length ?? 0,
//                       itemBuilder: (context, index) {
//                         var post = snapshot.data!.docs[index];
//                         return Card(
//                           child: ListTile(
//                             title: Text(post['postedBy']),
//                             subtitle: Text(post['content']),
//                             trailing: Text(
//                               (post['timestamp'] as Timestamp)
//                                   .toDate()
//                                   .toString(),
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
