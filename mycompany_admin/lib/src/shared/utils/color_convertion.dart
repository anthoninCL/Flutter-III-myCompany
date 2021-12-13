import 'package:flutter/material.dart';

String getStringFromColor(Color color) {
  String colorString = color.toString();
  String valueString = colorString.split('(0x')[1].split(')')[0];

  return valueString;
}

Color getColorFromString(String color) {
  int value = int.parse(color, radix: 16);
  Color otherColor = Color(value);

  return otherColor;
}