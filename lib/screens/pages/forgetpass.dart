import 'package:flutter/material.dart';
import 'package:flutter_backend_1/screens/pages/newpass.dart';
import 'package:flutter_backend_1/static/colors.dart';
import 'package:flutter_backend_1/widget/MyButtons.dart';
import 'package:flutter_backend_1/widget/textfieldcreate.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({super.key});

  @override
  State<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
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
            margin: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 60),
            child: Textfieldcreate(
              obscureText: true,
              suffix: Icon(null),
              text1: "email",
              text2: "your email",
              prefix: Icon(Icons.mail_outline),
              validator: (String? val) {
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(70),
            child: MyElevatedButton(
              buttonLabel: "Recover your password",
              onPressedFct: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Newpass()),
                );
              },
              color1: AppColors.vibrantBlue,
              color2: AppColors.offWhite,
              color3: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
