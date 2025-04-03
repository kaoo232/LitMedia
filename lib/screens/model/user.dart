import 'package:firebase_auth/firebase_auth.dart';

class CustomUser {
  final String uid;
  final String email;
  final String? displayName;
  // Additional fields can be added as needed

  CustomUser({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  // Factory constructor to convert a Firebase User to a CustomUser
  factory CustomUser.fromFirebaseUser(User user) {
    return CustomUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
    );
  }
}
