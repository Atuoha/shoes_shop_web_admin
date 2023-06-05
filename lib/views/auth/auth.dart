import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

import '../../resources/assets_manager.dart';
import '../main/main_screen.dart';

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
          return SignInScreen(
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Welcome back to ShoesShop! Please sign in to continue.'
                      : 'Welcome to ShoesShop! Please create an account to continue',
                ),
              );
            },
            footerBuilder: (context, _) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(AssetManager.logoTransparent, width: 100),
              );
            },
            providers: [
              EmailAuthProvider(),
              PhoneAuthProvider(),
              GoogleProvider(
                clientId:
                    '719326293072-q9ao67f1nolt50ev21om8bou759cr4mk.apps.googleusercontent.com',
              ),
            ],
          );
        }

        // Render your application if authenticated
        return const MainScreen();
      },
    );
  }
}
