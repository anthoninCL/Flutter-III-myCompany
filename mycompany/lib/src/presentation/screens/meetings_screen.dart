import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mycompany/src/blocs/meeting/meeting_bloc.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/presentation/widgets/custom_title.dart';
import 'package:mycompany/src/presentation/widgets/meeting_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({Key? key}) : super(key: key);

  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  final MeetingBloc _meetingBloc = MeetingBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userToken");
    if (userId != null) {
      _meetingBloc.add(GetMeetingsFromUser(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const CustomTitle(label: "Meetings"),
              BlocBuilder<MeetingBloc, MeetingState>(
                  bloc: _meetingBloc,
                  builder: (context, state) {
                    if (state is MeetingsLoaded) {
                      return _buildMeetingList(state);
                    } else if (state is MeetingError) {
                      return Center(child: Text(state.error));
                    }
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newMeeting').then(
                (value) {
              Future.delayed(const Duration(milliseconds: 200), () {
                init();
              });
            },
          );
        },
        child: const Icon(Icons.add, size: 30),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildMeetingList(MeetingsLoaded state) {
    state.meetings.sort((a, b) => b.dateStart.compareTo(a.dateStart));
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.meetings.length,
        itemBuilder: (context, index) {
          var startDate = DateTime.fromMillisecondsSinceEpoch(
              state.meetings[index].dateStart);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('dd MMMM').format(startDate),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat(' EEEE').format(startDate),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 10),
              MeetingCard(
                meeting: state.meetings[index],
                showDate: false,
              ),
              const SizedBox(height: 10),
            ],
          );
        });
  }
}
