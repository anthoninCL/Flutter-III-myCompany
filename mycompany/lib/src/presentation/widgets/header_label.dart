import 'package:flutter/material.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';

class HeaderLabel extends StatelessWidget {
  const HeaderLabel({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, color: AppColors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
