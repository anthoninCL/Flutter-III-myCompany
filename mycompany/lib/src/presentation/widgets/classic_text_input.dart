import 'package:flutter/material.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';

class ClassicTextInput extends StatefulWidget {
  const ClassicTextInput({Key? key, required this.controller, required this.placeholder, this.secure = false}) : super(key: key);

  final TextEditingController controller;
  final String placeholder;
  final bool secure;

  @override
  _ClassicTextInputState createState() => _ClassicTextInputState();
}

class _ClassicTextInputState extends State<ClassicTextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        obscureText: widget.secure,
        enableSuggestions: !widget.secure,
        autocorrect: !widget.secure,
        controller: widget.controller,
        cursorColor: AppColors.grey,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.placeholder,
          contentPadding: const EdgeInsets.only(left: 20, bottom: 5),
        ),
      ),
    );
  }
}