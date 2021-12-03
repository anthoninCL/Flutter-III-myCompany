import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/domain/entities/task.dart';
import 'package:mycompany/src/presentation/widgets/classic_text_input.dart';
import 'package:mycompany/src/presentation/widgets/custom_date_picker.dart';
import 'package:mycompany/src/presentation/widgets/header_label.dart';
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

  String projectSelected = "";

  bool isNone = true;
  bool isLow = false;
  bool isMedium = false;
  bool isHigh = false;
  String selectedPriority = "None";

  int estimatedTime = 0;

  bool isDeadLine = false;
  DateTime deadline = DateTime.now();

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

  showProjectPickerModal(BuildContext context) async {
    await Picker(
        adapter: PickerDataAdapter(data: [
          PickerItem(text: Text("Project 1"), value: "Project 1"),
          PickerItem(text: Text("Project 2"), value: "Project 2"),
          PickerItem(text: Text("Project 3"), value: "Project 3"),
        ]),
        changeToFirst: false,
        hideHeader: false,
        onConfirm: (picker, value) {
          setState(() {
            projectSelected =
                picker.adapter.text.replaceAll(RegExp(r'[^\w\s]+'), '');
          });
        }).showModal(this.context);
  }

  showEstimatedTimePickerModal(BuildContext context) async {
    await Picker(
        adapter: PickerDataAdapter(data: List.generate(20, (index) {
          return PickerItem(text: Text("${index + 1} days"), value: "${index + 1}");
        })),
        changeToFirst: false,
        hideHeader: false,
        onConfirm: (picker, value) {
          setState(() {
            estimatedTime = int.parse(
                picker.adapter.text.replaceAll(RegExp(r'[^\w\s]+'), ''));
          });
        }).showModal(this.context);
  }

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController();
    _taskDescriptionController = TextEditingController();
    _taskEstimatedTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    _taskEstimatedTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("New task"), actions: [
        GestureDetector(
          onTap: () {
            var task = Task(
                id: const Uuid().v4(),
                name: _taskNameController.text,
                description: _taskDescriptionController.text,
                estimatedTime: estimatedTime.toDouble(),
                deadline: deadline.millisecondsSinceEpoch,
                state: "Todo",
                priority: selectedPriority);
            print(task);
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Center(
              child: Text(
                "Add",
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
            const HeaderLabel(label: "Task Name"),
            ClassicTextInput(
                controller: _taskNameController,
                placeholder: "Write your task here"),
            const SizedBox(
              height: 15,
            ),
            const HeaderLabel(label: "Description"),
            _buildDescriptionInput(),
            const SizedBox(
              height: 15,
            ),
            const HeaderLabel(label: "Project"),
            _buildProjectPicker(),
            const SizedBox(
              height: 15,
            ),
            const HeaderLabel(label: "Priority"),
            _buildPriorityPicker(),
            const SizedBox(
              height: 20,
            ),
            _buildEstimatedTime(),
            const SizedBox(
              height: 15,
            ),
            const HeaderLabel(label: "Dead line"),
            _buildDeadLine(),
          ],
        ),
      ),
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

  Widget _buildProjectPicker() {
    return GestureDetector(
      onTap: () {
        showProjectPickerModal(context);
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
              projectSelected.isNotEmpty ? projectSelected : "Select a project",
              style: TextStyle(
                  fontSize: 14,
                  color: projectSelected.isNotEmpty
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
            child: CustomDatePicker(
              label: "Select a deadline",
              date: deadline,
              onPress: (date) {
                setState(() {
                  deadline = date;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
