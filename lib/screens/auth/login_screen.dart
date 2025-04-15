import 'package:flutter/material.dart';
import 'package:flutter_backend_1/screens/Home/home_screen.dart';
import 'package:flutter_backend_1/screens/auth/auth_service.dart';
import 'package:flutter_backend_1/screens/auth/signup_screen.dart';
import 'package:flutter_backend_1/screens/pages/authPages/PhoneLogin.dart';
import 'package:flutter_backend_1/screens/pages/authPages/forgetpass.dart';
import 'package:flutter_backend_1/shared/loading.dart';
import 'package:flutter_backend_1/static/colors.dart';
import 'package:flutter_backend_1/widget/MyButtons.dart';
import 'package:flutter_backend_1/widget/textfieldcreate.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String email = '';
  String password = '';
  String error = '';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
          resizeToAvoidBottomInset: false, // Prevents bottom overflow issues
          backgroundColor: AppColors.offWhite,
          body: SafeArea(
            child: Column(
              children: [
                /// Logo Section
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/logo.png',
                    height: 150, // Set a specific height for the image
                    width: 150, // Set a specific width for the image
                    fit: BoxFit.contain,
                  ),
                ),

                /// Login Form Section
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom:
                          MediaQuery.of(
                            context,
                          ).viewInsets.bottom, // Adjust for keyboard
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightPurple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(56),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 65),

                          /// Title
                          Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                fontFamily: "RozhaOne",
                                fontSize: 37,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          SizedBox(height: 50),

                          /// Login Form
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                /// Email Field
                                Textfieldcreate(
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                  obscureText: false,
                                  suffix: Icon(null),
                                  text1: "Email",
                                  text2: "Enter your email",
                                  prefix: Icon(Icons.email),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Enter an email please';
                                    }
                                    if (!RegExp(
                                      r'^[^@]+@[^@]+\.[^@]+',
                                    ).hasMatch(val)) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(),
                                ),

                                /* : Colors.black, // Customize text color
            ),
            decoration: InputDecoration*/
                                SizedBox(height: 20),

                                /// Password Field
                                Textfieldcreate(
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Enter a password please';
                                    }
                                    if (val.length < 6) {
                                      return 'Password must be at least 6 characters long';
                                    }
                                    if (!RegExp(
                                      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
                                    ).hasMatch(val)) {
                                      return 'Password must contain at least one letter and one number';
                                    }
                                    return null;
                                  },
                                  obscureText: _obscureText,
                                  suffix: GestureDetector(
                                    onTap: () {
                                      setState(
                                        () => _obscureText = !_obscureText,
                                      );
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                  ),
                                  text1: "Password",
                                  text2: "Enter your password",
                                  prefix: Icon(Icons.lock),
                                  decoration: InputDecoration(),
                                ),

                                SizedBox(height: 10),

                                /// Forgot Password Button
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Forgetpass(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Forgot your password?",
                                      style: TextStyle(
                                        color: AppColors.vibrantBlue,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20),

                                /// Login Button
                                MyElevatedButton(
                                  buttonLabel: "Log in",
                                  onPressedFct: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => _isLoading = true);
                                      dynamic result = await _auth
                                          .signInWithEmailPassword(
                                            email,
                                            password,
                                          );
                                      if (result == null) {
                                        setState(
                                          () =>
                                              error =
                                                  'Could not sign in with those credentials',
                                        );
                                      } else {
                                        Navigator.pushReplacement(
                                          // ignore: use_build_context_synchronously
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Homepage(),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  color1: AppColors.vibrantBlue,
                                  color2: Colors.white,
                                  color3: Colors.black,
                                ),

                                SizedBox(height: 12),

                                /// Error Message Display
                                if (error.isNotEmpty)
                                  Text(
                                    error,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),

                                SizedBox(height: 20),

                                /// Social Login
                                Center(child: Text("or")),

                                SizedBox(height: 20),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    /// Google Login
                                    GestureDetector(
                                      onTap: () async {
                                        dynamic userG =
                                            await _auth.loginWithGoogle();
                                        if (userG != null) {
                                          Navigator.pushReplacement(
                                            // ignore: use_build_context_synchronously
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Homepage(),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            // ignore: use_build_context_synchronously
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Google login failed. Please try again.",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Image.asset(
                                        "images/google.png",
                                        width: 50,
                                      ),
                                    ),

                                    /// Facebook Login
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

                                    /// Phone Login
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Phonelogin(),
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                        "images/telephone.png",
                                        width: 50,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("don't have an account yet ?"),
                                    Textt(
                                      text1: "Sign up",
                                      onPressedFct: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => Createanaccount(),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
