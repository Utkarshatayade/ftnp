// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tnp/authentication/login_page.dart';

// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   final _formKey = GlobalKey<FormState>();

//   String _email = '';
//   String _password = '';
//   String _role = 'student'; // default role
//   bool _isLoading = false;

//   void _signUp() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });
//       try {
//         UserCredential userCredential =
//             await _auth.createUserWithEmailAndPassword(
//           email: _email,
//           password: _password,
//         );

//         // Storing user role and details in Firestore
//         await _firestore.collection('users').doc(userCredential.user!.uid).set({
//           'email': _email,
//           'role': _role,
//         });

//         // Navigate based on role
//         if (_role == 'admin') {
//           Navigator.pushReplacementNamed(context, '/admin_dashboard');
//         } else {
//           Navigator.pushReplacementNamed(context, '/student_home');
//         }
//       } catch (e) {
//         // Error handling
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Signup failed: ${e.toString()}')),
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
//       appBar: AppBar(
//         title: Text('Signup'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Email'),
//                   keyboardType: TextInputType.emailAddress,
//                   onChanged: (value) {
//                     _email = value;
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter an email';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   onChanged: (value) {
//                     _password = value;
//                   },
//                   validator: (value) {
//                     if (value == null || value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 DropdownButtonFormField(
//                   value: _role,
//                   items: ['student', 'admin'].map((role) {
//                     return DropdownMenuItem(
//                       value: role,
//                       child: Text(role),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _role = value!;
//                     });
//                   },
//                   decoration: InputDecoration(labelText: 'Role'),
//                 ),
//                 SizedBox(height: 20),
//                 _isLoading
//                     ? CircularProgressIndicator()
//                     : ElevatedButton(
//                         onPressed: _signUp,
//                         child: Text('Sign Up'),
//                       ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextButton(
//                     onPressed: () => Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => LoginPage())),
//                     child: Text("Login")),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tnp/authentication/login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _role = 'student'; // default role
  bool _isLoading = false;

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // Storing user role and details in Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': _email,
          'role': _role,
        });

        // Navigate based on role
        if (_role == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin_dashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/student_home');
        }
      } catch (e) {
        // Error handling
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: ${e.toString()}')),
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
              child: Padding(
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
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              _email = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              return null;
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
                            onChanged: (value) {
                              _password = value;
                            },
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          DropdownButtonFormField(
                            value: _role,
                            items: ['student', 'admin'].map((role) {
                              return DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _role = value!;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Role',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          _isLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[900],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                  ),
                                  onPressed: _signUp,
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                ),
                                child: Text(
                                  'Login',
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
            ),
          ),
        ],
      ),
    );
  }
}
