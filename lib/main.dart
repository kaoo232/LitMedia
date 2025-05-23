import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_backend_1/firebase_options.dart';
import 'package:flutter_backend_1/screens/Home/home_screen.dart';
import 'package:flutter_backend_1/screens/auth/auth_service.dart';
import 'package:flutter_backend_1/screens/model/user.dart';
import 'package:flutter_backend_1/screens/pages/onboarding/onboarding1.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase initialized successfully!");
  } catch (e) {
    print("❌ Firebase initialization error: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userStream = AuthService().user;
    return MultiProvider(
      providers: [
        StreamProvider<CustomUser?>.value(
          value: userStream,
          initialData: CustomUser(
            uid: 'null',
            email: 'null@example.com',
            displayName: 'anonyme',
          ),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<CustomUser?>(
          builder: (context, user, child) {
            // Check if the user is logged in
            if (user != null) {
              // User is logged in, navigate to HomeScreen
              return Homepage(); // Replace with your actual home screen widget
            } else {
              // User is not logged in, show OnboardingScreen
              return OnboardingScreen();
            }
          },
        ),
      ),
    );
  }
}
