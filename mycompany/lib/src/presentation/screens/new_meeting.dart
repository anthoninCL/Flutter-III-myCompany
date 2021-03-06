import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:mycompany/src/blocs/meeting/meeting_bloc.dart';
import 'package:mycompany/src/blocs/user/user_bloc.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/config/themes/card_decoration.dart';
import 'package:mycompany/src/models/meeting.dart';
import 'package:mycompany/src/models/user.dart';
import 'package:mycompany/src/presentation/widgets/classic_text_input.dart';
import 'package:mycompany/src/presentation/widgets/custom_date_picker.dart';
import 'package:mycompany/src/presentation/widgets/header_label.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class NewMeeting extends StatefulWidget {
  const NewMeeting({Key? key}) : super(key: key);

  @override
  _NewMeetingState createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  late TextEditingController _meetingNameController;
  late TextEditingController _meetingLocationController;

  final UserBloc _userBloc = UserBloc();
  final MeetingBloc _meetingBloc = MeetingBloc();

  List<String> _attendees = [];

  int duration = 0;

  DateTime start = DateTime.now();

  String? companyId;

  @override
  void initState() {
    init();
    super.initState();
    _meetingNameController = TextEditingController();
    _meetingLocationController = TextEditingController();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    companyId = prefs.getString("companyId");
    if (companyId != null) {
      _userBloc.add(GetUsersFromCompany(companyId!));
    }
  }

  @override
  void dispose() {
    _meetingNameController.dispose();
    _meetingLocationController.dispose();
    super.dispose();
  }

  showDurationPickerModal(BuildContext context) async {
    await Picker(
        adapter: PickerDataAdapter(data: [
          PickerItem(text: const Text("5 minutes"), value: "5"),
          PickerItem(text: const Text("10 minutes"), value: "10"),
          PickerItem(text: const Text("15 minutes"), value: "15"),
          PickerItem(text: const Text("30 minutes"), value: "30"),
          PickerItem(text: const Text("45 minutes"), value: "45"),
          PickerItem(text: const Text("1 hour"), value: "60"),
        ]),
        changeToFirst: false,
        hideHeader: false,
        onConfirm: (picker, value) {
          setState(() {
            duration = int.parse(
                picker.adapter.text.replaceAll(RegExp(r'[^\w\s]+'), ''));
          });
        }).showModal(this.context);
  }

  void _onTapDone(state) {
    List<UserFront> users = [];
    for (var attendee in _attendees) {
      var user = state.users.firstWhere((user) {
        var name = attendee.split(" ");
        return user.firstName == name[0] && user.lastName == name[1];
      });
      users.add(user);
    }
    var meeting = Meeting(
        Uuid().v4().toString(),
        users,
        _meetingNameController.text,
        start.millisecondsSinceEpoch,
        duration.toDouble(),
        companyId!);
    _meetingBloc.add(AddMeeting(meeting));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("New Meeting"),
              actions: [
                GestureDetector(
                  onTap: () {
                    _onTapDone(state);
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Center(
                      child: Text(
                        "Add",
                        style:
                            TextStyle(fontSize: 16, color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderLabel(label: "Meeting name"),
                  ClassicTextInput(
                    controller: _meetingNameController,
                    placeholder: "Write your meeting name",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const HeaderLabel(label: "Attendees"),
                  _buildAttendeesSelection(state),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildAttendeesList(),
                  const SizedBox(
                    height: 15,
                  ),
                  const HeaderLabel(label: "Location"),
                  ClassicTextInput(
                    controller: _meetingLocationController,
                    placeholder: "Write the application for the meeting",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildScheduleSelection(),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildAttendeesSelection(UserState state) {
    List<String> users = state is UsersLoaded
        ? state.users
            .map((user) => "${user.firstName} ${user.lastName}")
            .toList()
        : [];
    return Container(
      decoration: CardDecoration(),
      child: Autocomplete(
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            onEditingComplete: onEditingComplete,
            onSubmitted: (value) {
              if (_attendees.contains(value)) return;
              setState(() {
                _attendees.add(value);
              });
            },
            cursorColor: AppColors.grey,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Add attendees",
              contentPadding: EdgeInsets.only(left: 20, bottom: 5),
            ),
          );
        },
        optionsViewBuilder: (context, Function(String) onSelected, options) {
          return Padding(
            padding: const EdgeInsets.only(right: 40.0, bottom: 600),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 4,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final option = options.elementAt(index);

                    return ListTile(
                      title: Text(option.toString()),
                      onTap: () {
                        onSelected(option.toString());
                      },
                    );
                  },
                  itemCount: options.length),
            ),
          );
        },
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return users.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          if (_attendees.contains(selection)) return;
          setState(() {
            _attendees.add(selection);
          });
        },
      ),
    );
  }

  Widget _buildAttendeesList() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: _attendees.map((attendee) {
        return Container(
          decoration: CardDecoration(),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _attendees = _attendees
                        .where((element) => element != attendee)
                        .toList();
                  });
                },
                child: Text(
                  attendee,
                  style: const TextStyle(fontSize: 14),
                ),
              )),
        );
      }).toList(),
    );
  }

  Widget _buildScheduleSelection() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: CardDecoration(),
      child: Column(
        children: [
          CustomDatePicker(
            label: "Start at",
            date: start,
            onPress: (date) {
              setState(() {
                start = date;
              });
            },
            format: "HH:mm - dd MMM. yyyy",
            datePickerType: "dateAndTime",
          ),
          SizedBox(
            height: 10,
          ),
          _buildDuration()
        ],
      ),
    );
  }

  Widget _buildDuration() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Duration (min):",
          style: TextStyle(fontSize: 14),
        ),
        GestureDetector(
          onTap: () {
            showDurationPickerModal(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 5,
            height: 30,
            decoration: CardDecoration(),
            child: Center(
              child: Text(
                duration.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        )
      ],
    );
  }
}
