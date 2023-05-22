import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoes_shop_admin/views/splash/entry.dart';
import 'controllers/route_manager.dart';

void main() {
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
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EntryScreen(),
      routes:routes,
    );
  }
}
