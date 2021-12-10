import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/action_buttons_bar.dart';

class FormLayout extends StatefulWidget {
  const FormLayout({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  _FormLayoutState createState() => _FormLayoutState();
}

class _FormLayoutState extends State<FormLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: const ActionButtonBar(creation: false,),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children,
            ),
          ),
        ),
      ],
    );
  }
}
