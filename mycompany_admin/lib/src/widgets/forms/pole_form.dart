import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';

class PoleForm extends StatefulWidget {
  const PoleForm({Key? key}) : super(key: key);

  @override
  _PoleFormState createState() => _PoleFormState();
}

class _PoleFormState extends State<PoleForm> {
  final TextEditingController _nameTextController = TextEditingController();
  final String color = "";

  @override
  Widget build(BuildContext context) {
    return FormLayout(children: [
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Project name",
        textEditingController: _nameTextController,
        hintText: "Project name",
      ),
      // TODO ColorInput
    ]);
  }
}
