import 'package:flutter/material.dart';

class TechnicalInterviewKitsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technical Interview Kits'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('Top Companies'),
            _buildCompanyList(context),
            SizedBox(height: 20),
            _buildSectionTitle('Popular Preparation Kits'),
            _buildKitList(),
            SizedBox(height: 20),
            _buildSectionTitle('Search for a Company or Role'),
            _buildSearchBar(),
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

  Widget _buildCompanyList(BuildContext context) {
    return Column(
      children: [
        _buildCompanyTile(context, 'Google',
            'Prepare for coding and system design interviews at Google.'),
        _buildCompanyTile(context, 'Amazon',
            'Ace Amazon’s technical rounds with curated resources.'),
        _buildCompanyTile(context, 'Microsoft',
            'Focus on problem-solving and system design for Microsoft interviews.'),
        _buildCompanyTile(context, 'Facebook',
            'Get insights into technical challenges at Facebook.'),
        _buildCompanyTile(context, 'Apple',
            'Navigate Apple’s technical interview process with our preparation kit.'),
      ],
    );
  }

  Widget _buildCompanyTile(
      BuildContext context, String companyName, String description) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(
            'assets/${companyName.toLowerCase()}.png'), // Assume you have company logos
      ),
      title: Text(companyName),
      subtitle: Text(description),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CompanyKitPage(companyName: companyName)),
        );
      },
    );
  }

  Widget _buildKitList() {
    return Column(
      children: [
        _buildKitTile(
            'Google Interview Kit',
            'Past coding questions, alumni tips, and preparation roadmap for Google.',
            'Google'),
        _buildKitTile(
            'Amazon Interview Kit',
            'Practice for Amazon’s technical rounds with past interview questions and challenges.',
            'Amazon'),
        _buildKitTile(
            'Microsoft Interview Kit',
            'Get familiar with system design interviews at Microsoft.',
            'Microsoft'),
        _buildKitTile(
            'Facebook Interview Kit',
            'Review key topics for cracking Facebook’s technical interviews.',
            'Facebook'),
      ],
    );
  }

  Widget _buildKitTile(
      String kitTitle, String description, String companyName) {
    return ListTile(
      leading: Icon(Icons.book),
      title: Text(kitTitle),
      subtitle: Text(description),
      trailing: IconButton(
        icon: Icon(Icons.download),
        onPressed: () {
          // Handle download logic
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search Company or Role',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        // Handle search logic here
      },
    );
  }
}

class CompanyKitPage extends StatelessWidget {
  final String companyName;

  CompanyKitPage({required this.companyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$companyName Interview Kit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('Past Interview Questions'),
            _buildQuestionsList(),
            SizedBox(height: 20),
            _buildSectionTitle('Alumni Tips'),
            _buildAlumniTipsSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Common Challenges'),
            _buildChallengesSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Hiring Process Breakdown'),
            _buildHiringProcessSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Preparation Roadmap'),
            _buildRoadmapSection(),
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

  Widget _buildQuestionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('Google: Implement a trie (prefix tree).'),
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('Google: Design a scalable search engine.'),
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('Amazon: Write an algorithm to merge k sorted lists.'),
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title:
              Text('Amazon: Optimize space in a warehouse management system.'),
        ),
      ],
    );
  }

  Widget _buildAlumniTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
              'Tip 1: Focus on problem-solving skills and be confident in your approach.'),
          subtitle: Text('— Alumni, Google'),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
              'Tip 2: Practice system design questions extensively, as they form a big part of on-site interviews.'),
          subtitle: Text('— Alumni, Microsoft'),
        ),
      ],
    );
  }

  Widget _buildChallengesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.warning),
          title: Text(
              'Challenge 1: Handling dynamic inputs efficiently in coding questions.'),
        ),
        ListTile(
          leading: Icon(Icons.warning),
          title: Text(
              'Challenge 2: Making scalable decisions during system design interviews.'),
        ),
      ],
    );
  }

  Widget _buildHiringProcessSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.timeline),
          title: Text(
              'Phone Screen: Initial coding questions to test problem-solving.'),
        ),
        ListTile(
          leading: Icon(Icons.timeline),
          title: Text(
              'On-Site Interviews: Includes coding, system design, and behavioral rounds.'),
        ),
      ],
    );
  }

  Widget _buildRoadmapSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.map),
          title: Text(
              'Week 1-2: Focus on data structures like arrays, linked lists, and hash maps.'),
        ),
        ListTile(
          leading: Icon(Icons.map),
          title:
              Text('Week 3-4: Practice system design and concurrency topics.'),
        ),
        ListTile(
          leading: Icon(Icons.map),
          title: Text(
              'Week 5-6: Mock interviews and solving interview-specific coding challenges.'),
        ),
      ],
    );
  }
}
