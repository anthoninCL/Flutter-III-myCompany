import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/models/meeting.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/datetime_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/meeting_duration_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/users_input.dart';
import 'package:mycompany_admin/src/widgets/warning_alert_dialog.dart';

class MeetingForm extends StatefulWidget {
  const MeetingForm({Key? key, this.meeting}) : super(key: key);

  final Meeting? meeting;

  @override
  _MeetingFormState createState() => _MeetingFormState();
}

class _MeetingFormState extends State<MeetingForm> {
  late final TextEditingController _nameTextController;
  late String duration;
  DateTime start = DateTime.now().add(const Duration(hours: 1));
  late List<UserFront> users;

  @override
  void initState() {
    super.initState();
    if (widget.meeting != null) {
      _nameTextController = TextEditingController(text: widget.meeting!.name);
      duration = widget.meeting!.duration.toString();
      start = DateTime.fromMicrosecondsSinceEpoch(widget.meeting!.dateStart * 1000);
      users = widget.meeting!.users;
    } else {
      _nameTextController = TextEditingController(text: '');
      duration = "15min";
      start = DateTime.now().add(const Duration(hours: 1));
      users = [];
    }
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

  void changeUsers(List<UserFront> newUsers) {
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
        creation: widget.meeting != null ? false : true, // replace with widget.meeting ? true : false
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
          UserInput(
            multi: true,
            fieldTitle: "Users",
            onEmpty: "Select users",
            selectedItems: users,
            onMultiChange: changeUsers,
          )
        ]);
  }
}
