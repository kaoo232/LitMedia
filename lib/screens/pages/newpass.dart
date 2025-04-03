import 'package:flutter/material.dart';
import 'package:flutter_backend_1/static/colors.dart';
import 'package:flutter_backend_1/widget/MyButtons.dart';
import 'package:flutter_backend_1/widget/textfieldcreate.dart';

class Newpass extends StatefulWidget {
  const Newpass({super.key});

  @override
  State<Newpass> createState() => _NewpassState();
}

class _NewpassState extends State<Newpass> {
  bool _obscureText = false;
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
          Text("Reset your password", style: TextStyle(fontSize: 24)),
          Text(
            "enter your new password",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.gris.withOpacity(0.49),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 30),
            child: Textfieldcreate(
              obscureText: _obscureText,
              suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child:
                    _obscureText
                        ? Icon(Icons.visibility_off_outlined)
                        : Icon(Icons.visibility_outlined),
              ),
              text1: "",
              text2: "new password",
              prefix: Icon(null),
              validator: (String? v) {
                return null;
              },
            ),
          ),
          Text(
            "your password must contains:",
            style: TextStyle(
              // ignore: deprecated_member_use
              fontSize: 14,
              // ignore: deprecated_member_use
              color: AppColors.gris.withOpacity(0.49),
            ),
          ),
          Text("at least 8 caracters"),
          Container(
            margin: EdgeInsets.all(70),
            child: MyElevatedButton(
              buttonLabel: "Done",
              onPressedFct: () {},
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
