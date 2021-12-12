import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/datetime_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/meeting_duration_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/multiselect_input.dart';

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

  @override
  Widget build(BuildContext context) {
    return FormLayout(children: [
      FormBasicInput(
        readOnly: false,
        fieldTitle: "Project name",
        textEditingController: _nameTextController,
        hintText: "Project name",
      ),
      MeetingDurationInput(changeItem: changeDuration),
      DateTimeInput(onValueChanged: changeStart, initialValue: start, fieldTitle: "Schedule"),
      MultiSelectInput(items: const ['John', 'Bob', 'James', 'Mandy'], selectedItems: users, onChange: changeUsers, fieldTitle: "Users", onEmpty: "Select users")
    ]);
  }
}
