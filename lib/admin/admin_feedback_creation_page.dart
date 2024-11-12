import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminFeedbackCreationPage extends StatefulWidget {
  @override
  _AdminFeedbackCreationPageState createState() =>
      _AdminFeedbackCreationPageState();
}

class _AdminFeedbackCreationPageState extends State<AdminFeedbackCreationPage> {
  final TextEditingController _formNameController = TextEditingController();
  List<TextEditingController> _questionControllers = [];

  @override
  void initState() {
    super.initState();
    _addNewQuestion(); // Start with one question input field
  }

  // Add a new question controller
  void _addNewQuestion() {
    setState(() {
      _questionControllers.add(TextEditingController());
    });
  }

  // Remove a specific question controller
  void _removeQuestion(int index) {
    setState(() {
      _questionControllers.removeAt(index);
    });
  }

  // Submit the feedback form to Firestore
  Future<void> _submitFeedbackForm() async {
    if (_formNameController.text.isEmpty ||
        _questionControllers.any((controller) => controller.text.isEmpty)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill out all fields.')));
      return;
    }

    try {
      List<Map<String, String>> questions = _questionControllers
          .map((controller) => {'questionText': controller.text})
          .toList();

      await FirebaseFirestore.instance.collection('feedbackForms').add({
        'formName': _formNameController.text,
        'questions': questions,
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback form created successfully!')));
      _clearForm();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating feedback form: $e')));
    }
  }

  // Clear the form after submission
  void _clearForm() {
    _formNameController.clear();
    setState(() {
      _questionControllers = [TextEditingController()];
    });
  }

  // Delete a feedback form
  Future<void> _deleteFeedbackForm(String formId) async {
    try {
      await FirebaseFirestore.instance
          .collection('feedbackForms')
          .doc(formId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback form deleted successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting feedback form: $e')));
    }
  }

  // Edit feedback form (navigate to a custom edit page or implement inline editing)
  void _editFeedbackForm(DocumentSnapshot form) {
    // Implement navigation or inline editing logic
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFeedbackFormPage(form: form),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Feedback Form'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _formNameController,
                    decoration:
                        InputDecoration(labelText: 'Feedback Form Name'),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _questionControllers.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _questionControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Question ${index + 1}',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () => _removeQuestion(index),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addNewQuestion,
                    child: Text('Add Question'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitFeedbackForm,
                    child: Text('Submit Feedback Form'),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Existing Feedback Forms',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _buildFeedbackFormsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the list of feedback forms below the form creation section
  Widget _buildFeedbackFormsList() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('feedbackForms').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var feedbackForms = snapshot.data!.docs;

        if (feedbackForms.isEmpty) {
          return Center(child: Text('No feedback forms available.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: feedbackForms.length,
          itemBuilder: (context, index) {
            var form = feedbackForms[index];
            return Card(
              child: ListTile(
                title: Text(form['formName']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Questions: ${form['questions'].length}'),
                    SizedBox(height: 5),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editFeedbackForm(form),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmDelete(context, form.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Confirm deletion with a dialog box
  void _confirmDelete(BuildContext context, String formId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Feedback Form'),
          content: Text('Are you sure you want to delete this form?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                Navigator.pop(context);
                await _deleteFeedbackForm(formId);
              },
            ),
          ],
        );
      },
    );
  }
}

// Dummy EditFeedbackFormPage. You can implement actual editing functionality here.
class EditFeedbackFormPage extends StatelessWidget {
  final DocumentSnapshot form;

  EditFeedbackFormPage({required this.form});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Feedback Form'),
      ),
      body: Center(
        child: Text('Edit form: ${form['formName']}'),
      ),
    );
  }
}

// -----------------------------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AdminFeedbackCreationPage extends StatefulWidget {
//   @override
//   _AdminFeedbackCreationPageState createState() =>
//       _AdminFeedbackCreationPageState();
// }

// class _AdminFeedbackCreationPageState extends State<AdminFeedbackCreationPage> {
//   final TextEditingController _formNameController = TextEditingController();

//   List<Map<String, dynamic>> _questions = [];

//   void _addQuestion() {
//     setState(() {
//       _questions.add({
//         'question': TextEditingController(),
//         'type': 'One-line', // Default type
//         'options': <TextEditingController>[] // For MCQs or radio button options
//       });
//     });
//   }

//   void _removeQuestion(int index) {
//     setState(() {
//       _questions.removeAt(index);
//     });
//   }

//   void _addOption(int questionIndex) {
//     setState(() {
//       _questions[questionIndex]['options']
//           .add(TextEditingController()); // Adding an option field for MCQs
//     });
//   }

//   void _removeOption(int questionIndex, int optionIndex) {
//     setState(() {
//       _questions[questionIndex]['options'].removeAt(optionIndex);
//     });
//   }

//   Future<void> _createForm() async {
//     if (_formNameController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please provide a form name')),
//       );
//       return;
//     }

//     List<Map<String, dynamic>> questions = [];

//     // Iterate through each question and validate its inputs
//     for (var q in _questions) {
//       if (q['question'].text.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please fill out all questions')),
//         );
//         return;
//       }

//       // Fix type issue by ensuring the 'options' is a list of TextEditingController
//       if (q['type'] == 'MCQs' || q['type'] == 'Radio Buttons') {
//         if (q['options'].isEmpty ||
//             q['options'].any((TextEditingController controller) =>
//                 controller.text.isEmpty)) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//                 content: Text('Please provide options for MCQs/Radio Buttons')),
//           );
//           return;
//         }
//       }

//       // Collect valid question data
//       questions.add({
//         'question': q['question'].text,
//         'type': q['type'],
//         'options': (q['type'] == 'One-line' || q['type'] == 'Descriptive')
//             ? []
//             : q['options']
//                 .map((TextEditingController controller) => controller.text)
//                 .toList(),
//       });
//     }

//     // Firestore write operation
//     try {
//       await FirebaseFirestore.instance.collection('feedbackForms').add({
//         'formName': _formNameController.text,
//         'questions': questions,
//         'createdAt': Timestamp.now(),
//       });

//       // Notify the user that the form was created
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Form created successfully!')),
//       );

//       // Clear the form fields after successful submission
//       _clearForm();
//     } catch (e) {
//       // If there is an error, log it and show an error message
//       print('Error creating form: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error creating form: $e')),
//       );
//     }
//   }

//   void _clearForm() {
//     _formNameController.clear();
//     setState(() {
//       _questions.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Feedback Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _formNameController,
//                 decoration: InputDecoration(labelText: 'Form Name'),
//               ),
//               SizedBox(height: 20),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: _questions.length,
//                 itemBuilder: (context, index) {
//                   return _buildQuestionCard(index);
//                 },
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _addQuestion,
//                 child: Text('Add Question'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _createForm,
//                 child: Text('Create Form'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Method to build a card for each question
//   Widget _buildQuestionCard(int index) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _questions[index]['question'],
//                     decoration:
//                         InputDecoration(labelText: 'Question ${index + 1}'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () => _removeQuestion(index),
//                 ),
//               ],
//             ),
//             DropdownButton<String>(
//               value: _questions[index]['type'],
//               items: ['One-line', 'Descriptive', 'MCQs', 'Radio Buttons']
//                   .map((String type) {
//                 return DropdownMenuItem<String>(
//                   value: type,
//                   child: Text(type),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _questions[index]['type'] = value!;
//                 });
//               },
//               hint: Text('Select Answer Type'),
//             ),
//             SizedBox(height: 10),
//             if (_questions[index]['type'] == 'MCQs' ||
//                 _questions[index]['type'] == 'Radio Buttons')
//               _buildOptionsList(index)
//           ],
//         ),
//       ),
//     );
//   }

//   // Method to build options for MCQs and Radio Buttons
//   Widget _buildOptionsList(int questionIndex) {
//     return Column(
//       children: [
//         ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: _questions[questionIndex]['options'].length,
//           itemBuilder: (context, optionIndex) {
//             return Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _questions[questionIndex]['options']
//                         [optionIndex],
//                     decoration:
//                         InputDecoration(labelText: 'Option ${optionIndex + 1}'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () => _removeOption(questionIndex, optionIndex),
//                 ),
//               ],
//             );
//           },
//         ),
//         TextButton(
//           onPressed: () => _addOption(questionIndex),
//           child: Text('Add Option'),
//         ),
//       ],
//     );
//   }
// }
