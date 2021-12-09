import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';

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
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Task state",
        textEditingController: _stateTextController,
        hintText: "Task state",
      ),
      // TODO TaskStateSelectInput
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
