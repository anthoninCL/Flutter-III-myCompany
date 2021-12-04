import 'package:flutter/material.dart';
import 'app_subtitle.dart';
import 'app_title.dart';

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
        AppTitle(title: title),
        const SizedBox(
          height: 50,
        ),
        AppSubtitle(title: subtitle)
      ],
    );
  }
}
