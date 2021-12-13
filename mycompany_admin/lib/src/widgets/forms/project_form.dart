import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/models/task.dart';
import 'package:mycompany_admin/src/shared/utils/color_convertion.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/color_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/tasks_input.dart';
import 'package:mycompany_admin/src/widgets/warning_alert_dialog.dart';

class ProjectForm extends StatefulWidget {
  const ProjectForm({Key? key}) : super(key: key);

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  Color pickerColor = const Color(0xFF0652DD);
  List<Task> tasks = [];

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

  void changeTasks(List<Task> newTasks) {
    setState(() {
      tasks = newTasks;
    });
  }

  void onEdit(BuildContext context) {
    if (_nameTextController.value.text.isNotEmpty &&
        _descriptionTextController.value.text.isNotEmpty &&
        getStringFromColor(pickerColor).isNotEmpty) {
      print("Edit");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const WarningAlertDialog();
          });
    }
  }

  void onCreate(BuildContext context) {
    if (_nameTextController.value.text.isNotEmpty &&
        _descriptionTextController.value.text.isNotEmpty &&
        getStringFromColor(pickerColor).isNotEmpty) {
      print("Create");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const WarningAlertDialog();
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormLayout(
        creation: false, // replace with widget.project ? true : false
        onEdit: () {
          onEdit(context);
        },
        onCreate: () {
          onCreate(context);
        },
        children: [
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
          TaskInput(
            multi: true,
            fieldTitle: 'Tasks',
            onEmpty: 'Select Tasks',
            selectedItems: tasks,
            onMultiChange: changeTasks,
          )
        ]);
  }
}
