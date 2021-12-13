import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/blocs/tasks/tasks_bloc.dart';
import 'package:mycompany_admin/src/models/project.dart';
import 'package:mycompany_admin/src/models/task.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/calendar_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/projects_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/task_state_input.dart';
import 'package:mycompany_admin/src/widgets/warning_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key, this.task}) : super(key: key);

  final Task? task;

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final TextEditingController _nameTextController;
  late final TextEditingController _descriptionTextController;
  late final TextEditingController _estimatedTimeTextController;

  final TaskBloc _taskBloc = TaskBloc();

  String taskPriority = "None";
  DateTime deadline = DateTime.now().add(const Duration(days: 1));

  Project? projectSelected;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _nameTextController = TextEditingController(text: widget.task!.name);
      _descriptionTextController =
          TextEditingController(text: widget.task!.description);
      _estimatedTimeTextController =
          TextEditingController(text: widget.task!.estimatedTime.toString());
      taskPriority = widget.task!.state;
      deadline =
      widget.task!.deadLine != null ? DateTime.fromMicrosecondsSinceEpoch(
          widget.task!.deadLine! * 1000) : DateTime.now().add(
          const Duration(days: 1));
    } else {
      _nameTextController = TextEditingController(text: '');
      _descriptionTextController = TextEditingController(text: '');
      _estimatedTimeTextController = TextEditingController(text: '');
      taskPriority = "None";
      deadline = DateTime.now().add(const Duration(days: 1));
    }
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

  void onEdit(BuildContext context) async {
    if (_nameTextController.value.text.isNotEmpty &&
        _descriptionTextController.value.text.isNotEmpty &&
        _estimatedTimeTextController.value.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var companyId = prefs.getString("companyId");
      if (companyId != null) {
        var task = Task(widget.task!.id, _nameTextController.text,
            _descriptionTextController.text, double.parse(_estimatedTimeTextController.text),
            taskPriority);
        _taskBloc.add(AddTask(task, projectSelected!.id));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const WarningAlertDialog();
          });
    }
  }

  void onCreate(BuildContext context) async {
    if (_nameTextController.value.text.isNotEmpty &&
        _descriptionTextController.value.text.isNotEmpty &&
        _estimatedTimeTextController.value.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var companyId = prefs.getString("companyId");
      if (companyId != null) {
        var task = Task(Uuid().v4(), _nameTextController.text,
            _descriptionTextController.text, double.parse(_estimatedTimeTextController.text),
            taskPriority);
        _taskBloc.add(AddTask(task, projectSelected!.id));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const WarningAlertDialog();
          });
    }
  }

  void changeProject(Project project) {
    setState(() {
      projectSelected = project;
    });
  }

  void onDelete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getString("companyId");
    if (companyId != null) {
      _taskBloc.add(DeleteTask(widget.task!.id, companyId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormLayout(
        creation: widget.task != null ? false : true,
        // replace with widget.task ? true : false
        onEdit: () {
          onEdit(context);
        },
        onCreate: () {
          onCreate(context);
        },
        onDelete: () {
          onDelete();
        },
        children: [
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
          ProjectInput(
            multi: false,
            fieldTitle: 'Project',
            onEmpty: 'Select projects',
            selectedItem: projectSelected,
            onChange: changeProject,
          ),
        ]);
  }
}
