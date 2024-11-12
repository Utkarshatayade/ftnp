// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class StudentEventPage extends StatefulWidget {
//   @override
//   _StudentEventPageState createState() => _StudentEventPageState();
// }

// class _StudentEventPageState extends State<StudentEventPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upcoming Events'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('events')
//             .orderBy('eventDateTime', descending: false)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(
//                 child: Text('Error fetching events: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No upcoming events'));
//           }

//           var events = snapshot.data!.docs;

//           return LayoutBuilder(
//             builder: (context, constraints) {
//               if (constraints.maxWidth > 600) {
//                 // Grid layout for larger screens
//                 return GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 3 / 2,
//                   ),
//                   itemCount: events.length,
//                   itemBuilder: (context, index) {
//                     var event = events[index];
//                     return _buildEventCard(event);
//                   },
//                 );
//               } else {
//                 // List layout for smaller screens
//                 return ListView.builder(
//                   itemCount: events.length,
//                   itemBuilder: (context, index) {
//                     var event = events[index];
//                     return _buildEventCard(event);
//                   },
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildEventCard(DocumentSnapshot event) {
//     var eventDateTime = event['eventDateTime'].toDate();
//     return Card(
//       margin: EdgeInsets.all(10),
//       child: ListTile(
//         title: Text(event['title']),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '${DateFormat.yMMMd().format(eventDateTime)} at ${DateFormat.jm().format(eventDateTime)}',
//             ),
//             SizedBox(height: 5),
//             Text(event['description']),
//             SizedBox(height: 5),
//             if (event['link'] != null && event['link'].isNotEmpty)
//               GestureDetector(
//                 onTap: () {
//                   _openEventLink(event['link']);
//                 },
//                 child: Text(
//                   event['link'],
//                   style: TextStyle(
//                     color: Colors.blue,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _openEventLink(String url) {
//     // Implement logic to open the event link (e.g., using url_launcher)
//     print('Opening event link: $url');
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StudentEventPage extends StatefulWidget {
  @override
  _StudentEventPageState createState() => _StudentEventPageState();
}

class _StudentEventPageState extends State<StudentEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upcoming Events',
          style: TextStyle(
            color: Colors.white, // White text color for the AppBar title
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 40, 6, 143), // Dark Blue color
        iconTheme: IconThemeData(
          color: Colors.white, // Make the icons in the AppBar white
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('events')
            .orderBy('eventDateTime', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Error fetching events: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No upcoming events'));
          }

          var events = snapshot.data!.docs;

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Grid layout for larger screens
                return GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    var event = events[index];
                    return _buildEventCard(event);
                  },
                );
              } else {
                // List layout for smaller screens
                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    var event = events[index];
                    return _buildEventCard(event);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildEventCard(DocumentSnapshot event) {
    var eventDateTime = event['eventDateTime'].toDate();
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners for card
      ),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.2), // Shadow effect for the card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event['title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 21, 0, 85), // Dark blue title
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${DateFormat.yMMMd().format(eventDateTime)} at ${DateFormat.jm().format(eventDateTime)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700], // Lighter text for date and time
              ),
            ),
            SizedBox(height: 12),
            Text(
              event['description'] ?? 'No description available.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            if (event['link'] != null && event['link'].isNotEmpty)
              GestureDetector(
                onTap: () {
                  _openEventLink(event['link']);
                },
                child: Text(
                  event['link'],
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _openEventLink(String url) {
    // Implement logic to open the event link (e.g., using url_launcher)
    print('Opening event link: $url');
  }
}
