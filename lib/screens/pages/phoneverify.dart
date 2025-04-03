import 'package:flutter/material.dart';
import 'package:flutter_backend_1/static/colors.dart';
import 'package:flutter_backend_1/widget/MyButtons.dart';
import 'package:flutter_backend_1/screens/auth/auth_service.dart';

class Phoneverify extends StatefulWidget {
  final String verificationId;

  const Phoneverify({super.key, required this.verificationId});

  @override
  _PhoneverifyState createState() => _PhoneverifyState();
}

class _PhoneverifyState extends State<Phoneverify> {
  final TextEditingController _otpController = TextEditingController();

  void _verifyOTP() async {
    String otpCode = _otpController.text.trim();

    if (otpCode.length != 4) {
      // Show error if OTP is not 6 digits
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid 4-digit OTP")),
      );
      return;
    }

    try {
      await AuthService().signInWithOTP(widget.verificationId, otpCode);

      // Navigate to home page or next screen upon success
      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

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
          Text("Check Your Phone", style: TextStyle(fontSize: 24)),
          Text(
            "We've sent a code to your phone",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.gris.withOpacity(0.49),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          MyElevatedButton(
            buttonLabel: "Verify",
            onPressedFct: _verifyOTP, // Call function to verify OTP
            color1: AppColors.vibrantBlue,
            color2: AppColors.offWhite,
            color3: Colors.black,
          ),
          SizedBox(height: 10),
          MyElevatedButton(
            buttonLabel: "Resend Code",
            onPressedFct: () {
              // Implement resend functionality if needed
            },
            color1: AppColors.greywhite,
            color2: Colors.black,
            color3: Colors.black,
          ),
        ],
      ),
    );
  }
}
