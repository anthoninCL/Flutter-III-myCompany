import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/blocs/meetings/meetings_bloc.dart';
import 'package:mycompany_admin/src/models/meeting.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/widgets/form_basic_input.dart';
import 'package:mycompany_admin/src/widgets/form_layout.dart';
import 'package:mycompany_admin/src/widgets/inputs/datetime_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/meeting_duration_input.dart';
import 'package:mycompany_admin/src/widgets/inputs/users_input.dart';
import 'package:mycompany_admin/src/widgets/warning_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

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

  final MeetingBloc _meetingBloc = MeetingBloc();

  @override
  void initState() {
    super.initState();
    if (widget.meeting != null) {
      _nameTextController = TextEditingController(text: widget.meeting!.name);
      duration = "${widget.meeting!.duration.toString()} minutes";
      start =
          DateTime.fromMicrosecondsSinceEpoch(widget.meeting!.dateStart * 1000);
      users = widget.meeting!.users;
    } else {
      _nameTextController = TextEditingController(text: '');
      duration = "30 minutes";
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

  void onEdit(BuildContext context) async {
    if (_nameTextController.value.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var companyId = prefs.getString("companyId");
      if (companyId != null) {
        var meeting = Meeting(
            widget.meeting!.id,
            users,
            _nameTextController.text,
            start.millisecondsSinceEpoch,
            double.parse(duration.split(" ")[0]),
            companyId);
        _meetingBloc.add(UpdateMeeting(meeting));
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
    if (_nameTextController.value.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var companyId = prefs.getString("companyId");
      if (companyId != null) {
        var meeting = Meeting(
            Uuid().v4(),
            users,
            _nameTextController.text,
            start.millisecondsSinceEpoch,
            double.parse(duration.split(" ")[0]),
            companyId);
        _meetingBloc.add(AddMeeting(meeting));
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
    _meetingBloc.add(DeleteMeeting(widget.meeting!.id));
  }

  @override
  Widget build(BuildContext context) {
    return FormLayout(
        creation: widget.meeting != null ? false : true,
        // replace with widget.meeting ? true : false
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
            fieldTitle: "Meeting name",
            textEditingController: _nameTextController,
            hintText: "Meeting name",
          ),
          MeetingDurationInput(changeItem: changeDuration, initialItem: duration,),
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
