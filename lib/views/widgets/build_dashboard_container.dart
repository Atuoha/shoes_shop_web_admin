import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../main/main_screen.dart';

class BuildDashboardContainer extends StatelessWidget {
  const BuildDashboardContainer({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.index,
  }) : super(key: key);
  final String title;
  final int value;
  final Color color;
  final IconData icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        title,
                        style: getMediumStyle(
                          fontSize: FontSize.s16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      value.toString(),
                      style: getBoldStyle(
                        fontSize: FontSize.s30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(icon, color: accentColor),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MainScreen(index: index),
                ),
              ),
              child: Text(
                'view more',
                style: getRegularStyle(color: accentColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
