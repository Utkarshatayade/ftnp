import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp/train2place/quizapp/quiz_list.dart';
import 'package:tnp/train2place/quizapp/quiz_ui.dart';

class QuizList extends StatefulWidget {
  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  List<DocumentSnapshot> quizzes = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchQuizzesFromFirestore(); // Fetch quizzes list on init
  }

  Future<void> fetchQuizzesFromFirestore() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('quizzes').get();
      setState(() {
        quizzes = snapshot.docs; // Store quizzes
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isError = true;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching quizzes: $error'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz List'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isError
              ? Center(child: Text('Error loading quizzes.'))
              : ListView.builder(
                  itemCount: quizzes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(quizzes[index]['quizTitle']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizUI(quiz: quizzes[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
