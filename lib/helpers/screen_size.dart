import 'package:flutter/material.dart';

extension BuildCxtExt on BuildContext {
  get screenSize {
    final screenWidth = MediaQuery.of(this).size.width;
    return screenWidth < 600; // Adjust the threshold as needed
  }
}
