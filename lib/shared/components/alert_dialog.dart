import 'package:flutter/material.dart';

showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required String text,
  required Function confirmButtonTap,
  TextField? textField,
}) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: textField ?? SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(text),
          ),
          actions: [
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                confirmButtonTap();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
