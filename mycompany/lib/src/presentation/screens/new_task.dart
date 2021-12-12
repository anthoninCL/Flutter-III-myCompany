import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:mycompany/src/blocs/project/project_bloc.dart';
import 'package:mycompany/src/blocs/task/task_bloc.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/models/project.dart';
import 'package:mycompany/src/models/task.dart';
import 'package:mycompany/src/presentation/widgets/classic_text_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  late TextEditingController _taskNameController;
  late TextEditingController _taskDescriptionController;
  late TextEditingController _taskEstimatedTimeController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Project? projectSelected;

  bool isNone = true;
  bool isLow = false;
  bool isMedium = false;
  bool isHigh = false;
  String selectedPriority = "None";

  int estimatedTime = 0;

  bool isDeadLine = false;
  DateTime deadline = DateTime.now();

  final TaskBloc _taskBloc = TaskBloc();
  final ProjectBloc _projectBloc = ProjectBloc();

  void selectPriority(String label) {
    setState(() {
      selectedPriority = label;
    });
    switch (label) {
      case "None":
        setState(() {
          isNone = true;
          isLow = false;
          isMedium = false;
          isHigh = false;
        });
        break;
      case "Low":
        setState(() {
          isNone = false;
          isLow = true;
          isMedium = false;
          isHigh = false;
        });
        break;
      case "Medium":
        setState(() {
          isNone = false;
          isLow = false;
          isMedium = true;
          isHigh = false;
        });
        break;
      case "High":
        setState(() {
          isNone = false;
          isLow = false;
          isMedium = false;
          isHigh = true;
        });
        break;
      default:
        setState(() {
          isNone = true;
          isLow = false;
          isMedium = false;
          isHigh = false;
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    _taskNameController = TextEditingController();
    _taskDescriptionController = TextEditingController();
    _taskEstimatedTimeController = TextEditingController();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getString("companyId");
    if (companyId != null) {
    }
    _projectBloc.add(GetProjectsFromCompany("8ca236d2-f85f-46ef-ae8f-dae4b7e97236"));
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    _taskEstimatedTimeController.dispose();
    super.dispose();
  }

  bool getPriority(String label) {
    switch (label) {
      case "None":
        return isNone;
      case "Low":
        return isLow;
      case "Medium":
        return isMedium;
      case "High":
        return isHigh;
      default:
        return isNone;
    }
  }

  showProjectPickerModal(BuildContext context, ProjectState state) async {
    await Picker(
        adapter: PickerDataAdapter(
          data: state is ProjectsLoaded && state.projects.isNotEmpty
              ? state.projects.map(
                  (project) {
                    return PickerItem(text: Text(project.name), value: project.name);
                  },
                ).toList()
              : [PickerItem(text: const Text("No project found"))],
        ),
        changeToFirst: false,
        hideHeader: false,
        onConfirm: (picker, value) {
          if (state is ProjectsLoaded) {
            var itemSelected =
                picker.adapter.text.replaceAll(RegExp(r'[^\w\s]+'), '');
            print("item selected: $itemSelected");
            var project =
                state.projects.firstWhere((elem) => elem.name == itemSelected);
            setState(() {
              projectSelected = project;
            });
          }
        }).showModal(this.context);
  }

  showEstimatedTimePickerModal(BuildContext context) async {
    await Picker(
        adapter: PickerDataAdapter(data:
          List.generate(20, (index) => PickerItem(text: Text("${index + 1} days"), value: "${index + 1}")),
        ),
        changeToFirst: false,
        hideHeader: false,
        onConfirm: (picker, value) {
          setState(() {
            estimatedTime = int.parse(
                picker.adapter.text.replaceAll(RegExp(r'[^\w\s]+'), ''));
          });
        }).showModal(this.context);
  }

  void onTapDone(context) {
    var task = Task(
      const Uuid().v4(),
      _taskNameController.text,
      _taskDescriptionController.text,
      estimatedTime.toDouble(),
      "Todo",
      selectedPriority,
      deadLine: isDeadLine ? deadline.millisecondsSinceEpoch : null,
    );
    _taskBloc.add(AddTask(task, projectSelected!.id));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("New task"), actions: [
        GestureDetector(
          onTap: () => onTapDone(context),
          child: const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Center(
              child: Text(
                "Done",
                style: TextStyle(fontSize: 16, color: AppColors.primary),
              ),
            ),
          ),
        ),
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderText("Task Name"),
            ClassicTextInput(
                controller: _taskNameController,
                placeholder: "Write your task here"),
            const SizedBox(
              height: 15,
            ),
            _buildHeaderText("Description"),
            _buildDescriptionInput(),
            const SizedBox(
              height: 15,
            ),
            _buildHeaderText("Project"),
            BlocBuilder<ProjectBloc, ProjectState>(
                bloc: _projectBloc,
                builder: (context, state) {
                  return _buildProjectPicker(state);
                }),
            const SizedBox(
              height: 15,
            ),
            _buildHeaderText("Priority"),
            _buildPriorityPicker(),
            const SizedBox(
              height: 20,
            ),
            _buildEstimatedTime(),
            const SizedBox(
              height: 15,
            ),
            _buildHeaderText("Dead line"),
            _buildDeadLine(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText(String label) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, color: AppColors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildDescriptionInput() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        controller: _taskDescriptionController,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.go,
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Write your description here",
        ),
        maxLength: 500,
      ),
    );
  }

  Widget _buildProjectPicker(state) {
    return GestureDetector(
      onTap: () {
        showProjectPickerModal(context, state);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              projectSelected != null ? projectSelected!.name : "Select a project",
              style: TextStyle(
                  fontSize: 14,
                  color: projectSelected != null
                      ? Colors.black
                      : AppColors.grey),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.grey,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPriorityPickerItem("None"),
        _buildPriorityPickerItem("Low"),
        _buildPriorityPickerItem("Medium"),
        _buildPriorityPickerItem("High"),
      ],
    );
  }

  Widget _buildPriorityPickerItem(String label) {
    return GestureDetector(
      onTap: () {
        selectPriority(label);
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 70) / 4,
        height: 30,
        decoration: BoxDecoration(
          color: getPriority(label) ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Center(
            child: Text(
          label,
          style: TextStyle(
              fontSize: 14,
              color: getPriority(label) ? Colors.white : AppColors.grey),
        )),
      ),
    );
  }

  Widget _buildEstimatedTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Estimated Time:",
          style: TextStyle(fontSize: 14),
        ),
        GestureDetector(
          onTap: () {
            showEstimatedTimePickerModal(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 5,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 6,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                estimatedTime.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDeadLine() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Do you want a dead line",
                style: TextStyle(fontSize: 14),
              ),
              CupertinoSwitch(
                activeColor: AppColors.primary,
                value: isDeadLine,
                onChanged: (bool value) {
                  setState(() {
                    isDeadLine = value;
                  });
                },
              ),
            ],
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: !isDeadLine ? 0 : 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(context, showTitleActions: true,
                        onConfirm: (date) {
                      setState(() {
                        deadline = date;
                      });
                    }, currentTime: deadline);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Select a deadline",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                Text(
                  DateFormat('EE dd MMM. yyyy').format(deadline),
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
