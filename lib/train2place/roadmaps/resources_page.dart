// import 'package:flutter/material.dart';
// import 'package:url_launcher/link.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ResourcesPage extends StatelessWidget {
//   const ResourcesPage({Key? key}) : super(key: key);

//   // Method to launch URLs with error handling
//   Future<void> _launchUrl(BuildContext context, String url) async {
//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Could not launch $url')),
//       );
//     }
//   }

//   // Method to show error dialog when URL cannot be launched
//   void _showErrorDialog(BuildContext context, String url) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text('Could not launch $url.'),
//         actions: [
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // Method to simulate downloading PDF (replace with your actual implementation)
//   Future<void> _downloadResource() async {
//     // Simulate downloading PDF
//     throw 'Download functionality not implemented yet. Add your logic here.';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final techResources = [
//       {
//         "logo": "https://img.icons8.com/color/48/000000/python.png",
//         "name": "Python",
//         "website": "https://www.python.org/",
//         "docs": "https://docs.python.org/3/",
//         "youtube": "https://www.youtube.com/channel/UCRl22PrjQBw0yTSgpFZ7W2Q"
//       },
//       {
//         "logo": "https://img.icons8.com/color/48/000000/javascript.png",
//         "name": "JavaScript",
//         "website": "https://developer.mozilla.org/en-US/docs/Web/JavaScript",
//         "docs": "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide",
//         "youtube": "https://www.youtube.com/c/TraversyMedia"
//       },
//       {
//         "logo": "https://img.icons8.com/color/48/000000/flutter.png",
//         "name": "Flutter",
//         "website": "https://flutter.dev/",
//         "docs": "https://flutter.dev/docs",
//         "youtube": "https://www.youtube.com/c/Flutter"
//       },
//       {
//         "logo": "https://img.icons8.com/color/48/000000/react-native.png",
//         "name": "React Native",
//         "website": "https://reactnative.dev/",
//         "docs": "https://reactnative.dev/docs/getting-started",
//         "youtube": "https://www.youtube.com/c/Academind"
//       },
//       {
//         "logo": "https://img.icons8.com/color/48/000000/c-programming.png",
//         "name": "C Programming",
//         "website": "https://devdocs.io/c/",
//         "docs": "https://www.learn-c.org/",
//         "youtube": "https://www.youtube.com/user/thenewboston"
//       },
//       {
//         "logo": "https://img.icons8.com/color/48/000000/html-5.png",
//         "name": "HTML5",
//         "website":
//             "https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/HTML5",
//         "docs": "https://developer.mozilla.org/en-US/docs/Web/HTML",
//         "youtube": "https://www.youtube.com/c/Freecodecamp"
//       },
//       {
//         "logo": "https://img.icons8.com/color/48/000000/css3.png",
//         "name": "CSS3",
//         "website": "https://developer.mozilla.org/en-US/docs/Web/CSS",
//         "docs": "https://developer.mozilla.org/en-US/docs/Web/CSS/CSS3",
//         "youtube": "https://www.youtube.com/c/DesignCourse"
//       },
//       {
//         "logo": "https://img.icons8.com/color/48/000000/nodejs.png",
//         "name": "Node.js",
//         "website": "https://nodejs.org/",
//         "docs": "https://nodejs.org/en/docs/",
//         "youtube": "https://www.youtube.com/c/Codevolution"
//       },
//       {
//         "logo": "https://img.icons8.com/color/48/000000/mongodb.png",
//         "name": "MongoDB",
//         "website": "https://www.mongodb.com/",
//         "docs": "https://docs.mongodb.com/",
//         "youtube": "https://www.youtube.com/c/MongoDBOfficial"
//       },
//       // {
//       //   "logo": "assets/images/java.png",
//       //   "name": "Java",
//       //   "website": "https://www.oracle.com/java/",
//       //   "docs": "https://docs.oracle.com/javase/8/docs/",
//       //   "youtube": "https://www.youtube.com/user/koushks"
//       // },

//       // Add all other technologies in similar fashion (e.g. Flutter, JavaScript, etc.)
//       // ...
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Free Resources'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: techResources.length,
//           itemBuilder: (context, index) {
//             final tech = techResources[index];
//             return _buildResourceCard(context, tech);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildResourceCard(BuildContext context, Map<String, String> tech) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 12.0),
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Image.network(
//                   tech["logo"]!,
//                   width: screenWidth * 0.1,
//                   height: screenWidth * 0.1,
//                   fit: BoxFit.contain,
//                 ),
//                 SizedBox(width: screenWidth * 0.05),
//                 Text(
//                   tech["name"]!,
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.06,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenWidth * 0.04),

//             // Website link
//             Text(
//               'Website:',
//               style: TextStyle(
//                 fontSize: screenWidth * 0.045,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Link(
//               uri: Uri.parse(tech["website"]!),
//               target: LinkTarget.blank,
//               builder: (context, followLink) => InkWell(
//                 onTap: followLink,
//                 child: Text(
//                   tech["website"]!,
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.04,
//                     color: Colors.blue,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: screenWidth * 0.04),

//             // Documentation link
//             Text(
//               'Docs:',
//               style: TextStyle(
//                 fontSize: screenWidth * 0.045,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Link(
//               uri: Uri.parse(tech["docs"]!),
//               target: LinkTarget.blank,
//               builder: (context, followLink) => InkWell(
//                 onTap: followLink,
//                 child: Text(
//                   tech["docs"]!,
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.04,
//                     color: Colors.blue,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: screenWidth * 0.04),

//             // YouTube channel link
//             Text(
//               'YouTube Channel:',
//               style: TextStyle(
//                 fontSize: screenWidth * 0.045,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Link(
//               uri: Uri.parse(tech["youtube"]!),
//               target: LinkTarget.blank,
//               builder: (context, followLink) => InkWell(
//                 onTap: followLink,
//                 child: Text(
//                   tech["youtube"]!,
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.04,
//                     color: Colors.blue,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: screenWidth * 0.05),

//             // Download Button (with comment for adding PDF logic)
//             ElevatedButton.icon(
//               onPressed: () => _downloadResource(),
//               icon: Icon(Icons.download),
//               label: Text('Download PDF'),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.1,
//                   vertical: screenWidth * 0.04,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// // ------------------------------------------------------------------------------------
// // import 'package:flutter/material.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // class ResourcesPage extends StatelessWidget {
// //   const ResourcesPage({Key? key}) : super(key: key);

// //   // Method to launch URLs with error handling
// //   Future<void> _launchUrl(String url) async {
// //     final Uri uri = Uri.parse(url);
// //     if (await canLaunchUrl(uri)) {
// //       await launchUrl(uri);
// //     } else {
// //       throw 'Could not launch $url';
// //     }
// //   }

// //   // Method to simulate downloading PDF (replace with your actual implementation)
// //   Future<void> _downloadResource() async {
// //     // Simulate downloading PDF
// //     throw 'Download functionality not implemented yet. Add your logic here.';
// //   }

// //   @override
// //   Widget build(BuildContext context) {
//     // final techResources = [
//     //   {
//     //     "logo": "https://img.icons8.com/color/48/000000/python.png",
//     //     "name": "Python",
//     //     "website": "https://www.python.org/",
//     //     "docs": "https://docs.python.org/3/",
//     //     "youtube": "https://www.youtube.com/channel/UCRl22PrjQBw0yTSgpFZ7W2Q"
//     //   },
//     //   {
//     //     "logo": "https://img.icons8.com/color/48/000000/java.png",
//     //     "name": "Java",
//     //     "website": "https://www.oracle.com/java/",
//     //     "docs": "https://docs.oracle.com/javase/8/docs/",
//     //     "youtube": "https://www.youtube.com/user/koushks"
//     //   },
//     //   {
//     //     "logo": "https://img.icons8.com/color/48/000000/javascript.png",
//     //     "name": "JavaScript",
//     //     "website": "https://developer.mozilla.org/en-US/docs/Web/JavaScript",
//     //     "docs": "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide",
//     //     "youtube": "https://www.youtube.com/c/TraversyMedia"
//     //   },
//     //   {
//     //     "logo": "https://img.icons8.com/color/48/000000/flutter.png",
//     //     "name": "Flutter",
//     //     "website": "https://flutter.dev/",
//     //     "docs": "https://flutter.dev/docs",
//     //     "youtube": "https://www.youtube.com/c/Flutter"
//     //   },
//     //   {
//     //     "logo": "https://img.icons8.com/color/48/000000/react-native.png",
//     //     "name": "React Native",
//     //     "website": "https://reactnative.dev/",
//     //     "docs": "https://reactnative.dev/docs/getting-started",
//     //     "youtube": "https://www.youtube.com/c/Academind"
//     //   },
//     //   {
//     //     "logo": "https://img.icons8.com/color/48/000000/c-programming.png",
//     //     "name": "C Programming",
//     //     "website": "https://devdocs.io/c/",
//     //     "docs": "https://www.learn-c.org/",
//     //     "youtube": "https://www.youtube.com/user/thenewboston"
//     //   },
//     //   {
//     //     "logo": "https://img.icons8.com/color/48/000000/html-5.png",
//     //     "name": "HTML5",
//     //     "website":
//     //         "https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/HTML5",
//     //     "docs": "https://developer.mozilla.org/en-US/docs/Web/HTML",
//     //     "youtube": "https://www.youtube.com/c/Freecodecamp"
//     //   },
//     //   {
//     //     "logo": "https://img.icons8.com/color/48/000000/css3.png",
//     //     "name": "CSS3",
//     //     "website": "https://developer.mozilla.org/en-US/docs/Web/CSS",
//     //     "docs": "https://developer.mozilla.org/en-US/docs/Web/CSS/CSS3",
//     //     "youtube": "https://www.youtube.com/c/DesignCourse"
//     //   },
//     //   {
//     //     "logo": "https://img.icons8.com/color/48/000000/nodejs.png",
//     //     "name": "Node.js",
//     //     "website": "https://nodejs.org/",
//     //     "docs": "https://nodejs.org/en/docs/",
//     //     "youtube": "https://www.youtube.com/c/Codevolution"
//     //   },
//     //   {
//     //     "logo": "https://img.icons8.com/color/48/000000/mongodb.png",
//     //     "name": "MongoDB",
//     //     "website": "https://www.mongodb.com/",
//     //     "docs": "https://docs.mongodb.com/",
//     //     "youtube": "https://www.youtube.com/c/MongoDBOfficial"
//     //   }

//     //   // Add all other technologies in similar fashion (e.g. Flutter, JavaScript, etc.)
//     //   // ...
//     // ];

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Free Resources'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: ListView.builder(
// //           itemCount: techResources.length,
// //           itemBuilder: (context, index) {
// //             final tech = techResources[index];
// //             return _buildResourceCard(context, tech);
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildResourceCard(BuildContext context, Map<String, String> tech) {
// //     final screenWidth = MediaQuery.of(context).size.width;

// //     return Card(
// //       margin: const EdgeInsets.symmetric(vertical: 12.0),
// //       elevation: 4,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(15),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               children: [
// //                 Image.network(
// //                   tech["logo"]!,
// //                   width: screenWidth * 0.1,
// //                   height: screenWidth * 0.1,
// //                   fit: BoxFit.contain,
// //                 ),
// //                 SizedBox(width: screenWidth * 0.05),
// //                 Text(
// //                   tech["name"]!,
// //                   style: TextStyle(
// //                     fontSize: screenWidth * 0.06,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: screenWidth * 0.04),

// //             // Website link
// //             Text(
// //               'Website:',
// //               style: TextStyle(
// //                 fontSize: screenWidth * 0.045,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //             InkWell(
// //               onTap: () => _launchUrl(tech["website"]!),
// //               child: Text(
// //                 tech["website"]!,
// //                 style: TextStyle(
// //                   fontSize: screenWidth * 0.04,
// //                   color: Colors.blue,
// //                   decoration: TextDecoration.underline,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: screenWidth * 0.04),

// //             // Documentation link
// //             Text(
// //               'Docs:',
// //               style: TextStyle(
// //                 fontSize: screenWidth * 0.045,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //             InkWell(
// //               onTap: () => _launchUrl(tech["docs"]!),
// //               child: Text(
// //                 tech["docs"]!,
// //                 style: TextStyle(
// //                   fontSize: screenWidth * 0.04,
// //                   color: Colors.blue,
// //                   decoration: TextDecoration.underline,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: screenWidth * 0.04),

// //             // YouTube channel link
// //             Text(
// //               'YouTube Channel:',
// //               style: TextStyle(
// //                 fontSize: screenWidth * 0.045,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //             InkWell(
// //               onTap: () => _launchUrl(tech["youtube"]!),
// //               child: Text(
// //                 tech["youtube"]!,
// //                 style: TextStyle(
// //                   fontSize: screenWidth * 0.04,
// //                   color: Colors.blue,
// //                   decoration: TextDecoration.underline,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: screenWidth * 0.05),

// //             // Download Button (with comment for adding PDF logic)
// //             ElevatedButton.icon(
// //               onPressed: () => _downloadResource(),
// //               icon: Icon(Icons.download),
// //               label: Text('Download PDF'),
// //               style: ElevatedButton.styleFrom(
// //                 padding: EdgeInsets.symmetric(
// //                   horizontal: screenWidth * 0.1,
// //                   vertical: screenWidth * 0.04,
// //                 ),
// //               ),
// //             ),

// //             // Example for adding actual file (commented):
// //             // ElevatedButton.icon(
// //             //   onPressed: () {
// //             //     // TODO: Implement actual PDF file download logic
// //             //   },
// //             //   icon: Icon(Icons.download),
// //             //   label: Text('Download Resource'),
// //             // ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({Key? key}) : super(key: key);

  // Method to launch URLs with error handling
  Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  // Method to show error dialog when URL cannot be launched
  void _showErrorDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Could not launch $url.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  // Method to simulate downloading PDF (replace with your actual implementation)
  Future<void> _downloadResource() async {
    // Simulate downloading PDF
    throw 'Download functionality not implemented yet. Add your logic here.';
  }

  @override
  Widget build(BuildContext context) {
    final techResources = [
      {
        "logo": "https://img.icons8.com/color/48/000000/python.png",
        "name": "Python",
        "website": "https://www.python.org/",
        "docs": "https://docs.python.org/3/",
        "youtube": "https://www.youtube.com/channel/UCRl22PrjQBw0yTSgpFZ7W2Q"
      },
      {
        "logo": "https://img.icons8.com/color/48/000000/javascript.png",
        "name": "JavaScript",
        "website": "https://developer.mozilla.org/en-US/docs/Web/JavaScript",
        "docs": "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide",
        "youtube": "https://www.youtube.com/c/TraversyMedia"
      },
      {
        "logo": "https://img.icons8.com/color/48/000000/flutter.png",
        "name": "Flutter",
        "website": "https://flutter.dev/",
        "docs": "https://flutter.dev/docs",
        "youtube": "https://www.youtube.com/c/Flutter"
      },
      // Add other resources as needed...
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Free Resources'),
      //   backgroundColor: Colors.blue[300],
      //    // AppBar color set to blue[300]
      //   iconTheme: IconThemeData(color: Colors.white), // White color for icons
      //   actionsIconTheme: IconThemeData(color: Colors.white), // Ensure icons in the actions area are white too
      // ),
      appBar: AppBar(
  title: Text(
    'Free Resources',
    style: TextStyle(
      color: Colors.white, // White text color
      fontSize: 24, // Adjust font size to make the title larger
      fontWeight: FontWeight.bold, // Optional: Make the title bold
    ),
  ),
  backgroundColor: const Color.fromARGB(255, 20, 46, 179), // AppBar color set to blue[300]
  iconTheme: IconThemeData(color: Colors.white), // White color for icons in the AppBar
  actionsIconTheme: IconThemeData(color: Colors.white), // Ensure icons in the actions area are white
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: techResources.length,
          itemBuilder: (context, index) {
            final tech = techResources[index];
            return _buildResourceCard(context, tech);
          },
        ),
      ),
    );
  }

  Widget _buildResourceCard(BuildContext context, Map<String, String> tech) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: const Color.fromARGB(255, 18, 64, 215), width: 2), // Blue border
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  tech["logo"]!,
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: screenWidth * 0.05),
                Text(
                  tech["name"]!,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.04),

            // Website link
            Text(
              'Website:',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            Link(
              uri: Uri.parse(tech["website"]!),
              target: LinkTarget.blank,
              builder: (context, followLink) => InkWell(
                onTap: followLink,
                child: Text(
                  tech["website"]!,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.04),

            // Documentation link
            Text(
              'Docs:',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            Link(
              uri: Uri.parse(tech["docs"]!),
              target: LinkTarget.blank,
              builder: (context, followLink) => InkWell(
                onTap: followLink,
                child: Text(
                  tech["docs"]!,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.04),

            // YouTube channel link
            Text(
              'YouTube Channel:',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            Link(
              uri: Uri.parse(tech["youtube"]!),
              target: LinkTarget.blank,
              builder: (context, followLink) => InkWell(
                onTap: followLink,
                child: Text(
                  tech["youtube"]!,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.05),

            // Download Button (with comment for adding PDF logic)
            ElevatedButton.icon(
              onPressed: () => _downloadResource(),
              icon: Icon(Icons.download),
              label: Text('Download PDF'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
