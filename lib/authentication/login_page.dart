// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:tnp/authentication/signup_page.dart';

// // class LoginPage extends StatefulWidget {
// //   @override
// //   _LoginPageState createState() => _LoginPageState();
// // }

// // class _LoginPageState extends State<LoginPage> {
// //   final _auth = FirebaseAuth.instance;
// //   final _firestore = FirebaseFirestore.instance;
// //   final _formKey = GlobalKey<FormState>();

// //   String _email = '';
// //   String _password = '';
// //   bool _isLoading = false;

// //   void _login() async {
// //     if (_formKey.currentState!.validate()) {
// //       setState(() {
// //         _isLoading = true;
// //       });
// //       try {
// //         UserCredential userCredential = await _auth.signInWithEmailAndPassword(
// //           email: _email,
// //           password: _password,
// //         );

// //         // Retrieve user role from Firestore
// //         DocumentSnapshot userDoc = await _firestore
// //             .collection('users')
// //             .doc(userCredential.user!.uid)
// //             .get();
// //         String role = userDoc['role'];

// //         // Navigate based on role
// //         if (role == 'admin') {
// //           Navigator.pushReplacementNamed(context, '/admin_dashboard');
// //         } else {
// //           Navigator.pushReplacementNamed(context, '/student_home');
// //         }
// //       } catch (e) {
// //         // Error handling
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Login failed: ${e.toString()}')),
// //         );
// //       } finally {
// //         setState(() {
// //           _isLoading = false;
// //         });
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Login'),
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: SingleChildScrollView(
// //           child: Form(
// //             key: _formKey,
// //             child: Column(
// //               children: <Widget>[
// //                 TextFormField(
// //                   decoration: InputDecoration(labelText: 'Email'),
// //                   keyboardType: TextInputType.emailAddress,
// //                   onChanged: (value) {
// //                     _email = value;
// //                   },
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter an email';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 TextFormField(
// //                   decoration: InputDecoration(labelText: 'Password'),
// //                   obscureText: true,
// //                   onChanged: (value) {
// //                     _password = value;
// //                   },
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter a password';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 20),
// //                 _isLoading
// //                     ? CircularProgressIndicator()
// //                     : ElevatedButton(
// //                         onPressed: _login,
// //                         child: Text('Login'),
// //                       ),
// //                 SizedBox(
// //                   height: 20,
// //                 ),
// //                 TextButton(
// //                   onPressed: () => Navigator.push(context,
// //                       MaterialPageRoute(builder: (context) => SignupPage())),
// //                   child: Text("Signup"),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // --------------------------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tnp/authentication/signup_page.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   final _formKey = GlobalKey<FormState>();

//   String _email = '';
//   String _password = '';
//   bool _isLoading = false;

//   void _login() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });
//       try {
//         UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//           email: _email,
//           password: _password,
//         );

//         // Retrieve user role from Firestore
//         DocumentSnapshot userDoc = await _firestore
//             .collection('users')
//             .doc(userCredential.user!.uid)
//             .get();
//         String role = userDoc['role'];

//         // Navigate based on role
//         if (role == 'admin') {
//           Navigator.pushReplacementNamed(context, '/admin_dashboard');
//         } else {
//           Navigator.pushReplacementNamed(context, '/student_home');
//         }
//       } catch (e) {
//         // Error handling
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Login failed: ${e.toString()}')),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: [
//         // Background image
//         Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(
//                   'assets/images/bg-app.jpg'), // Replace with your image path
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Title
//                     Text(
//                       'Train2Place',
//                       style: TextStyle(
//                         fontSize: 36,
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                     SizedBox(height: 30), // Padding below the title
//                     // Card widget
//                     Card(
//                       elevation: 6,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       margin: EdgeInsets.symmetric(horizontal: 16),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Form(
//                           key: _formKey,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               // Login text
//                               Text(
//                                 'Login',
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 20), // Spacing
//                               // Email TextField
//                               TextFormField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Email',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                 ),
//                                 validator: (value) => value!.isEmpty
//                                     ? 'Please enter your email'
//                                     : null,
//                                 onChanged: (value) {
//                                   _email = value!;
//                                 },
//                               ),
//                               SizedBox(height: 20), // Spacing
//                               // Password TextField
//                               TextFormField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Password',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                 ),
//                                 obscureText: true,
//                                 validator: (value) => value!.isEmpty
//                                     ? 'Please enter your password'
//                                     : null,
//                                 onChanged: (value) {
//                                   _password = value!;
//                                 },
//                               ),
//                               SizedBox(height: 20), // Spacing
//                               // Login button
//                               ElevatedButton(
//                                 onPressed: _login,
//                                 child: Text('Login'),
//                               ),
//                               SizedBox(height: 20), // Spacing
//                               // Signup text
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text("Don't have an account? "),
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => SignupPage()),
//                                       );
//                                     },
//                                     child: Text(
//                                       'Sign Up',
//                                       style: TextStyle(color: Colors.blue),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ],
//     ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp/authentication/signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        String role = userDoc['role'];

        if (role == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin_dashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/student_home');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color and image at the top
          Container(
            color: Colors.blue[900], // Main background color
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/image.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Card container for login fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Username and Password Fields
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter your username'
                                    : null,
                                onChanged: (value) {
                                  _email = value;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter your password'
                                    : null,
                                onChanged: (value) {
                                  _password = value;
                                },
                              ),
                              SizedBox(height: 20),
                              // Login button
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: _login,
                                child: _isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                              ),
                              SizedBox(height: 20),
                              // Signup option
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignupPage()),
                                    ),
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
