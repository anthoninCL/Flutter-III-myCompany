import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/action_buttons_bar.dart';

class FormLayout extends StatefulWidget {
  const FormLayout(
      {Key? key,
      required this.children,
      this.onCreate,
      this.onEdit,
      this.onDelete, required this.creation})
      : super(key: key);

  final List<Widget> children;
  final VoidCallback? onCreate;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool creation;

  @override
  _FormLayoutState createState() => _FormLayoutState();
}

class _FormLayoutState extends State<FormLayout> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: ActionButtonBar(
              creation: widget.creation,
              onCreate: widget.onCreate,
              onEdit: widget.onEdit,
              onDelete: widget.onDelete,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children,
            ),
          ),
        ],
      ),
    );
  }
}
