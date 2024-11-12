// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class AppDevRoadmap extends StatelessWidget {
//   final String imageUrl = 'assets/images/appdev_roadmap.jpg'; // Ensure this path is correct

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('App Development Roadmap'),
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
//               'App Development Roadmap',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             SizedBox(height: 10),
//             GestureDetector(
//               onTap: () => _showImage(context, imageUrl),
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
//                     imageUrl,
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Introduction to App Development',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurpleAccent,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'App development refers to creating software applications for mobile devices such as smartphones and tablets. '
//               'This can involve native development or cross-platform frameworks.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Usage in Tech Industry',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurpleAccent,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'App developers are in high demand as the mobile application market continues to grow. '
//               'They play a critical role in creating the tools and services that users interact with daily.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Free Resources to Learn App Development',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             SizedBox(height: 10),
//             InkWell(
//               child: Text(
//                 '1. Flutter Documentation: https://flutter.dev/docs',
//                 style: TextStyle(color: Colors.blue, fontSize: 16),
//               ),
//               onTap: () => _launchUrl('https://flutter.dev/docs'),
//             ),
//             SizedBox(height: 10),
//             InkWell(
//               child: Text(
//                 '2. Android Developers: https://developer.android.com/',
//                 style: TextStyle(color: Colors.blue, fontSize: 16),
//               ),
//               onTap: () => _launchUrl('https://developer.android.com/'),
//             ),
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

class AppDevRoadmap extends StatelessWidget {
  final String imageUrl = 'assets/images/appdev_roadmap.jpg'; // Ensure this path is correct

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Development Roadmap',
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
              'App Development Roadmap',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue title color
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => _showImage(context, imageUrl),
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
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Introduction to App Development',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue text color
              ),
            ),
            SizedBox(height: 10),
            Text(
              'App development refers to creating software applications for mobile devices such as smartphones and tablets. '
              'This can involve native development or cross-platform frameworks.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Usage in Tech Industry',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue text color
              ),
            ),
            SizedBox(height: 10),
            Text(
              'App developers are in high demand as the mobile application market continues to grow. '
              'They play a critical role in creating the tools and services that users interact with daily.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Free Resources to Learn App Development',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue text color
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                '1. Flutter Documentation: https://flutter.dev/docs',
                style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
              ),
              onTap: () => _launchUrl('https://flutter.dev/docs'),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                '2. Android Developers: https://developer.android.com/',
                style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
              ),
              onTap: () => _launchUrl('https://developer.android.com/'),
            ),
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
