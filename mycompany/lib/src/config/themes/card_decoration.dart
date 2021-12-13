import 'package:flutter/material.dart';

BoxDecoration CardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        blurRadius: 6,
        offset: const Offset(0, 0),
      ),
    ],
  );
}