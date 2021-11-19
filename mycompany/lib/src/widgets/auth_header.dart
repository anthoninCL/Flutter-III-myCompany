import 'package:flutter/material.dart';
import 'package:mycompany/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColors.primary,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          style: const TextStyle(
              color: AppColors.grey, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
