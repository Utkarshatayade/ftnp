import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentFeedbackFormPage extends StatefulWidget {
  final String formId;

  StudentFeedbackFormPage({required this.formId});

  @override
  _StudentFeedbackFormPageState createState() =>
      _StudentFeedbackFormPageState();
}

class _StudentFeedbackFormPageState extends State<StudentFeedbackFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  List<TextEditingController> _answerControllers = [];

  @override
  void initState() {
    super.initState();
    _loadForm();
  }

  Future<void> _loadForm() async {
    // Fetch the feedback form using formId
    DocumentSnapshot formSnapshot = await FirebaseFirestore.instance
        .collection('feedbackForms')
        .doc(widget.formId)
        .get();

    var questionsData = formSnapshot['questions'] as List;

    // Extract the question texts from the map
    List<String> questions = questionsData
        .map((question) => question['questionText'].toString())
        .toList();

    // Initialize answer controllers based on the number of questions
    setState(() {
      _answerControllers =
          List.generate(questions.length, (index) => TextEditingController());
    });
  }

  Future<void> _submitFeedback() async {
    if (_nameController.text.isEmpty ||
        _classController.text.isEmpty ||
        _rollNoController.text.isEmpty ||
        _answerControllers.any((controller) => controller.text.isEmpty)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill out all fields')));
      return;
    }

    // Save feedback to Firestore
    try {
      await FirebaseFirestore.instance.collection('feedbackSubmissions').add({
        'formId': widget.formId,
        'studentId': currentUserId,
        'studentName': _nameController.text,
        'class': _classController.text,
        'rollNo': _rollNoController.text,
        'answers':
            _answerControllers.map((controller) => controller.text).toList(),
        'submittedAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback submitted successfully!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting feedback: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Feedback'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('feedbackForms')
            .doc(widget.formId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          var form = snapshot.data!;
          List<String> questions = List<String>.from((form['questions'] as List)
              .map((question) => question['questionText'].toString()));

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _classController,
                    decoration: InputDecoration(labelText: 'Class'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _rollNoController,
                    decoration: InputDecoration(labelText: 'Roll No'),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(questions[index],
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextField(
                              controller: _answerControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Your answer',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitFeedback,
                    child: Text('Submit Feedback'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class StudentFeedbackFormPage extends StatefulWidget {
//   final String formId;

//   StudentFeedbackFormPage({required this.formId});

//   @override
//   _StudentFeedbackFormPageState createState() =>
//       _StudentFeedbackFormPageState();
// }

// class _StudentFeedbackFormPageState extends State<StudentFeedbackFormPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _classController = TextEditingController();
//   final TextEditingController _rollNoController = TextEditingController();
//   final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

//   List<TextEditingController> _answerControllers = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadForm();
//   }

//   Future<void> _loadForm() async {
//     // Fetch the feedback form using formId
//     DocumentSnapshot formSnapshot = await FirebaseFirestore.instance
//         .collection('feedbackForms')
//         .doc(widget.formId)
//         .get();

//     List<String> questions = List<String>.from(formSnapshot['questions']);

//     // Initialize answer controllers based on questions
//     setState(() {
//       _answerControllers =
//           List.generate(questions.length, (index) => TextEditingController());
//     });
//   }

//   Future<void> _submitFeedback() async {
//     if (_nameController.text.isEmpty ||
//         _classController.text.isEmpty ||
//         _rollNoController.text.isEmpty ||
//         _answerControllers.any((controller) => controller.text.isEmpty)) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Please fill out all fields')));
//       return;
//     }

//     // Save feedback to Firestore
//     try {
//       await FirebaseFirestore.instance.collection('feedbackSubmissions').add({
//         'formId': widget.formId,
//         'studentId': currentUserId,
//         'studentName': _nameController.text,
//         'class': _classController.text,
//         'rollNo': _rollNoController.text,
//         'answers':
//             _answerControllers.map((controller) => controller.text).toList(),
//         'submittedAt': Timestamp.now(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Feedback submitted successfully!')));
//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error submitting feedback: $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Submit Feedback'),
//       ),
//       body: FutureBuilder(
//         future: FirebaseFirestore.instance
//             .collection('feedbackForms')
//             .doc(widget.formId)
//             .get(),
//         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (!snapshot.hasData) return CircularProgressIndicator();

//           var form = snapshot.data!;
//           List<String> questions = List<String>.from(form['questions']);

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _nameController,
//                     decoration: InputDecoration(labelText: 'Name'),
//                   ),
//                   SizedBox(height: 10),
//                   TextField(
//                     controller: _classController,
//                     decoration: InputDecoration(labelText: 'Class'),
//                   ),
//                   SizedBox(height: 10),
//                   TextField(
//                     controller: _rollNoController,
//                     decoration: InputDecoration(labelText: 'Roll No'),
//                   ),
//                   SizedBox(height: 20),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: questions.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(questions[index],
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                             TextField(
//                               controller: _answerControllers[index],
//                               decoration: InputDecoration(
//                                 labelText: 'Your answer',
//                                 border: OutlineInputBorder(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _submitFeedback,
//                     child: Text('Submit Feedback'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
