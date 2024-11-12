// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';

// class QuizUI extends StatefulWidget {
//   final DocumentSnapshot quiz; // Pass the selected quiz

//   QuizUI({required this.quiz}); // Constructor

//   @override
//   _QuizUIState createState() => _QuizUIState();
// }

// class _QuizUIState extends State<QuizUI> {
//   late List<dynamic> questions;
//   int currentQuestionIndex = 0;
//   late int score;
//   late Timer timer;
//   late int remainingTime;

//   @override
//   void initState() {
//     super.initState();
//     score = 0;
//     questions = widget.quiz['questions'];
//     remainingTime = widget.quiz['duration']; // Get duration from the quiz document
//     startTimer();
//   }

//   void startTimer() {
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (remainingTime <= 0) {
//         timer.cancel();
//         showResult();
//       } else {
//         setState(() {
//           remainingTime--;
//         });
//       }
//     });
//   }

//   void showResult() {
//     // Logic for showing the result
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Quiz Finished'),
//           content: Text('Your score: $score/${questions.length}'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//                 Navigator.of(context).pop(); // Return to quiz list
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void answerQuestion(String selectedAnswer) {
//     if (selectedAnswer == questions[currentQuestionIndex]['correctAnswer']) {
//       score++;
//     }

//     setState(() {
//       currentQuestionIndex++;
//     });

//     if (currentQuestionIndex >= questions.length) {
//       timer.cancel();
//       showResult();
//     }
//   }

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz: ${widget.quiz['quizTitle']}'),
//       ),
//       body: currentQuestionIndex < questions.length
//           ? Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     'Time Remaining: $remainingTime seconds',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     questions[currentQuestionIndex]['question'],
//                     style: TextStyle(fontSize: 24),
//                   ),
//                 ),
//                 ...List.generate(4, (index) {
//                   return ElevatedButton(
//                     onPressed: () {
//                       answerQuestion(questions[currentQuestionIndex]['options'][index]);
//                     },
//                     child: Text(
//                       questions[currentQuestionIndex]['options'][index],
//                     ),
//                   );
//                 }),
//               ],
//             )
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }
// }
// ---------------------------------------------------------------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class QuizUI extends StatefulWidget {
  final DocumentSnapshot quiz; // Pass the selected quiz

  QuizUI({required this.quiz}); // Constructor

  @override
  _QuizUIState createState() => _QuizUIState();
}

class _QuizUIState extends State<QuizUI> {
  late List<dynamic> questions;
  int currentQuestionIndex = 0;
  late int score;
  late Timer timer;
  late int remainingTime;
  int questionsAttempted = 0; // Track questions attempted
  bool quizFinished = false; // Flag to indicate if quiz is finished
  String? selectedAnswer; // Track the selected answer

  @override
  void initState() {
    super.initState();
    score = 0;
    questions = widget.quiz['questions'];
    remainingTime =
        widget.quiz['duration']; // Get duration from the quiz document
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime <= 0) {
        timer.cancel();
        showResult();
      } else {
        setState(() {
          remainingTime--;
        });
      }
    });
  }

  void showResult() {
    timer.cancel();
    setState(() {
      quizFinished = true; // Set quiz finished flag
    });
  }

  void answerQuestion(String answer) {
    if (answer == questions[currentQuestionIndex]['correctAnswer']) {
      score++;
    }
    questionsAttempted++; // Increment questions attempted
    setState(() {
      selectedAnswer = answer; // Store the selected answer
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${widget.quiz['quizTitle']}'),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(child: Text('Time left: $remainingTime sec')),
          ),
        ],
      ),
      body: quizFinished
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quiz Finished',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text('Total Questions: ${questions.length}'),
                  Text('Questions Attempted: $questionsAttempted'),
                  Text('Correctly Answered: $score'),
                  Text(
                      'Time Taken: ${widget.quiz['duration'] - remainingTime} seconds'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text('Go to Home'),
                  ),
                ],
              ),
            )
          : currentQuestionIndex < questions.length
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.15,
                        child: Text(
                          questions[currentQuestionIndex]['question'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Column(
                        children: List.generate(
                          questions[currentQuestionIndex]['options'].length,
                          (index) {
                            final option = questions[currentQuestionIndex]
                                ['options'][index];
                            return GestureDetector(
                              onTap: () {
                                answerQuestion(
                                    option); // Select option when tapped
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: selectedAnswer == option
                                      ? Colors.blue[100]
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: selectedAnswer == option
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: option,
                                      groupValue: selectedAnswer,
                                      onChanged: (value) {
                                        if (value != null) {
                                          answerQuestion(value);
                                        }
                                      },
                                    ),
                                    Expanded(
                                      child: Text(option),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: currentQuestionIndex > 0
                                ? () {
                                    setState(() {
                                      currentQuestionIndex--;
                                      selectedAnswer =
                                          null; // Reset selected answer on question change
                                    });
                                  }
                                : null,
                            child: Text('Previous'),
                          ),
                          ElevatedButton(
                            onPressed:
                                currentQuestionIndex < questions.length - 1
                                    ? () {
                                        setState(() {
                                          currentQuestionIndex++;
                                          selectedAnswer =
                                              null; // Reset selected answer on question change
                                        });
                                      }
                                    : () {
                                        showResult(); // Call showResult when submitted
                                      },
                            child: Text(
                                currentQuestionIndex == questions.length - 1
                                    ? 'Submit'
                                    : 'Next'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}
