// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tnp/authentication/mainhomepage.dart';
import './authentication/signup_page.dart';
import './authentication/login_page.dart';
import './student/student_homepage.dart';
import './admin/admin_dashboard.dart';
import './admin/community_page.dart';
import 'student/messaging_page.dart';
import './admin/calendar_page.dart';
import './authentication/mainhomepage.dart'; // Import MainHomePage
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground notifications
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message.notification?.body ?? 'New notification')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Training & Placement',
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/', // Keep '/' as initial route, but route to MainHomePage
      routes: {
        '/': (context) => MainHomePage(), // Set MainHomePage as the first page
        '/login': (context) => LoginPage(), // New route for LoginPage
        '/signup': (context) => SignupPage(),
        '/student_home': (context) => StudentHomePage(),
        '/admin_dashboard': (context) => AdminDashboard(),
        '/community': (context) => CommunityPage(),
        '/messaging': (context) =>
            MessagingPage(recipientEmail: 'admin@college.com'),
        '/calendar': (context) => CalendarPage(isAdmin: false),
      },
    );
  }
}
