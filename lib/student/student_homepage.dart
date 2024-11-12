// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:tnp/admin/community_page.dart';
// import 'package:tnp/student/admin_list_page.dart';
// import 'package:tnp/student/messaging_page.dart';
// import 'package:tnp/admin/calendar_page.dart';
// import 'package:tnp/student/student_event_page.dart';
// import 'package:tnp/student/student_feedback_form_page.dart';
// import 'package:tnp/student/student_feedback_list_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../authentication/login_page.dart';
// import '../train2place/interview/interview.dart';
// import '../train2place/quizapp/quiz_adder.dart';
// import '../train2place/quizapp/quiz_list.dart';
// import '../train2place/roadmaps/resources_page.dart';
// import '../train2place/roadmaps/roadmap_page.dart';

// class StudentHomePage extends StatefulWidget {
//   @override
//   State<StudentHomePage> createState() => _StudentHomePageState();
// }

// class _StudentHomePageState extends State<StudentHomePage> {
//   // ----------------------------------------------------------------------------------
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? user;
//   String? profileImageUrl;
//   String? userName = "Loading...";
//   String? year;

//   // Global variables for responsiveness
//   double deviceHeight = 0;
//   double deviceWidth = 0;

//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Get device dimensions
//     deviceHeight = MediaQuery.of(context).size.height;
//     deviceWidth = MediaQuery.of(context).size.width;
//   }

//   Future<void> fetchUserData() async {
//     user = _auth.currentUser;

//     if (user != null) {
//       try {
//         final DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection(
//                 'students') // Adjust collection name based on your setup
//             .doc(user!.uid)
//             .get();

//         if (userDoc.exists) {
//           setState(() {
//             userName = userDoc['name'] ?? 'No Name';
//             profileImageUrl = userDoc['imageUrl'] ??
//                 null; // Ensure this matches your Firestore fields
//             year = userDoc['year'] ?? 'Unknown'; // Adding year
//           });
//         } else {
//           showError("User data not found");
//         }
//       } catch (e) {
//         showError('Error fetching user data: $e');
//       }
//     }
//   }

//   void showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   Future<void> signOutUser() async {
//     try {
//       await _auth.signOut();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     } catch (e) {
//       showError('Error signing out: ${e.toString()}');
//     }
//   }

//   // ----------------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Dashboard'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout), // Logout icon
//             onPressed: () async {
//               // Call the logout function when the icon is pressed
//               await _logout(context);
//             },
//           ),
//           // IconButton(
//           //   icon: Icon(Icons.logout),
//           //   onPressed: signOutUser,
//           //   tooltip: 'Sign Out',
//           // ),
//         ],
//       ),
//       // ------------------------------------------------------------------------------------------
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(color: Theme.of(context).primaryColor),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundImage: profileImageUrl != null
//                         ? NetworkImage(profileImageUrl!)
//                         : AssetImage('assets/images/default_profile.png')
//                             as ImageProvider,
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Text(
//                       userName!,
//                       style: Theme.of(context)
//                           .textTheme
//                           .headlineSmall
//                           ?.copyWith(color: Colors.white),
//                       maxLines: 2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Display user's year
//             _drawerItem(
//                 title: 'Year: $year', icon: Icons.calendar_today, onTap: () {}),
//             SizedBox(height: 10),
//             _drawerItem(
//                 title: 'Add quiz',
//                 icon: Icons.add_box_outlined,
//                 onTap: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => QuizAdder()))),
//             SizedBox(height: 10),
//             _drawerItem(
//                 title: 'Attempt quiz',
//                 icon: Icons.add_box_outlined,
//                 onTap: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => QuizList()))),
//             Divider(),
//             _drawerItem(
//                 title: 'Sign Out',
//                 icon: Icons.exit_to_app,
//                 color: Colors.red,
//                 onTap: signOutUser),
//           ],
//         ),
//       ),
//       // ------------------------------------------------------------------------------------------
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal, // Enable horizontal scrolling
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       // Event Management Card
//                       SizedBox(
//                         width: 200,
//                         height: 100, // Set a fixed width for each card
//                         child: Card(
//                           child: ListTile(
//                             title: Text('View Events'),
//                             subtitle: Text('See upcoming events'),
//                             trailing: Icon(Icons.event),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => StudentEventPage(),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       // Messaging Card
//                       SizedBox(
//                         height: 100,
//                         width: 200,
//                         child: Card(
//                           child: ListTile(
//                             title: Text('Messaging'),
//                             subtitle: Text('Chat with the admin'),
//                             trailing: Icon(Icons.message),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => AdminListPage(),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       // Calendar Card
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                         height: 100,
//                         width: 200,
//                         child: Card(
//                           child: ListTile(
//                             title: Text('Feedback'),
//                             subtitle: Text('Give Feedback'),
//                             trailing: Icon(Icons.calendar_today),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       StudentFeedbackListPage(),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       // Community Page Card
//                       SizedBox(
//                         height: 100,
//                         width: 200,
//                         child: Card(
//                           child: ListTile(
//                             title: Text('Community'),
//                             subtitle: Text('Join the community discussion'),
//                             trailing: Icon(Icons.people),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => CommunityPage(),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // ---------------------------------------------------------------------------------------
//             ListView(
//               shrinkWrap:
//                   true, // Use shrinkWrap to make ListView take only required space
//               physics:
//                   NeverScrollableScrollPhysics(), // Disable ListView's scrolling
//               children: [
//                 _homeCard(
//                   title: 'Roadmaps',
//                   description: 'Explore structured learning paths.',
//                   imagePath: 'assets/images/roadmap.png',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => RoadmapPage()),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 _homeCard(
//                   title: 'Interview Preparation',
//                   description:
//                       'Prepare for your next interview with tips and guidance.',
//                   imagePath: 'assets/images/interview_prep.png',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PreparationLandingPage()),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 _homeCard(
//                   title: 'Resources',
//                   description:
//                       'Find useful resources for learning and development.',
//                   imagePath: 'assets/images/resources.png',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ResourcesPage()),
//                     );
//                   },
//                 ),
//               ],
//             ),
//             // ---------------------------------------------------------------------------------------
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _logout(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut(); // Firebase sign out
//       // Navigate to the login page after logout
//       Navigator.of(context).pushReplacementNamed('/');
//     } catch (e) {
//       // Handle error, you can show a Snackbar or dialog
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Failed to logout: $e'),
//       ));
//     }
//   }

//   // ------------------------------------------------------------------------------------------------
//   Widget _drawerItem({
//     required String title,
//     required IconData icon,
//     Color? color,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: color ?? Theme.of(context).iconTheme.color),
//       title: Text(
//         title,
//         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
//             ),
//       ),
//       onTap: onTap,
//     );
//   }

//   Widget _homeCard({
//     required String title,
//     required String description,
//     required String imagePath,
//     required VoidCallback onTap,
//   }) {
//     return Card(
//       elevation: 6,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: onTap,
//         splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 180,
//               child: Ink.image(
//                 image: AssetImage(imagePath),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     description,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(color: Colors.black54),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   // ------------------------------------------------------------------------------------------------
// }
// //------
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tnp/admin/community_page.dart';
import 'package:tnp/student/admin_list_page.dart';
import 'package:tnp/student/messaging_page.dart';
import 'package:tnp/admin/calendar_page.dart';
import 'package:tnp/student/student_event_page.dart';
import 'package:tnp/student/student_feedback_form_page.dart';
import 'package:tnp/student/student_feedback_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../authentication/login_page.dart';
import '../train2place/interview/interview.dart';
import '../train2place/quizapp/quiz_adder.dart';
import '../train2place/quizapp/quiz_list.dart';
import '../train2place/roadmaps/resources_page.dart';
import '../train2place/roadmaps/roadmap_page.dart';

class StudentHomePage extends StatefulWidget {
  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? profileImageUrl;
  String? userName = "Loading...";
  String? year;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    user = _auth.currentUser;

    if (user != null) {
      try {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('students')
            .doc(user!.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'] ?? 'No Name';
            profileImageUrl = userDoc['imageUrl'] ?? null;
            year = userDoc['year'] ?? 'Unknown';
          });
        } else {
          showError("User data not found");
        }
      } catch (e) {
        showError('Error fetching user data: $e');
      }
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      showError('Error signing out: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Blue[900] applied
        title: Text(
          'Train2Place',
          style: TextStyle(color: Colors.white), // White title text
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white), // White logout icon
            onPressed: () async {
              await _logout(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[900]),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl!)
                        : AssetImage('assets/images/default_profile.png')
                            as ImageProvider,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      userName!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            _drawerItem(
                title: 'Year: $year', icon: Icons.calendar_today, onTap: () {}),
            _drawerItem(
                title: 'Add quiz',
                icon: Icons.add_box_outlined,
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => QuizAdder()))),
            _drawerItem(
                title: 'Attempt quiz',
                icon: Icons.add_box_outlined,
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => QuizList()))),
            Divider(),
            _drawerItem(
                title: 'Sign Out',
                icon: Icons.exit_to_app,
                color: Colors.red,
                onTap: signOutUser),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to the journey",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.blue[900], // Blue[900] for the welcome text
                ),
              ),
              SizedBox(height: 10),
              // New Box containing cards
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[900], // Blue[900] for the background color
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    GridView(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 2,
                      ),
                      children: [
                        _eventCard('View Events', Icons.event, StudentEventPage()),
                        _eventCard('Messaging', Icons.message, AdminListPage()),
                        _eventCard('Feedback', Icons.feedback, StudentFeedbackListPage()),
                        _eventCard('Community', Icons.people, CommunityPage()),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _topicCard(
                title: 'Roadmaps',
                description: 'Explore structured learning paths.',
                imagePath: 'assets/images/roadmap.png',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoadmapPage()),
                ),
                learnMore: true,
              ),
              SizedBox(height: 10),
              _topicCard(
                title: 'Interview Preparation',
                description: 'Prepare for your next interview.',
                imagePath: 'assets/images/interview_prep.png',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreparationLandingPage()),
                ),
                learnMore: true,
              ),
              SizedBox(height: 10),
              _topicCard(
                title: 'Resources',
                description: 'Find useful resources.',
                imagePath: 'assets/images/resources.png',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResourcesPage()),
                ),
                learnMore: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed('/');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to logout: $e'),
      ));
    }
  }

  Widget _drawerItem({
    required String title,
    required IconData icon,
    Color? color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Theme.of(context).iconTheme.color),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
            ),
      ),
      onTap: onTap,
    );
  }

  Widget _eventCard(String title, IconData icon, Widget page) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue[900]), // Blue[900] for icon
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]), // Blue[900] for title
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topicCard({
    required String title,
    required String description,
    required String imagePath,
    required VoidCallback onTap,
    bool learnMore = false,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.blue[900]!, width: 2), // Blue[900] border
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              child: Ink.image(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.blue[900], // Blue[900] for title
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.blue[900], // Blue[900] for description
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  if (learnMore)
                    TextButton(
                      onPressed: onTap,
                      child: Text("Learn More", style: TextStyle(color: Colors.blue[900])), // Blue[900] for button text
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
