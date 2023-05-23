import 'package:flutter/material.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

Future<void> areYouSureDialog({
  required String title,
  required String content,
  required BuildContext context,
  required Function action,
  bool isIdInvolved = false,
  String id = '',
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: getMediumStyle(
          color: Colors.black,
          fontSize: FontSize.s16,
        ),
      ),
      content: Text(content),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => isIdInvolved ? action(id) : action(),
          child: const Text('Yes'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Dismiss'),
        ),
      ],
    ),
  );
}