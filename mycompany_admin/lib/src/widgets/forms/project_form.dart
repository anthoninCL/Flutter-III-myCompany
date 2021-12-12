import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/shared/utils/color_convertion.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/color_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/multiselect_input.dart';

class ProjectForm extends StatefulWidget {
  const ProjectForm({Key? key}) : super(key: key);

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  Color pickerColor = const Color(0xFF0652DD);
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    pickerColor = const Color(0xFF0652DD);
    tasks = [];
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
    print(getStringFromColor(pickerColor));
  }
  void changeTasks(List<String> newTasks) {
    setState(() {
      tasks = newTasks;
    });
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
      ColorInput(pickerColor: pickerColor, onColorChange: changeColor),
      MultiSelectInput(
          items: const ['Task 1', 'Task 2', 'Task 3', 'Task 4'],
          selectedItems: tasks,
          onChange: changeTasks,
          fieldTitle: "Tasks",
          onEmpty: "Select tasks")
    ]);
  }
}