// import 'package:flutter/material.dart';
// import 'package:tnp/admin/admin_event_page.dart';
// import 'package:tnp/admin/calendar_page.dart';
// import 'package:tnp/admin/admin_feedback_creation_page.dart';
// import 'package:tnp/admin/community_page.dart';
// import 'package:tnp/admin/messaging/admin_messaging_page.dart';
// import 'package:tnp/admin/reports_page.dart';
// import 'package:tnp/admin/student_management_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AdminDashboard extends StatelessWidget {
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Dashboard'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout), // Logout icon
//             onPressed: () async {
//               // Call the logout function when the icon is pressed
//               await _logout(context);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Card(
//               child: ListTile(
//                 title: Text('Student Management'),
//                 subtitle: Text('Manage students'),
//                 trailing: Icon(Icons.manage_accounts),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => StudentManagementPage()));
//                 },
//               ),
//             ),
//             // Card(
//             //   child: ListTile(
//             //     title: Text('Event Scheduling'),
//             //     subtitle: Text('Create events for students'),
//             //     trailing: Icon(Icons.event),
//             //     onTap: () {
//             //       Navigator.push(
//             //           context,
//             //           MaterialPageRoute(
//             //               builder: (context) => CalendarPage(
//             //                     isAdmin: true,
//             //                   ))); // Navigate to event scheduling page
//             //     },
//             //   ),
//             // ),
//             Card(
//               child: ListTile(
//                 title: Text('Feecback Management'),
//                 subtitle: Text('Create feedback'),
//                 trailing: Icon(Icons.event),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => AdminFeedbackCreationPage()));
//                 },
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('Community'),
//                 subtitle: Text('Add post'),
//                 trailing: Icon(Icons.event),
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => CommunityPage()));
//                 },
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('Event page'),
//                 subtitle: Text('Add event'),
//                 trailing: Icon(Icons.event),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => AdminEventPage()));
//                 },
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('Messages'),
//                 subtitle: Text(' '),
//                 trailing: Icon(Icons.message_rounded),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => AdminMessagingPage()));
//                 },
//               ),
//             ),
//             // Other admin sections
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:tnp/admin/admin_event_page.dart';
import 'package:tnp/admin/calendar_page.dart';
import 'package:tnp/admin/admin_feedback_creation_page.dart';
import 'package:tnp/admin/community_page.dart';
import 'package:tnp/admin/messaging/admin_messaging_page.dart';
import 'package:tnp/admin/reports_page.dart';
import 'package:tnp/admin/student_management_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminDashboard extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Firebase sign out
      // Navigate to the login page after logout
      Navigator.of(context).pushReplacementNamed('/');
    } catch (e) {
      // Handle error, you can show a Snackbar or dialog
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to logout: $e'),
      ));
    }
  }

  Widget _adminCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget nextPage,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: const Color.fromARGB(255, 3, 5, 142), width: 2), // Blue border
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: Color.fromARGB(255, 21, 0, 85), // Dark color
              fontWeight: FontWeight.bold,
              fontSize: 20, // Increased font size
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Color.fromARGB(255, 27, 4, 96), // Darker subtitle color
            ),
          ),
          trailing: Icon(icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Train2Place',
          style: TextStyle(color: Color.fromARGB(255, 21, 0, 85)), // Dark Blue
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Color.fromARGB(255, 21, 0, 85)), // Dark Blue Icon
            onPressed: () async {
              // Call the logout function when the icon is pressed
              await _logout(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Text and Admin Note
              Text(
                "Welcome to the Admin Dashboard",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 21, 0, 85), // Dark Blue
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Here you can manage all aspects of the platform. Choose an option below to proceed.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 27, 4, 96), // Darker color for the note
                ),
              ),
              SizedBox(height: 20),

              // Cards for navigation
              _adminCard(
                context: context,
                title: 'Student Management',
                subtitle: 'Manage students',
                icon: Icons.manage_accounts,
                nextPage: StudentManagementPage(),
              ),
              SizedBox(height: 15), // Space between cards
              _adminCard(
                context: context,
                title: 'Feedback Management',
                subtitle: 'Create feedback',
                icon: Icons.feedback,
                nextPage: AdminFeedbackCreationPage(),
              ),
              SizedBox(height: 15), // Space between cards
              _adminCard(
                context: context,
                title: 'Community',
                subtitle: 'Add post',
                icon: Icons.people,
                nextPage: CommunityPage(),
              ),
              SizedBox(height: 15), // Space between cards
              _adminCard(
                context: context,
                title: 'Event Page',
                subtitle: 'Add event',
                icon: Icons.event,
                nextPage: AdminEventPage(),
              ),
              SizedBox(height: 15), // Space between cards
              _adminCard(
                context: context,
                title: 'Messages',
                subtitle: 'Manage messages',
                icon: Icons.message_rounded,
                nextPage: AdminMessagingPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
