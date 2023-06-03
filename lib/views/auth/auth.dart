import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, PhoneAuthProvider;
import '../main/home_screen.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return  SignInScreen(
             providers: [
               EmailAuthProvider(),
               PhoneAuthProvider(),
               GoogleProvider(clientId: '719326293072-q9ao67f1nolt50ev21om8bou759cr4mk.apps.googleusercontent.com'),
             ],
          );
        }

        // Render your application if authenticated
        return HomeScreen();
      },
    );
  }
}
