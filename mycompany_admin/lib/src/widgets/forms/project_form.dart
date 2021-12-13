import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/blocs/projects/projects_bloc.dart';
import 'package:mycompany_admin/src/models/project.dart';
import 'package:mycompany_admin/src/models/task.dart';
import 'package:mycompany_admin/src/shared/utils/color_convertion.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/color_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/tasks_input.dart';
import 'package:mycompany_admin/src/widgets/warning_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ProjectForm extends StatefulWidget {
  const ProjectForm({Key? key, this.project}) : super(key: key);

  final Project? project;

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  late final TextEditingController _nameTextController;
  late final TextEditingController _descriptionTextController;
  late Color pickerColor;
  late List<Task> tasks;

  final ProjectBloc _projectBloc = ProjectBloc();

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      _nameTextController = TextEditingController(text: widget.project!.name);
      _descriptionTextController =
          TextEditingController(text: widget.project!.description);
      pickerColor = getColorFromString(widget.project!.color);
      tasks = widget.project!.tasks;
    } else {
      _nameTextController = TextEditingController(text: '');
      _descriptionTextController = TextEditingController(text: '');
      pickerColor = const Color(0xFF0652DD);
      tasks = [];
    }
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

  Future<void> onEdit(BuildContext context) async {
    if (_nameTextController.value.text.isNotEmpty &&
        _descriptionTextController.value.text.isNotEmpty &&
        getStringFromColor(pickerColor).isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var companyId = prefs.getString("companyId");
      if (companyId != null) {
        var project = Project(widget.project!.id, _nameTextController.text,
            _descriptionTextController.text, getStringFromColor(pickerColor),
            tasks, companyId);
        _projectBloc.add(UpdateProject(project));
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
        getStringFromColor(pickerColor).isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var companyId = prefs.getString("companyId");
      if (companyId != null) {
        var project = Project(Uuid().v4(), _nameTextController.text,
            _descriptionTextController.text, getStringFromColor(pickerColor),
            tasks, companyId);
        _projectBloc.add(AddProject(project));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const WarningAlertDialog();
          });
    }
  }

  void onDelete() {
    _projectBloc.add(DeleteProject(widget.project!.id));
  }

  @override
  Widget build(BuildContext context) {
    return FormLayout(
        creation: widget.project != null ? false : true,
        // replace with widget.project ? true : false
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
