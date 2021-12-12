import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';

class AuthRichText extends StatelessWidget {
  const AuthRichText(
      {Key? key,
        required this.content,
        required this.richContent,
        required this.onTap})
      : super(key: key);

  final String content;
  final String richContent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle =
    const TextStyle(color: AppColors.black, fontSize: 14);
    TextStyle linkStyle = const TextStyle(
        color: AppColors.primary,
        fontSize: 14,
        decoration: TextDecoration.underline);

    return RichText(
        text: TextSpan(style: defaultStyle, children: <TextSpan>[
          TextSpan(text: content),
          TextSpan(
              text: richContent,
              style: linkStyle,
              recognizer: TapGestureRecognizer()..onTap = onTap)
        ]));
  }
}