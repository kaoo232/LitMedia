import 'package:flutter/material.dart';
import 'package:flutter_backend_1/screens/auth/auth_service.dart';
import 'package:flutter_backend_1/screens/wrapper.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('home page'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.SignOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => wrapper()),
              );
            },
          ),
        ],
      ),
    );
  }
}
