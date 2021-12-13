import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/blocs/project/project_bloc.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/models/project.dart';
import 'package:mycompany/src/presentation/widgets/custom_title.dart';
import 'package:mycompany/src/presentation/widgets/task_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late TextEditingController _controller;
  final ProjectBloc _projectBloc = ProjectBloc();

  @override
  void initState() {
    init();
    super.initState();
    _controller = TextEditingController();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getString("companyId");
    if (companyId != null) {
      _projectBloc
          .add(GetProjectsFromCompany(companyId));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              const CustomTitle(label: "Tasks"),
              const SizedBox(height: 10),
              BlocBuilder<ProjectBloc, ProjectState>(
                bloc: _projectBloc,
                builder: (context, state) {
                  if (state is ProjectsLoaded) {
                    return _buildTasksList(state);
                  } else if (state is ProjectError) {
                    return Center(child: Text(state.error));
                  }
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newTask').then(
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

  Widget _buildTasksList(ProjectsLoaded state) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.projects.length,
      itemBuilder: (context, index) {
        return _buildProjectItem(state.projects[index]);
      },
    );
  }

  Widget _buildProjectItem(Project project) {
    return project.tasks.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.name,
                style: const TextStyle(fontSize: 18, color: AppColors.grey),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: project.tasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    task: project.tasks[index],
                    callback: () {
                      init();
                    },
                    projectId: project.id,
                  );
                },
              ),
            ],
          )
        : Container();
  }
}
