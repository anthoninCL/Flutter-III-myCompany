import 'package:flutter/material.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.primary),
    );
  }
}
