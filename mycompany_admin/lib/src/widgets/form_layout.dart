import 'package:flutter/material.dart';

class FormLayout extends StatefulWidget {
  const FormLayout({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  _FormLayoutState createState() => _FormLayoutState();
}

class _FormLayoutState extends State<FormLayout> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.children,
      ),
    );
  }
}
