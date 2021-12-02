import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/domain/entities/meeting.dart';
import 'package:mycompany/src/domain/entities/task.dart';
import 'package:mycompany/src/presentation/widgets/meeting_card.dart';
import 'package:mycompany/src/presentation/widgets/task_card.dart';
import 'package:mycompany/src/presentation/widgets/tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasksData = [
    Task(
      id: "1",
      name: "Faire le design de la home page",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit non est tristique gravida vitae morbi. Urna lacus at sit diam fames nec amet, in turpis. Mus eu diam velit amet ",
      deadline: 1638442800,
      state: "Todo",
      priority: "Low",
      estimatedTime: 3,
    ),
    Task(
      id: "1",
      name: "Integrer la vraie data",
      description:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit non est tristique gravida vitae morbi. Urna lacus at sit diam fames nec amet, in turpis. Mus eu diam velit amet ",
      deadline: 1638442800,
      state: "In Progress",
      priority: "Medium",
      estimatedTime: 7,
    ),
    Task(
      id: "1",
      name: "Faire le design de la home page",
      description:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit non est tristique gravida vitae morbi. Urna lacus at sit diam fames nec amet, in turpis. Mus eu diam velit amet ",
      deadline: 1638442800,
      state: "Todo",
      priority: "High",
      estimatedTime: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDate(),
            _buildTitle(),
            SizedBox(height: 10),
            _buildTiles(),
            SizedBox(height: 10),
            _buildMeeting(),
            SizedBox(height: 20),
            _buildTasksList(),
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
          style: TextStyle(fontSize: 14, color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: const TextSpan(
          text: "Hello\n",
          style: TextStyle(
              fontSize: 36,
              color: AppColors.primary,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(
                text: "Thomas Hidalgo",
                style: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black))
          ]),
    );
  }

  Widget _buildTiles() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        Tile(color: Colors.red, label: "Development"),
        Tile(color: Colors.purple, label: "Communication"),
        Tile(color: AppColors.primaryLight, label: "Juloa"),
      ],
    );
  }

  Widget _buildMeeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Next meeting",
          style: TextStyle(fontSize: 18, color: AppColors.grey),
        ),
        SizedBox(height: 10),
        MeetingCard(
          meeting: Meeting(
              id: "1",
              name: "Réunion Shoku",
              users: ["ajdnzakdj, azodjazn"],
              start: 1638442800,
              duration: 30),
        )
      ],
    );
  }

  Widget _buildTasksList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My tasts",
              style: TextStyle(fontSize: 18, color: AppColors.grey),
            ),
            GestureDetector(
              child: Text(
                "New task",
                style: TextStyle(fontSize: 18, color: AppColors.primaryLight),
              ),
              onTap: () => print("Todo !!"),
            )
          ],
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _tasksData.length,
          itemBuilder: (context, index) {
            return TaskCard(task: _tasksData[index],);
          },
        ),

      ],
    );
  }
}
