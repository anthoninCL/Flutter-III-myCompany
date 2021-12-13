import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/blocs/projects/projects_bloc.dart';
import 'package:mycompany_admin/src/models/task.dart';
import 'package:mycompany_admin/src/widgets/classic_text_input.dart';
import 'package:mycompany_admin/src/widgets/forms/task_form.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../list_item.dart';

class TaskDocumentList extends StatefulWidget {
  const TaskDocumentList({Key? key, required this.onChangeForm})
      : super(key: key);

  final Function(Widget) onChangeForm;

  @override
  _TaskDocumentListState createState() => _TaskDocumentListState();
}

class _TaskDocumentListState extends State<TaskDocumentList> {
  final TextEditingController _searchTextController = TextEditingController();
  final ProjectBloc _projectBloc = ProjectBloc();
  late List<Task> _tasks;

  @override
  void initState() {
    init();
    super.initState();
    _tasks = [];
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getString("companyId");
    if (companyId != null) {
      _projectBloc.add(GetProjectsCompany(companyId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _projectBloc,
        builder: (context, state) {
          if (state is ProjectsLoaded) {
            WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {
                  _tasks.clear();
                  for (var element in state.projects) {
                    _tasks.addAll(element.tasks);
                  }
                }));
            return Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(children: [
                  Expanded(
                    child: ClassicTextInput(
                      hintText: "Search",
                      isSecured: false,
                      textController: _searchTextController,
                      height: 40,
                      borderRadius: 10,
                      hasBorder: true,
                      color: AppColors.whiteDark,
                      borderColor: AppColors.greyLight,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GenericButton(
                      title: 'New',
                      onPressed: () {
                        widget.onChangeForm(const TaskForm());
                      },
                      backColor: AppColors.primary,
                      fontColor: AppColors.white,
                      shadowColor: AppColors.primary),
                ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                height: MediaQuery.of(context).size.height * 0.85,
                child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return ListItem(
                          name: _tasks[index].name, id: _tasks[index].id);
                    }),
              ),
            ]);
          } else if (state is ProjectError) {
            return AlertDialog(
                title: Text('Error'),
                content: Text(state.error),
                actions: [
                  ElevatedButton(
                    child: Text('Got it'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ]);
          }
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
