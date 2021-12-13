import 'package:flutter/material.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class WarningAlertDialog extends StatelessWidget {
  const WarningAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Warning',
        style: TextStyle(
            color: AppColors.red, fontWeight: FontWeight.bold),
      ),
      content: const Text(
        'Every field is required, please fill all fields',
        style: TextStyle(color: AppColors.black),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Got it'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
