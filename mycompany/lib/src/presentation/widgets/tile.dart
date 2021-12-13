import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    bool isBlackOrWhite = Colors.black == color || Colors.white == color;

    return Container(
      decoration: BoxDecoration(
        color: isBlackOrWhite ? Colors.transparent : color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: isBlackOrWhite ? Border.all(color: Colors.black) : Border.all(color: Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
        child: Text(label, style: TextStyle(color: isBlackOrWhite ? Colors.black : color, fontSize: 14),),
      ),
    );
  }
}
