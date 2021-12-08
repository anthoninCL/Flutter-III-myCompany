import 'package:flutter/material.dart';
import 'package:mycompany/theme/app_colors.dart';

class AppTitle extends StatelessWidget {
  const AppTitle(
      {Key? key,
      required this.title,
      this.color = AppColors.primary,
      this.fontSize = 30,
      this.textAlign = TextAlign.start,
      this.fontWeight = FontWeight.bold})
      : super(key: key);

  final String title;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
