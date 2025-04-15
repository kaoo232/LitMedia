import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_backend_1/screens/Home/home_screen.dart';
import 'package:flutter_backend_1/screens/auth/auth_service.dart';
import 'package:flutter_backend_1/screens/auth/login_screen.dart';
import 'package:flutter_backend_1/screens/pages/authPages/PhoneLogin.dart';
import 'package:flutter_backend_1/shared/loading.dart';
import 'package:flutter_backend_1/static/colors.dart';
import 'package:flutter_backend_1/widget/MyButtons.dart';
import 'package:flutter_backend_1/widget/textfieldcreate.dart';

class Createanaccount extends StatefulWidget {
  const Createanaccount({super.key});

  @override
  State<Createanaccount> createState() => _CreateanaccountState();
}

class _CreateanaccountState extends State<Createanaccount> {
  bool _obscureText1 = false;
  bool _obscureText2 = false;
  // ignore: prefer_final_fields
  bool _obscureText3 = false;
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';
  String name = '';
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
          backgroundColor: AppColors.offWhite,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.lightPurple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.only(top: 80, right: 30, left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Create an account",
                        style: TextStyle(
                          fontFamily: "RozhaOne",
                          fontSize: 37,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              child: Textfieldcreate(
                                obscureText: _obscureText3,
                                text1: "username",
                                text2: "enter your username",
                                prefix: Icon(Icons.person),
                                suffix: Icon(null),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'the name should not be null';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                                decoration: InputDecoration(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              child: Textfieldcreate(
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                obscureText: _obscureText3,
                                suffix: Icon(null),
                                text1: "email",
                                text2: "enter your email",
                                prefix: Icon(Icons.email),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Enter an email please';
                                  } else if (!RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+',
                                  ).hasMatch(val)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              child: Textfieldcreate(
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                obscureText: !_obscureText1,
                                suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText1 = !_obscureText1;
                                    });
                                  },

                                  child:
                                      _obscureText1
                                          ? Icon(Icons.visibility_outlined)
                                          : Icon(Icons.visibility_off_outlined),
                                ),
                                text1: "password",
                                text2: "enter your password",
                                prefix: Icon(Icons.lock),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Enter a password please';
                                  } else if (val.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  } else if (!RegExp(
                                    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
                                  ).hasMatch(val)) {
                                    return 'Password must contain at least one letter and one number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              child: Textfieldcreate(
                                validator: (String? val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please confirm your password';
                                  } else if (val != password) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                obscureText: !_obscureText2,
                                suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText2 = _obscureText2;
                                    });
                                  },
                                  child:
                                      _obscureText2
                                          ? Icon(Icons.visibility_outlined)
                                          : Icon(Icons.visibility_off_outlined),
                                ),
                                text1: "confirm your password",
                                text2: "enter your password",
                                prefix: Icon(Icons.lock),
                                decoration: InputDecoration(),
                                //*** some validator code here  */
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 20,
                              ),
                              child: MyElevatedButton(
                                buttonLabel: "Sign up",
                                onPressedFct: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() => _isLoading = true);
                                    bool isUnique = await _auth
                                        .isUsernameUnique(
                                          name,
                                        ); // Check if username exists

                                    if (!isUnique) {
                                      setState(() {
                                        error =
                                            "Username already exists. Please choose another.";
                                      });
                                      return; // Stop the signup process if username is not unique
                                    }

                                    dynamic result = await _auth
                                        .signUpWithEmailAndPassword(
                                          email,
                                          password,
                                        );

                                    if (result == null) {
                                      setState(() {
                                        error = 'Email already in use';
                                      });
                                    } else {
                                      // Store user data in Firestore
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(result.uid)
                                          .set({
                                            'username': name,
                                            'email': email,
                                          });
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Homepage(),
                                        ),
                                      );
                                    }
                                  }
                                },
                                color1: AppColors.vibrantBlue,
                                color2: AppColors.offWhite,
                                color3: Colors.black,
                              ),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              error,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.0,
                              ),
                            ),
                            Text("or"),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final userG =
                                          await _auth.SignupWithGoogle();

                                      if (userG != null) {
                                        print("User signed up successfully!");
                                        // Navigate to setup profile page
                                      } else {
                                        print(
                                          "This email is already in use. Please log in instead.",
                                        );
                                        // Show a Snackbar or AlertDialog with an error message
                                      }
                                    },
                                    child: Image.asset("images/google.png"),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() => _isLoading = true);

                                      final userCredential =
                                          await _auth.signInWithFacebook();

                                      if (!mounted) return;

                                      setState(() => _isLoading = false);

                                      if (userCredential != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Homepage(),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Facebook login failed. Please try again.",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Image.asset(
                                      "images/facebook.png",
                                      width: 50,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Phonelogin(),
                                        ),
                                      );
                                    },
                                    child: Image.asset("images/telephone.png"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("already have an account ?"),
                          Textt(
                            text1: "Login",
                            onPressedFct: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Loginpage(),
                                ),
                              );
                            },
                            color1: AppColors.vibrantBlue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "by creating an account or signing you agree to the",
                        ),
                        Textt(
                          text1: "Terms and Condition",
                          onPressedFct: () {},
                          color1: AppColors.electricPurple,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
