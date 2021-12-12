import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/datetime_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/meeting_duration_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/multiselect_input.dart';
import 'package:mycompany_admin/src/widgets/warning_alert_dialog.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class MeetingForm extends StatefulWidget {
  const MeetingForm({Key? key}) : super(key: key);

  @override
  _MeetingFormState createState() => _MeetingFormState();
}

class _MeetingFormState extends State<MeetingForm> {
  final TextEditingController _nameTextController = TextEditingController();
  String duration = "15min";
  DateTime start = DateTime.now().add(const Duration(hours: 1));
  List<String> users = ['John', 'Bob'];

  @override
  void initState() {
    super.initState();
    duration = "15min";
    start = DateTime.now().add(const Duration(hours: 1));
    users = ['John', 'Bob'];
  }

  void changeDuration(String value) {
    setState(() {
      duration = value;
    });
  }

  void changeStart(DateTime value) {
    setState(() {
      start = value;
    });
  }

  void changeUsers(List<String> newUsers) {
    setState(() {
      users = newUsers;
    });
  }

  void onEdit(BuildContext context) {
    if (_nameTextController.value.text.isNotEmpty) {
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
    if (_nameTextController.value.text.isNotEmpty) {
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
        creation: false, // replace with widget.meeting ? true : false
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
          MeetingDurationInput(changeItem: changeDuration),
          DateTimeInput(
              onValueChanged: changeStart,
              initialValue: start,
              fieldTitle: "Schedule"),
          MultiSelectInput(
              items: const ['John', 'Bob', 'James', 'Mandy'],
              selectedItems: users,
              onChange: changeUsers,
              fieldTitle: "Users",
              onEmpty: "Select users")
        ]);
  }
}
