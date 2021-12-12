import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mycompany/src/blocs/meeting/meeting_bloc.dart';
import 'package:mycompany/src/blocs/task/task_bloc.dart';
import 'package:mycompany/src/blocs/user/user_bloc.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/presentation/shared/utils/color_extension.dart';
import 'package:mycompany/src/presentation/widgets/meeting_card.dart';
import 'package:mycompany/src/presentation/widgets/task_card.dart';
import 'package:mycompany/src/presentation/widgets/tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserBloc _userBloc = UserBloc();
  final TaskBloc _taskBloc = TaskBloc();
  final MeetingBloc _meetingBloc = MeetingBloc();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<bool> init() async {
    print("Init...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userToken");
    _userBloc.add(GetUser("TMAuv8NRMhcL3mdZOppWbFun6N02"));

    _taskBloc.add(GetTasks("TMAuv8NRMhcL3mdZOppWbFun6N02"));

    _meetingBloc.add(GetMeetingsFromUser("TMAuv8NRMhcL3mdZOppWbFun6N02"));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _userBloc,
      builder: (context, state) {
        if (state is UserLoaded) {
          return _buildPage(state);
        } else if (state is UserError) {
          return Center(
            child: Text(state.error),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildPage(state) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDate(),
            _buildTitle(state),
            const SizedBox(height: 10),
            _buildTiles(state),
            const SizedBox(height: 10),
            BlocBuilder<MeetingBloc, MeetingState>(
              bloc: _meetingBloc,
              builder: (context, state) {
                print(state);
                if (state is MeetingsLoaded && state.meetings.isNotEmpty) {
                  return _buildMeeting(state);
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<TaskBloc, TaskState>(
              bloc: _taskBloc,
              builder: (context, state) {
                print(state);
                return _buildTasksList(state);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDate() {
    var now = DateTime.now();
    String formattedDate = DateFormat('EE dd MMM. yyyy').format(now);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          formattedDate,
          style: const TextStyle(fontSize: 14, color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _buildTitle(state) {
    return RichText(
      text: TextSpan(
          text: "Hello\n",
          style: const TextStyle(
              fontSize: 36,
              color: AppColors.primary,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(
                text: "${state.user.firstName} ${state.user.lastName}",
                style: const TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black))
          ]),
    );
  }

  Widget _buildTiles(state) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: state.user.poles.map<Widget>((pole) {
        return Tile(color: getColor(pole.color), label: pole.name);
      }).toList(),
    );
  }

  Widget _buildMeeting(state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Next meeting",
          style: TextStyle(fontSize: 18, color: AppColors.grey),
        ),
        const SizedBox(height: 10),
        state is MeetingsLoaded ? MeetingCard(
          meeting: state.meetings[0],
        ) : state is MeetingError ? Center(child: Text(state.error))
            : const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  Widget _buildTasksList(state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "My tasts",
              style: TextStyle(fontSize: 18, color: AppColors.grey),
            ),
            GestureDetector(
              child: const Text(
                "New task",
                style: TextStyle(fontSize: 18, color: AppColors.primaryLight),
              ),
              onTap: () => print("Todo !!"),
            )
          ],
        ),
        const SizedBox(height: 10),
        state is TasksLoaded
            ? ListView.builder(
                shrinkWrap: true,

                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    task: state.tasks[index],
                  );
                },
              )
            : state is TaskError
                ? Center(child: Text(state.error))
                : const Center(child: CircularProgressIndicator()),
        if (state is TasksLoaded && state.tasks.isEmpty)
          const Center(child: Text("No attributed task", style: TextStyle(fontSize: 16, color: AppColors.grey),))
      ],
    );
  }
}
