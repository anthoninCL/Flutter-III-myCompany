import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/calendar_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/multiselect_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/task_state_input.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  final TextEditingController _estimatedTimeTextController =
      TextEditingController();
  final TextEditingController _userTextController = TextEditingController();
  String taskPriority = "None";
  DateTime deadline = DateTime.now().add(const Duration(days: 1));
  List<String> users = [];

  @override
  void initState() {
    super.initState();
    taskPriority = "None";
    deadline = DateTime.now().add(const Duration(days: 1));
    users = [];
  }

  void changePriority(String value) {
    setState(() {
      taskPriority = value;
    });
  }

  void changeDeadline(DateTime? date) {
    setState(() {
      deadline = date!;
    });
  }

  void changeUsers(List<String> newUsers) {
    setState(() {
      users = newUsers;
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
      CalendarInput(
        initialValue: deadline,
        onDeadlineChanged: changeDeadline,
        fieldTitle: "Deadline",
      ),
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Assignee",
        textEditingController: _userTextController,
        hintText: "Assignee",
      ),
      MultiSelectInput(
          items: const ['John', 'Bob', 'James', 'Mandy'],
          selectedItems: users,
          onChange: changeUsers,
          fieldTitle: "Users",
          onEmpty: "Select users")
    ]);
  }
}
