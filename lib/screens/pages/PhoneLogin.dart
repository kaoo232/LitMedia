import 'package:flutter/material.dart';
import 'package:flutter_backend_1/screens/auth/auth_service.dart';

import 'package:flutter_backend_1/screens/pages/phoneverify.dart';
import 'package:flutter_backend_1/static/colors.dart';
import 'package:flutter_backend_1/widget/MyButtons.dart';
// ignore: library_prefixes
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart'
    as FlutterLibphonenumber;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Phonelogin extends StatefulWidget {
  const Phonelogin({super.key});

  @override
  _PhoneloginState createState() => _PhoneloginState();
}

class _PhoneloginState extends State<Phonelogin> {
  final TextEditingController _controller = TextEditingController();
  PhoneNumber _number = PhoneNumber(isoCode: 'DZ');
  String _phoneNumber = '';
  // ignore: unused_field
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _initializePhoneNumber();
  }

  void _initializePhoneNumber() async {
    await FlutterLibphonenumber.init();
  }

  void _validatePhoneNumber() {
    AuthService().verifyPhoneNumber(
      _phoneNumber,
      (verificationId) {
        // Navigate to OTP screen and pass the verificationId
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Phoneverify(verificationId: verificationId),
          ),
        );
      },
      (message) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      },
      (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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
          Text("Enter your phone number", style: TextStyle(fontSize: 24)),
          Padding(
            padding: const EdgeInsets.all(40),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                setState(() {
                  _number = number;
                  _phoneNumber = number.phoneNumber ?? "";
                });
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              initialValue: _number,
              textFieldController: _controller,
              formatInput: true,
              keyboardType: TextInputType.phone,
              inputBorder: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(70),
            child: MyElevatedButton(
              buttonLabel: "Done",
              onPressedFct: () {
                _validatePhoneNumber();
                _showMessage("Processing...");
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
