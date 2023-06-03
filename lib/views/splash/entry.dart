import 'dart:async';

import 'package:flutter/material.dart';
import '../../resources/assets_manager.dart';
import '../../controllers/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {

  // check if authenticated
  checkIfAuthenticated() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // isAuthenticated

        Timer(
          const Duration(seconds: 2),
          () => Navigator.of(context).pushNamedAndRemoveUntil(
            RouteManager.mainScreen,
            (route) => false,
          ),
        );
      } else {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.of(context).pushNamedAndRemoveUntil(
            RouteManager.authScreen,
            (route) => false,
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AssetManager.logoTransparent, width: 100),
      ),
    );
  }
}
