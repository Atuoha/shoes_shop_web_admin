import 'dart:async';

import 'package:flutter/material.dart';
import '../../resources/assets_manager.dart';
import '../../controllers/route_manager.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
       Navigator.of(context).pushNamed(RouteManager.mainScreen);
     });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AssetManager.logoTransparent,width:100),
      ),
    );
  }
}
