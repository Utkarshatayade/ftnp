// import 'package:flutter/material.dart';
// import 'webdev_roadmap.dart'; // Import roadmap pages
// import 'appdev_roadmap.dart';
// import 'blockchain_roadmap.dart';

// class RoadmapPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Get device height and width
//     final deviceHeight = MediaQuery.of(context).size.height;
//     final deviceWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(deviceWidth * 0.05), // 5% of device width
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _titleSection(deviceWidth),
//               SizedBox(height: deviceHeight * 0.02), // 2% of device height
//               _infoSection(deviceWidth),
//               SizedBox(height: deviceHeight * 0.02),
//               _roadmapCard(
//                 context,
//                 "Web Development",
//                 "assets/images/webdev.jpg", // Ensure you add images to assets
//                 "Explore the world of Web Development with modern tools and frameworks. Build fast, responsive websites.",
//                 WebDevRoadmap(),
//                 deviceHeight,
//                 deviceWidth,
//               ),
//               SizedBox(height: deviceHeight * 0.02),
//               _roadmapCard(
//                 context,
//                 "App Development",
//                 "assets/images/appdev.jpg",
//                 "Learn how to build mobile applications using Flutter and native tools.",
//                 AppDevRoadmap(),
//                 deviceHeight,
//                 deviceWidth,
//               ),
//               SizedBox(height: deviceHeight * 0.02),
//               _roadmapCard(
//                 context,
//                 "Blockchain",
//                 "assets/images/blockchain.jpg",
//                 "Delve into the exciting world of decentralized technologies with Blockchain development.",
//                 BlockchainRoadmap(),
//                 deviceHeight,
//                 deviceWidth,
//               ),
//               SizedBox(height: deviceHeight * 0.03),
//               _footerSection(deviceWidth),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Title Section
//   Widget _titleSection(double deviceWidth) {
//     return Text(
//       "Welcome to Roadmaps",
//       style: TextStyle(
//         fontSize: deviceWidth * 0.07, // Responsive font size
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   // Info Section
//   Widget _infoSection(double deviceWidth) {
//     return Text(
//       "Why follow roadmaps?\n"
//       "Learning through structured roadmaps helps you stay on track and ensures "
//       "you cover all necessary concepts. Each roadmap provides well-curated resources "
//       "to guide you on your learning path.",
//       style: TextStyle(
//         fontSize: deviceWidth * 0.04, // Responsive font size
//       ),
//     );
//   }

//   // Roadmap Card Template
//   Widget _roadmapCard(BuildContext context, String title, String imagePath, String description, Widget page, double deviceHeight, double deviceWidth) {
//     return Card(
//       elevation: 4,
//       child: Column(
//         children: [
//           Image.asset(
//             imagePath,
//             width: double.infinity,
//             height: deviceHeight * 0.2, // 20% of device height
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: EdgeInsets.all(deviceWidth * 0.04), // 4% of device width
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: deviceWidth * 0.05, // Responsive font size
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: deviceHeight * 0.01), // 1% of device height
//                 Text(
//                   description,
//                   style: TextStyle(
//                     fontSize: deviceWidth * 0.04, // Responsive font size
//                   ),
//                 ),
//                 SizedBox(height: deviceHeight * 0.01), // 1% of device height
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => page),
//                         );
//                       },
//                       child: Row(
//                         children: [
//                           Text("Know More"),
//                           Icon(Icons.arrow_forward),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Footer Section
//   Widget _footerSection(double deviceWidth) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Divider(thickness: 2),
//         SizedBox(height: 10),
//         Text(
//           "Contact Information",
//           style: TextStyle(
//             fontSize: deviceWidth * 0.05, // Responsive font size
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 10),
//         Text("Email: info@train2place.com"),
//         Text("Phone: +123 456 7890"),
//         SizedBox(height: 20),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'webdev_roadmap.dart'; // Import roadmap pages
import 'appdev_roadmap.dart';
import 'blockchain_roadmap.dart';

class RoadmapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get device height and width
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(color: Colors.white)), // White title
        backgroundColor: Colors.blue[900], // Blue AppBar color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(deviceWidth * 0.05), // 5% of device width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleSection(deviceWidth),
              SizedBox(height: deviceHeight * 0.02), // 2% of device height
              _infoSection(deviceWidth),
              SizedBox(height: deviceHeight * 0.02),
              _roadmapCard(
                context,
                "Web Development",
                "assets/images/webdev.jpg", // Ensure you add images to assets
                "Explore the world of Web Development with modern tools and frameworks. Build fast, responsive websites.",
                WebDevRoadmap(),
                deviceHeight,
                deviceWidth,
              ),
              SizedBox(height: deviceHeight * 0.02),
              _roadmapCard(
                context,
                "App Development",
                "assets/images/appdev.jpg",
                "Learn how to build mobile applications using Flutter and native tools.",
                AppDevRoadmap(),
                deviceHeight,
                deviceWidth,
              ),
              SizedBox(height: deviceHeight * 0.02),
              _roadmapCard(
                context,
                "Blockchain",
                "assets/images/blockchain.jpg",
                "Delve into the exciting world of decentralized technologies with Blockchain development.",
                BlockchainRoadmap(),
                deviceHeight,
                deviceWidth,
              ),
              SizedBox(height: deviceHeight * 0.03),
              _footerSection(deviceWidth),
            ],
          ),
        ),
      ),
    );
  }

  // Title Section
  Widget _titleSection(double deviceWidth) {
    return Text(
      "Welcome to Roadmaps",
      style: TextStyle(
        fontSize: deviceWidth * 0.07, // Responsive font size
        fontWeight: FontWeight.bold,
        color: Colors.blue[900], // Blue title color
      ),
    );
  }

  // Info Section
  Widget _infoSection(double deviceWidth) {
    return Text(
      "Why follow roadmaps?\n"
      "Learning through structured roadmaps helps you stay on track and ensures "
      "you cover all necessary concepts. Each roadmap provides well-curated resources "
      "to guide you on your learning path.",
      style: TextStyle(
        fontSize: deviceWidth * 0.04, // Responsive font size
        color: Colors.blue[700], // Dark blue text color
      ),
    );
  }

  // Roadmap Card Template
  Widget _roadmapCard(BuildContext context, String title, String imagePath, String description, Widget page, double deviceHeight, double deviceWidth) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners for card
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: deviceHeight * 0.2, // 20% of device height
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(deviceWidth * 0.04), // 4% of device width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: deviceWidth * 0.05, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900], // Blue title color
                  ),
                ),
                SizedBox(height: deviceHeight * 0.01), // 1% of device height
                Text(
                  description,
                  style: TextStyle(
                    fontSize: deviceWidth * 0.04, // Responsive font size
                    color: Colors.blue[800], // Dark blue text
                  ),
                ),
                SizedBox(height: deviceHeight * 0.01), // 1% of device height
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => page),
                        );
                      },
                      child: Row(
                        children: [
                          Text("Know More", style: TextStyle(color: Colors.blue[800])), // Blue text for button
                          Icon(Icons.arrow_forward, color: Colors.blue[800]), // Blue arrow
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Footer Section
  Widget _footerSection(double deviceWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Divider(thickness: 2),
        SizedBox(height: 10),
        Text(
          "Contact Information",
          style: TextStyle(
            fontSize: deviceWidth * 0.05, // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.blue[900], // Blue title color
          ),
        ),
        SizedBox(height: 10),
        Text("Email: info@train2place.com", style: TextStyle(color: Colors.blue[700])),
        Text("Phone: +123 456 7890", style: TextStyle(color: Colors.blue[700])),
        SizedBox(height: 20),
      ],
    );
  }
}
