import 'package:flutter/material.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/presentation/widgets/custom_title.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({Key? key}) : super(key: key);

  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: const [
              SizedBox(height: 10),
              CustomTitle(label: "Meetings"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newMeeting');
        },
        child: const Icon(Icons.add, size: 30),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
