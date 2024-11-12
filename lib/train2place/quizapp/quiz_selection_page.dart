// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';
// import 'package:train2place/home_page.dart';

// class QuizSelectionPage extends StatefulWidget {
//   @override
//   _QuizSelectionPageState createState() => _QuizSelectionPageState();
// }

// class _QuizSelectionPageState extends State<QuizSelectionPage> {
//   List<DocumentSnapshot> quizzes = []; // Store fetched quizzes
//   bool isLoading = true;
//   bool isError = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchQuizzesFromFirestore(); // Fetch quizzes list on init
//   }

//   // Fetch all quizzes and display them to the user
//   Future<void> fetchQuizzesFromFirestore() async {
//     try {
//       QuerySnapshot snapshot =
//           await FirebaseFirestore.instance.collection('quizzes').get();
//       setState(() {
//         quizzes = snapshot.docs; // Store quizzes
//         isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         isError = true;
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error fetching quizzes: $error'),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Select a Quiz')),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (isError) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Select a Quiz')),
//         body: Center(child: Text('Error loading quizzes. Please try again.')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select a Quiz'),
//       ),
//       body: quizzes.isEmpty
//           ? Center(child: Text('No quizzes available'))
//           : ListView.builder(
//               itemCount: quizzes.length,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot quiz = quizzes[index];
//                 return ListTile(
//                   title: Text(quiz['quizTitle'] ?? 'Quiz ${index + 1}'),
//                   subtitle: Text('Duration: ${quiz['duration']} seconds'),
//                   onTap: () {
//                     // Navigate to QuizUI with fetched title and duration
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => QuizUI(
//                           quizTitle: quiz['quizTitle'] ?? 'Quiz ${index + 1}',
//                           quizDuration: quiz['duration'] ?? 60, // Default to 60 seconds if not set
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }

// class QuizUI extends StatefulWidget {
//   final String quizTitle; // Take the quiz title as a parameter
//   final int quizDuration; // Default duration if not passed from Firestore

//   QuizUI({required this.quizTitle, required this.quizDuration});

//   @override
//   _QuizUIState createState() => _QuizUIState();
// }

// class _QuizUIState extends State<QuizUI> {
//   List<Map<String, dynamic>> questions = [];
//   int currentQuestionIndex = 0;
//   int correctAnswers = 0;
//   int attemptedQuestions = 0;
//   Map<int, String> selectedAnswers = {}; // Keeps track of selected answers
//   Timer? quizTimer;
//   int remainingTime = 0;
//   bool isLoading = true;
//   bool isError = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchQuizDetails(); // Fetch quiz details on init
//   }

//   // Fetch the selected quiz's questions
//   Future<void> fetchQuizDetails() async {
//     try {
//       DocumentSnapshot quizSnapshot = await FirebaseFirestore.instance
//           .collection('quizzes')
//           .doc(widget.quizTitle) // Access the document by quiz title
//           .get();

//       if (quizSnapshot.exists) {
//         // Get the quiz's questions
//         setState(() {
//           questions = List<Map<String, dynamic>>.from(quizSnapshot['questions']);
//           startQuizTimer();
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Quiz not found');
//       }
//     } catch (error) {
//       setState(() {
//         isError = true;
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error loading quiz details: $error'),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }

//   // Start the quiz timer
//   void startQuizTimer() {
//     remainingTime = widget.quizDuration; // Use the passed quiz duration
//     quizTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (remainingTime > 0) {
//           remainingTime--;
//         } else {
//           submitQuiz(); // Automatically submit when time runs out
//         }
//       });
//     });
//   }

//   // Submit quiz manually
//   void submitQuiz() {
//     quizTimer?.cancel();
//     evaluateQuiz();
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => QuizResult(
//           attemptedQuestions: attemptedQuestions,
//           correctAnswers: correctAnswers,
//           totalQuestions: questions.length,
//           timeTaken: widget.quizDuration - remainingTime,
//         ),
//       ),
//     );
//   }

//   // Evaluate quiz and calculate results
//   void evaluateQuiz() {
//     correctAnswers = 0;
//     attemptedQuestions = selectedAnswers.length;

//     for (int i = 0; i < questions.length; i++) {
//       if (selectedAnswers.containsKey(i) &&
//           selectedAnswers[i] == questions[i]['correctAnswer']) {
//         correctAnswers++;
//       }
//     }
//   }

//   @override
//   void dispose() {
//     quizTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Quiz')),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (isError) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Quiz')),
//         body: Center(child: Text('Error loading quiz. Please try again.')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.quizTitle), // Display the quiz title in the app bar
//       ),
//       body: questions.isEmpty
//           ? Center(child: Text('No questions available'))
//           : PageView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: EdgeInsets.all(10),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Question ${index + 1}: ${questions[index]['question']}',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         ...List.generate(4, (optionIndex) {
//                           return RadioListTile<String>(
//                             title: Text(questions[index]['options'][optionIndex]),
//                             value: questions[index]['options'][optionIndex],
//                             groupValue: selectedAnswers[index],
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedAnswers[index] = value!;
//                               });
//                             },
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// // Quiz result page remains the same
// class QuizResult extends StatelessWidget {
//   final int attemptedQuestions;
//   final int correctAnswers;
//   final int totalQuestions;
//   final int timeTaken;

//   QuizResult({
//     required this.attemptedQuestions,
//     required this.correctAnswers,
//     required this.totalQuestions,
//     required this.timeTaken,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenHeight = mediaQuery.size.height;

//     return Scaffold(
//       appBar: AppBar(title: Text('Quiz Result')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: screenHeight * 0.02),
//             Text('Total Questions: $totalQuestions'),
//             SizedBox(height: screenHeight * 0.02),
//             Text('Attempted Questions: $attemptedQuestions'),
//             SizedBox(height: screenHeight * 0.02),
//             Text('Correct Answers: $correctAnswers'),
//             SizedBox(height: screenHeight * 0.02),
//             Text('Time Taken: $timeTaken seconds'),
//             SizedBox(height: screenHeight * 0.04),
//             ElevatedButton(
//                 onPressed: () => Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => HomePage())),
//                 child: Text("Go to Homepage")),
//           ],
//         ),
//       ),
//     );
//   }
// }
