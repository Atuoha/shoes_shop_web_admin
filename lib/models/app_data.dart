import 'package:flutter/cupertino.dart';

class AppData {
  AppData({
    required this.title,
    required this.number,
    required this.color,
    required this.icon,
    this.index = 0,
  });

  final String title;
  final dynamic number;
  final IconData icon;
  final Color color;
  int index;
}
