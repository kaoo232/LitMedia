import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_backend_1/screens/auth/login_screen.dart';
import 'package:flutter_backend_1/shared/loading.dart';
import 'package:flutter_backend_1/static/colors.dart';
import 'package:flutter_backend_1/widget/MyButtons.dart';
import 'package:flutter_backend_1/widget/textfieldcreate.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({super.key});

  @override
  State<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.offWhite,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          backgroundColor: AppColors.offWhite,
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Password Recovery", style: TextStyle(fontSize: 24)),
                Text(
                  "enter your email to recover your password",
                  style: TextStyle(
                    fontSize: 14,
                    // ignore: deprecated_member_use
                    color: AppColors.gris.withOpacity(0.49),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 40,
                    right: 40,
                    bottom: 60,
                  ),
                  child: Textfieldcreate(
                    controller: emailController,
                    obscureText: false,
                    suffix: Icon(null),
                    text1: "email",
                    text2: "your email",
                    prefix: Icon(Icons.mail_outline),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Enter an email please';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    }, decoration: InputDecoration(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(70),
                  child: MyElevatedButton(
                    buttonLabel: "Recover your password",
                    onPressedFct: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        sendPasswordResetEmail(context, emailController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Loginpage()),
                        );
                      }
                    },

                    color1: AppColors.vibrantBlue,
                    color2: AppColors.offWhite,
                    color3: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
  }
}

void sendPasswordResetEmail(BuildContext context, String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password reset link sent to $email")),
    );
  } catch (e) {
    // Handle errors (invalid email, etc.)
    print("Error: $e");
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
  }
}
