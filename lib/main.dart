import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoes_shop_admin/resources/theme_manager.dart';
import 'package:shoes_shop_admin/views/splash/entry.dart';
import 'controllers/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid
        ? const FirebaseOptions(
            apiKey: 'AIzaSyCJz736z-bm1Gg5uxFPMNJQ01OkroZWBvo',
            appId: "1:719326293072:web:99cc06ab4dad526f603555",
            messagingSenderId: "719326293072",
            projectId: "shoeshop-87640",
            storageBucket: "shoeshop-87640.appspot.com",
          )
        : null,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      theme: getLightTheme(),
      title: 'Shoes Shop',
      debugShowCheckedModeBanner: false,
      home: const EntryScreen(),
      routes: routes,
    );
  }
}
