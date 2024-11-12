import 'package:flutter/material.dart';

import 'behavioural.dart';
import 'flash_card_page.dart';
import 'technical.dart';

class PreparationLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Interview Preparation Hub'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionCard(
              context,
              'Flashcards for Quick Revision',
              'Revise key technical concepts and definitions before interviews.',
              'assets/images/flashcards.png', // Replace with your asset image for flashcards
              Colors.deepOrangeAccent,
              FlashcardPage(),
            ),
            SizedBox(height: 20),
            _buildSectionCard(
              context,
              'Technical Interview Kits',
              'Download company-specific interview kits to crack interviews at Google, Amazon, Microsoft, and more.',
              'assets/images/technical_kits.png', // Replace with your asset image for technical kits
              Colors.blueAccent,
              TechnicalInterviewKitsPage(),
            ),
            SizedBox(height: 20),
            _buildSectionCard(
              context,
              'Behavioral Interview Guide',
              'Prepare for HR interviews with common questions, tips, and scenario-based answers.',
              'assets/images/behavioral_guide.png', // Replace with your asset image for behavioral guide
              Colors.greenAccent,
              BehavioralInterviewGuide(),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build each section card
  Widget _buildSectionCard(BuildContext context, String title, String subtitle,
      String imagePath, Color color, Widget nextPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // Image for the card
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16),
              // Flexible widget to adapt to screen width
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
