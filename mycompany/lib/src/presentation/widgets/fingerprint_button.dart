import 'package:flutter/material.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';

class FingerPrintButton extends StatefulWidget {
  const FingerPrintButton({Key? key}) : super(key: key);

  @override
  _FingerPrintButtonState createState() => _FingerPrintButtonState();
}

class _FingerPrintButtonState extends State<FingerPrintButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary, width: 2)),
      child: const Icon(
        Icons.fingerprint,
        color: AppColors.primary,
        size: 40,
      ),
    );
  }
}
