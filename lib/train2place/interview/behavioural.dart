import 'package:flutter/material.dart';

class BehavioralInterviewGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Behavioral Interview Guide'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('Common HR Questions'),
            _buildHRQuestionsSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Model Answers & Interviewer Expectations'),
            _buildModelAnswersSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Soft Skills Tips'),
            _buildSoftSkillsSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Scenario-Based Questions'),
            _buildScenarioBasedQuestionsSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Additional Resources'),
            _buildAdditionalResourcesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildHRQuestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('Tell me about yourself.'),
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('What are your strengths and weaknesses?'),
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('Why do you want to work at our company?'),
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text(
              'Describe a time you faced a challenge and how you handled it.'),
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('Where do you see yourself in five years?'),
        ),
      ],
    );
  }

  Widget _buildModelAnswersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExpandableAnswer(
          question: 'Tell me about yourself.',
          answer:
              'Begin by highlighting your educational background, key skills, and experiences relevant to the role.',
        ),
        _buildExpandableAnswer(
          question: 'What are your strengths and weaknesses?',
          answer:
              'Focus on strengths that are directly related to the job. For weaknesses, be honest but also explain what steps you’re taking to improve.',
        ),
        _buildExpandableAnswer(
          question: 'Why do you want to work at our company?',
          answer:
              'Research the company’s culture and values. Express your genuine interest in contributing to the company’s goals.',
        ),
        _buildExpandableAnswer(
          question:
              'Describe a time you faced a challenge and how you handled it.',
          answer:
              'Explain the situation, your actions, and the outcome. Focus on problem-solving and what you learned from the experience.',
        ),
        _buildExpandableAnswer(
          question: 'Where do you see yourself in five years?',
          answer:
              'Show ambition but align your answer with the company’s career development opportunities.',
        ),
      ],
    );
  }

  Widget _buildExpandableAnswer(
      {required String question, required String answer}) {
    return ExpansionTile(
      title: Text(question),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(answer),
        ),
      ],
    );
  }

  Widget _buildSoftSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.star),
          title: Text('Practice clear and concise communication.'),
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text(
              'Maintain good body language, like eye contact and posture.'),
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('Be confident but not arrogant in your answers.'),
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('Focus on active listening to show engagement.'),
        ),
      ],
    );
  }

  Widget _buildScenarioBasedQuestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('How would you handle conflict with a coworker?'),
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('What would you do if you missed a project deadline?'),
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('How do you handle pressure in the workplace?'),
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title:
              Text('Describe a situation where you worked as part of a team.'),
        ),
      ],
    );
  }

  Widget _buildAdditionalResourcesSection(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.video_library),
          title: Text('Watch Interview Tips from Experts'),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VideoResourcesPage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.podcasts),
          title: Text('Listen to Behavioral Interview Podcasts'),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PodcastResourcesPage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Get Daily Behavioral Interview Tips'),
          trailing: Switch(
            value: true, // Assume notifications are enabled for simplicity
            onChanged: (value) {
              // Toggle notification feature
            },
          ),
        ),
      ],
    );
  }
}

class VideoResourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Resources'),
      ),
      body: Center(
        child:
            Text('Video resources for behavioral interview tips coming soon!'),
      ),
    );
  }
}

class PodcastResourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Podcast Resources'),
      ),
      body: Center(
        child: Text(
            'Podcast resources for behavioral interview tips coming soon!'),
      ),
    );
  }
}
