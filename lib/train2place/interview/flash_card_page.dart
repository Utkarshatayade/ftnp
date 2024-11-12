import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart'; // For progress tracking visualization

class FlashcardPage extends StatefulWidget {
  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  List<Map<String, dynamic>> flashcards = [
    {
      'question': 'What is a Binary Search Algorithm?',
      'answer': 'A search algorithm that finds the position of a target value within a sorted array.',
      'category': 'Algorithms',
      'known': false,
    },
    {
      'question': 'What are the four pillars of OOP?',
      'answer': 'Encapsulation, Inheritance, Polymorphism, and Abstraction.',
      'category': 'Object-Oriented Programming',
      'known': false,
    },
    {
      'question': 'Explain ACID properties in a database.',
      'answer': 'Atomicity, Consistency, Isolation, Durability.',
      'category': 'Databases',
      'known': false,
    },
    // Add more flashcards here...
  ];

  int currentIndex = 0;
  String selectedCategory = 'All';
  int knownCount = 0;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredFlashcards = flashcards
        .where((flashcard) =>
            selectedCategory == 'All' || flashcard['category'] == selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards for Quick Revision'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: _filterByCategory,
          ),
        ],
      ),
      body: filteredFlashcards.isNotEmpty
          ? Column(
              children: [
                SizedBox(height: 20),
                _buildProgressIndicator(),
                SizedBox(height: 20),
                _buildFlashcard(filteredFlashcards[currentIndex]),
                SizedBox(height: 20),
                _buildKnownUnknownButtons(filteredFlashcards[currentIndex]),
              ],
            )
          : Center(child: Text('No flashcards available in this category')),
    );
  }

  Widget _buildProgressIndicator() {
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width * 0.8,
      lineHeight: 20.0,
      percent: knownCount / flashcards.length,
      center: Text("${(knownCount / flashcards.length * 100).toStringAsFixed(1)}%"),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.green,
      backgroundColor: Colors.grey[300],
    );
  }

  Widget _buildFlashcard(Map<String, dynamic> flashcard) {
    return Expanded(
      child: Card(
        elevation: 8,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                flashcard['question'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showAnswer(flashcard['answer']);
                },
                child: Text('Show Answer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKnownUnknownButtons(Map<String, dynamic> flashcard) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.check_circle, color: Colors.green),
          label: Text('Mark as Known'),
          onPressed: () {
            setState(() {
              flashcard['known'] = true;
              knownCount++;
              _nextFlashcard();
            });
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.cancel, color: Colors.red),
          label: Text('Need Revision'),
          onPressed: () {
            setState(() {
              flashcard['known'] = false;
              _nextFlashcard();
            });
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    );
  }

  void _showAnswer(String answer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Answer'),
          content: Text(answer),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _nextFlashcard() {
    setState(() {
      if (currentIndex < flashcards.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0; // Restart from the beginning
      }
    });
  }

  void _filterByCategory() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Filter by Category'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedCategory = 'All';
                  Navigator.pop(context);
                });
              },
              child: Text('All'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedCategory = 'Algorithms';
                  Navigator.pop(context);
                });
              },
              child: Text('Algorithms'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedCategory = 'Object-Oriented Programming';
                  Navigator.pop(context);
                });
              },
              child: Text('Object-Oriented Programming'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedCategory = 'Databases';
                  Navigator.pop(context);
                });
              },
              child: Text('Databases'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedCategory = 'Operating Systems';
                  Navigator.pop(context);
                });
              },
              child: Text('Operating Systems'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedCategory = 'Networking';
                  Navigator.pop(context);
                });
              },
              child: Text('Networking'),
            ),
          ],
        );
      },
    );
  }
}
