import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp/student/student_homepage.dart';

class QuizAdder extends StatefulWidget {
  @override
  _QuizAdderState createState() => _QuizAdderState();
}

class _QuizAdderState extends State<QuizAdder> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> quizTemplate = [];
  int numberOfQuestions = 5; // Admin-defined number of questions
  int quizDuration = 60; // Admin-defined duration in seconds
  bool isLoading = false;

  // Added title field for the quiz
  TextEditingController quizTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeTemplate();
  }

  @override
  void dispose() {
    // Clean up the controllers
    quizTitleController.dispose();
    for (var question in quizTemplate) {
      question['question'].dispose();
      for (var option in question['options']) {
        option.dispose();
      }
    }
    super.dispose();
  }

  void initializeTemplate() {
    quizTemplate = List.generate(numberOfQuestions, (index) {
      return {
        'question': TextEditingController(),
        'options': List.generate(4, (_) => TextEditingController()),
        'correctAnswer': '',
        'category': 'General',
      };
    });
  }

  // Save the quiz data to Firestore with error handling
  Future<void> saveQuiz() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Map<String, dynamic>> quizData = quizTemplate.map((questionData) {
        return {
          'question': questionData['question'].text,
          'options': questionData['options']
              .map((controller) => controller.text)
              .toList(),
          'correctAnswer': questionData['correctAnswer'],
          'category': 'General',
        };
      }).toList();

      // Create a document with quiz title and duration
      await FirebaseFirestore.instance
          .collection('quizzes')
          .doc(quizTitleController.text)
          .set({
        'quizTitle': quizTitleController.text,
        'duration': quizDuration,
        'questions': quizData, // Store the questions as a subcollection
      });

      if (mounted) {
        // Check if the widget is still mounted
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quiz added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        // Check if the widget is still mounted
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding quiz: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Collapsible section for Title, Number of Questions, and Duration
              ExpansionTile(
                title: Text('Quiz Details'),
                children: [
                  // New TextField for Quiz Title
                  TextFormField(
                    controller: quizTitleController,
                    decoration: InputDecoration(labelText: 'Quiz Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a quiz title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Admin can set the number of questions
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Number of Questions'),
                    initialValue: numberOfQuestions.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        numberOfQuestions = int.parse(value);
                        initializeTemplate();
                      });
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Admin can set the quiz duration
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Quiz Duration (seconds)'),
                    initialValue: quizDuration.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        quizDuration = int.parse(value);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              isLoading
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: quizTemplate.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  // Question field with controller
                                  TextFormField(
                                    controller: quizTemplate[index]['question'],
                                    decoration: InputDecoration(
                                        labelText: 'Question ${index + 1}'),
                                  ),
                                  ...List.generate(4, (optionIndex) {
                                    // Options fields with controllers
                                    return TextFormField(
                                      controller: quizTemplate[index]['options']
                                          [optionIndex],
                                      decoration: InputDecoration(
                                          labelText:
                                              'Option ${optionIndex + 1}'),
                                    );
                                  }),
                                  // Index-based correct answer selection
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText:
                                            'Correct Option (Enter 1-4)'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      int correctIndex = int.parse(value) - 1;
                                      if (correctIndex >= 0 &&
                                          correctIndex < 4) {
                                        quizTemplate[index]['correctAnswer'] =
                                            quizTemplate[index]['options']
                                                    [correctIndex]
                                                .text;
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Please enter a valid option number (1-4).')),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveQuiz();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentHomePage()));
                  }
                },
                child: Text('Save Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// -------------------------------------------------------------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:train2place/home_page.dart';

// class QuizAdder extends StatefulWidget {
//   @override
//   _QuizAdderState createState() => _QuizAdderState();
// }

// class _QuizAdderState extends State<QuizAdder> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _quizTitleController = TextEditingController();
//   List<Map<String, dynamic>> quizTemplate = [];
//   int numberOfQuestions = 5; // Admin-defined number of questions
//   int quizDuration = 60; // Admin-defined duration in seconds
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     initializeTemplate();
//   }

//   // Initialize quiz template with empty fields and controllers for each question
//   void initializeTemplate() {
//     quizTemplate = List.generate(numberOfQuestions, (index) {
//       return {
//         'question': TextEditingController(),
//         'options': List.generate(4, (_) => TextEditingController()),
//         'correctAnswer': '',
//         'category': 'General',
//       };
//     });
//   }

//   // Save the quiz data to Firestore under the quiz title with error handling
//   Future<void> saveQuiz() async {
//     if (_quizTitleController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enter a quiz title.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       List<Map<String, dynamic>> quizData = quizTemplate.map((questionData) {
//         return {
//           'question': questionData['question'].text,
//           'options': questionData['options']
//               .map((controller) => controller.text)
//               .toList(),
//           'correctAnswer': questionData['correctAnswer'],
//           'category': 'General',
//         };
//       }).toList();

//       // Store quiz data under a document named after the quiz title
//       DocumentReference quizRef = FirebaseFirestore.instance
//           .collection('quizzes')
//           .doc(_quizTitleController.text);

//       // Store questions as a sub-collection
//       for (var questionData in quizData) {
//         await quizRef.collection('questions').add(questionData);
//       }

//       // Save quiz metadata (like duration) to the quiz document
//       await quizRef.set({'duration': quizDuration});

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Quiz added successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error adding quiz: $error'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenHeight = mediaQuery.size.height;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Quiz'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Quiz title input field
//               TextFormField(
//                 controller: _quizTitleController,
//                 decoration: InputDecoration(labelText: 'Quiz Title'),
//               ),
//               SizedBox(height: screenHeight * 0.02),

//               // Number of questions and quiz duration input fields
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Number of Questions'),
//                 initialValue: numberOfQuestions.toString(),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     numberOfQuestions = int.parse(value);
//                     initializeTemplate();
//                   });
//                 },
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               TextFormField(
//                 decoration:
//                     InputDecoration(labelText: 'Quiz Duration (seconds)'),
//                 initialValue: quizDuration.toString(),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     quizDuration = int.parse(value);
//                   });
//                 },
//               ),
//               SizedBox(height: screenHeight * 0.02),

//               // Question inputs
//               isLoading
//                   ? CircularProgressIndicator()
//                   : Expanded(
//                       child: ListView.builder(
//                         itemCount: quizTemplate.length,
//                         itemBuilder: (context, index) {
//                           return Card(
//                             margin: EdgeInsets.all(10),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   TextFormField(
//                                     controller: quizTemplate[index]['question'],
//                                     decoration: InputDecoration(
//                                         labelText: 'Question ${index + 1}'),
//                                   ),
//                                   ...List.generate(4, (optionIndex) {
//                                     return TextFormField(
//                                       controller: quizTemplate[index]['options']
//                                           [optionIndex],
//                                       decoration: InputDecoration(
//                                           labelText:
//                                               'Option ${optionIndex + 1}'),
//                                     );
//                                   }),
//                                   TextFormField(
//                                     decoration: InputDecoration(
//                                         labelText:
//                                             'Correct Option (Enter 1-4)'),
//                                     keyboardType: TextInputType.number,
//                                     onChanged: (value) {
//                                       int correctIndex = int.parse(value) - 1;
//                                       if (correctIndex >= 0 &&
//                                           correctIndex < 4) {
//                                         quizTemplate[index]['correctAnswer'] =
//                                             quizTemplate[index]['options']
//                                                     [correctIndex]
//                                                 .text;
//                                       } else {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                               content: Text(
//                                                   'Please enter a valid option number (1-4).')),
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//               SizedBox(height: screenHeight * 0.02),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     saveQuiz();
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) => HomePage()));
//                   }
//                 },
//                 child: Text('Save Quiz'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
