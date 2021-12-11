import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/meeting_duration_input.dart';

class MeetingForm extends StatefulWidget {
  const MeetingForm({Key? key}) : super(key: key);

  @override
  _MeetingFormState createState() => _MeetingFormState();
}

class _MeetingFormState extends State<MeetingForm> {
  final TextEditingController _nameTextController = TextEditingController();
  String duration = "15min";

  @override
  void initState() {
    super.initState();
    duration = "15min";
  }

  void changeDuration(String value) {
    setState(() {
      duration = value;
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
      // TODO UserSelectInput
      // TODO DateTimeInput
      // TODO MeetingDurationInput
    ]);
  }
}
