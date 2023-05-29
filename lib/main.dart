import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoes_shop_admin/resources/theme_manager.dart';
import 'package:shoes_shop_admin/views/splash/entry.dart';
import 'constants/color.dart';
import 'controllers/route_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ErrorWidget.builder = (FlutterErrorDetails details) => Container();

  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid
        ? const FirebaseOptions(
            apiKey: 'AIzaSyCJz736z-bm1Gg5uxFPMNJQ01OkroZWBvo',
            appId: "1:719326293072:web:99cc06ab4dad526f603555",
            messagingSenderId: "719326293072",
            projectId: "shoeshop-87640",
            storageBucket: "shoeshop-87640.appspot.com",
            measurementId: "G-SND807S5J5",
            authDomain: "shoeshop-87640.firebaseapp.com",
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

    EasyLoading.instance
      ..backgroundColor = primaryColor
      ..progressColor = Colors.white
      ..loadingStyle = EasyLoadingStyle.light;

    return MaterialApp(
      theme: getLightTheme(),
      title: 'Shoes Shop',
      debugShowCheckedModeBanner: false,
      home: const EntryScreen(),
      routes: routes,
      builder: EasyLoading.init(),
    );
  }
}
