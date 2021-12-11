import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/shared/utils/color_convertion.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/color_input.dart';

class ProjectForm extends StatefulWidget {
  const ProjectForm({Key? key}) : super(key: key);

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  Color pickerColor = const Color(0xFF0652DD);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
    print(getStringFromColor(pickerColor));
  }

  @override
  Widget build(BuildContext context) {
    return FormLayout(children: [
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Project name",
        textEditingController: _nameTextController,
        hintText: "Project name",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Project description",
        textEditingController: _descriptionTextController,
        hintText: "Project description",
      ),
      ColorInput(pickerColor: pickerColor, onColorChange: changeColor)
      // TODO TaskSelectInput
    ]);
  }
}
