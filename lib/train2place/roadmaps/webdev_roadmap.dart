// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class WebDevRoadmap extends StatelessWidget {
//   final List<String> imageUrls = [
//     'assets/images/frontend_roadmap.jpg',
//     'assets/images/backend_roadmap.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Web Development Roadmap'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Go back to the previous page
//           },
//         ),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Web Development Roadmap',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Web development is the work involved in developing a website for the Internet or an intranet. '
//               'It can range from developing a simple single static page to complex web applications.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             // Frontend Roadmap Section
//             Text(
//               'Frontend Development',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurpleAccent,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Frontend development refers to the creation of the user interface (UI) and everything the user interacts with on the web. '
//               'It includes the structure, design, behavior, and content of everything that is visible in a web browser.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             // Frontend Image
//             GestureDetector(
//               onTap: () => _showImage(context, imageUrls[0]),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.deepPurpleAccent.withOpacity(0.3),
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: Image.asset(
//                     imageUrls[0],
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             // Backend Roadmap Section
//             Text(
//               'Backend Development',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurpleAccent,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Backend development is about creating the server-side of web applications, focusing on databases, scripting, and the architecture of the website. '
//               'It ensures that the frontend works as intended by managing the logic, databases, and server configurations.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             // Backend Image
//             GestureDetector(
//               onTap: () => _showImage(context, imageUrls[1]),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.deepPurpleAccent.withOpacity(0.3),
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: Image.asset(
//                     imageUrls[1],
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             // Free Resources Section
//             Text(
//               'Free Resources to Learn Web Development',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             SizedBox(height: 10),
//             InkWell(
//               child: Text(
//                 '1. FreeCodeCamp: https://www.freecodecamp.org/',
//                 style: TextStyle(color: Colors.blue, fontSize: 16),
//               ),
//               onTap: () => _launchUrl('https://www.freecodecamp.org/'),
//             ),
//             InkWell(
//               child: Text(
//                 '2. MDN Web Docs: https://developer.mozilla.org/en-US/',
//                 style: TextStyle(color: Colors.blue, fontSize: 16),
//               ),
//               onTap: () => _launchUrl('https://developer.mozilla.org/en-US/'),
//             ),
//             InkWell(
//               child: Text(
//                 '3. W3Schools: https://www.w3schools.com/',
//                 style: TextStyle(color: Colors.blue, fontSize: 16),
//               ),
//               onTap: () => _launchUrl('https://www.w3schools.com/'),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   // Method to handle launching URLs
//   Future<void> _launchUrl(String url) async {
//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   // Method to show image in a full-screen view with zoom capabilities
//   void _showImage(BuildContext context, String imageUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PhotoViewGalleryScreen(imageUrl: imageUrl),
//       ),
//     );
//   }
// }

// class PhotoViewGalleryScreen extends StatelessWidget {
//   final String imageUrl;

//   PhotoViewGalleryScreen({required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image View'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: PhotoViewGallery(
//         pageOptions: [
//           PhotoViewGalleryPageOptions(
//             imageProvider: AssetImage(imageUrl),
//             minScale: PhotoViewComputedScale.contained,
//             maxScale: PhotoViewComputedScale.covered * 2,
//           ),
//         ],
//         scrollPhysics: BouncingScrollPhysics(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class WebDevRoadmap extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/frontend_roadmap.jpg',
    'assets/images/backend_roadmap.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Web Development Roadmap',
          style: TextStyle(color: Colors.white), // White title color
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        backgroundColor: Colors.blue[900], // Blue AppBar color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Web Development Roadmap',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue title color
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Web development is the work involved in developing a website for the Internet or an intranet. '
              'It can range from developing a simple single static page to complex web applications.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Frontend Roadmap Section
            Text(
              'Frontend Development',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800], // Blue text color
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Frontend development refers to the creation of the user interface (UI) and everything the user interacts with on the web. '
              'It includes the structure, design, behavior, and content of everything that is visible in a web browser.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Frontend Image
            GestureDetector(
              onTap: () => _showImage(context, imageUrls[0]),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue[900]!.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imageUrls[0],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Backend Roadmap Section
            Text(
              'Backend Development',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800], // Blue text color
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Backend development is about creating the server-side of web applications, focusing on databases, scripting, and the architecture of the website. '
              'It ensures that the frontend works as intended by managing the logic, databases, and server configurations.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Backend Image
            GestureDetector(
              onTap: () => _showImage(context, imageUrls[1]),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue[900]!.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imageUrls[1],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Free Resources Section
            Text(
              'Free Resources to Learn Web Development',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue text color
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                '1. FreeCodeCamp: https://www.freecodecamp.org/',
                style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
              ),
              onTap: () => _launchUrl('https://www.freecodecamp.org/'),
            ),
            InkWell(
              child: Text(
                '2. MDN Web Docs: https://developer.mozilla.org/en-US/',
                style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
              ),
              onTap: () => _launchUrl('https://developer.mozilla.org/en-US/'),
            ),
            InkWell(
              child: Text(
                '3. W3Schools: https://www.w3schools.com/',
                style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
              ),
              onTap: () => _launchUrl('https://www.w3schools.com/'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Method to handle launching URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Method to show image in a full-screen view with zoom capabilities
  void _showImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewGalleryScreen(imageUrl: imageUrl),
      ),
    );
  }
}

class PhotoViewGalleryScreen extends StatelessWidget {
  final String imageUrl;

  PhotoViewGalleryScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image View', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900], // Blue AppBar color
      ),
      body: PhotoViewGallery(
        pageOptions: [
          PhotoViewGalleryPageOptions(
            imageProvider: AssetImage(imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ],
        scrollPhysics: BouncingScrollPhysics(),
      ),
    );
  }
}
