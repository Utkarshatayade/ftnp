// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class BlockchainRoadmap extends StatelessWidget {
//   final String imageUrl = 'assets/images/blockchain_roadmap.jpg'; // Ensure this path is correct

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Blockchain Development Roadmap'),
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
//               'Blockchain Development Roadmap',
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
//               'Introduction to Blockchain Development',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurpleAccent,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Blockchain development involves creating decentralized applications using blockchain technologies like Ethereum, Bitcoin, or Hyperledger.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Usage in Tech Industry',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurpleAccent,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Blockchain technology is being used in various industries such as finance, supply chain management, and healthcare to ensure secure and transparent transactions.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Free Resources to Learn Blockchain Development',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             SizedBox(height: 10),
//             InkWell(
//               child: Text(
//                 '1. Solidity Docs: https://soliditylang.org/',
//                 style: TextStyle(color: Colors.blue, fontSize: 16),
//               ),
//               onTap: () => _launchUrl('https://soliditylang.org/'),
//             ),
//             SizedBox(height: 5),
//             InkWell(
//               child: Text(
//                 '2. Ethereum Developer Guide: https://ethereum.org/en/developers/',
//                 style: TextStyle(color: Colors.blue, fontSize: 16),
//               ),
//               onTap: () => _launchUrl('https://ethereum.org/en/developers/'),
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

class BlockchainRoadmap extends StatelessWidget {
  final String imageUrl = 'assets/images/blockchain_roadmap.jpg'; // Ensure this path is correct

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blockchain Development Roadmap',
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
              'Blockchain Development Roadmap',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue title color
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Blockchain development involves creating decentralized applications using blockchain technologies like Ethereum, Bitcoin, or Hyperledger.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Blockchain Image Section
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
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Blockchain Development Section
            Text(
              'Introduction to Blockchain Development',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800], // Lighter blue for subheading
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Blockchain development involves creating decentralized applications using blockchain technologies like Ethereum, Bitcoin, or Hyperledger.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Usage in Tech Industry Section
            Text(
              'Usage in Tech Industry',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800], // Lighter blue for subheading
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Blockchain technology is being used in various industries such as finance, supply chain management, and healthcare to ensure secure and transparent transactions.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Free Resources Section
            Text(
              'Free Resources to Learn Blockchain Development',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue text color
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                '1. Solidity Docs: https://soliditylang.org/',
                style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
              ),
              onTap: () => _launchUrl('https://soliditylang.org/'),
            ),
            SizedBox(height: 5),
            InkWell(
              child: Text(
                '2. Ethereum Developer Guide: https://ethereum.org/en/developers/',
                style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
              ),
              onTap: () => _launchUrl('https://ethereum.org/en/developers/'),
            ),
            SizedBox(height: 5),
            InkWell(
              child: Text(
                '3. Blockchain at Berkeley: https://blockchain.berkeley.edu/',
                style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
              ),
              onTap: () => _launchUrl('https://blockchain.berkeley.edu/'),
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
