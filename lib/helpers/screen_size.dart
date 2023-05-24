import 'package:flutter/material.dart';

bool isSmallScreen(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  return screenWidth < 600; // Adjust the threshold as needed
}