import 'package:flutter/material.dart';
import 'package:flutter_backend_1/screens/auth/login_screen.dart';
import 'package:flutter_backend_1/screens/auth/signup_screen.dart';
import 'package:flutter_backend_1/static/colors.dart';
import 'package:flutter_backend_1/widget/MyButtons.dart';

class Checkscreen extends StatelessWidget {
  const Checkscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Container(
            margin: EdgeInsets.only(bottom: 50),
            height: 45,
            width: 301,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/textlogo.png")),
            ),
          ),
          Text("Ready to Transform Your Reading Journey?"),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 100,
                  right: 50,
                  left: 50,
                  bottom: 10,
                ),
                child: MyElevatedButton(
                  color3: AppColors.vibrantBlue,
                  buttonLabel: 'sign in',
                  onPressedFct: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Loginpage()),
                    );
                  },
                  color1: AppColors.vibrantBlue,
                  color2: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 50, left: 50),
                child: MyElevatedButton(
                  color3: Colors.black,
                  buttonLabel: 'create an account',
                  onPressedFct: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Createanaccount(),
                      ),
                    );
                  },
                  color1: AppColors.greywhite,
                  color2: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
