//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_backend_1/screens/Home/home_screen.dart';
import 'package:flutter_backend_1/screens/model/user.dart';
import 'package:flutter_backend_1/screens/pages/checkscreen.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget {
  const wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return either Home or Authenticate widget
    final user = Provider.of<CustomUser?>(context);
    print(user);

    // ignore: unnecessary_null_comparison
    if (user == null) {
      return Checkscreen();
    } else {
      return Home();
    }
  }
}
