import 'package:flutter/material.dart';

Color getColor(String color) {
  return Color(int.parse("0x${color.split("#")[1]}FF"));
}