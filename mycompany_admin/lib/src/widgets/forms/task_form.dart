import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/task_state_input.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  final TextEditingController _estimatedTimeTextController = TextEditingController();
  final TextEditingController _stateTextController = TextEditingController();
  final TextEditingController _deadlineTextController = TextEditingController();
  final TextEditingController _userTextController = TextEditingController();
  String taskPriority = "None";

  @override
  void initState() {
    super.initState();
    taskPriority = "None";
  }

  void changePriority(String value) {
    setState(() {
      taskPriority = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormLayout(children: [
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Task name",
        textEditingController: _nameTextController,
        hintText: "Task name",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Task description",
        textEditingController: _descriptionTextController,
        hintText: "Task description",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Estimated time",
        textEditingController: _estimatedTimeTextController,
        hintText: "Estimated time",
      ),
      TaskStateInput(changeItem: changePriority),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Deadline",
        textEditingController: _deadlineTextController,
        hintText: "Deadline",
      ),
      // TODO CalendarInput
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Assignee",
        textEditingController: _userTextController,
        hintText: "Assignee",
      ),
      // TODO UserSelectInput
    ]);
  }
}
