import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/blocs/projects/projects_bloc.dart';
import 'package:mycompany_admin/src/widgets/forms/project_form.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classic_text_input.dart';
import '../list_item.dart';

class ProjectDocumentList extends StatefulWidget {
  const ProjectDocumentList({Key? key, required this.onChangeForm})
      : super(key: key);

  final Function(Widget) onChangeForm;

  @override
  _ProjectDocumentListState createState() => _ProjectDocumentListState();
}

class _ProjectDocumentListState extends State<ProjectDocumentList> {
  final TextEditingController _searchTextController = TextEditingController();
  final ProjectBloc _projectBloc = ProjectBloc();

  @override
  void initState() {
    init();
    super.initState();
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
                        widget.onChangeForm(ProjectForm(key: UniqueKey(),));
                      },
                      backColor: AppColors.primary,
                      fontColor: AppColors.white,
                      shadowColor: AppColors.primary),
                ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                height: MediaQuery.of(context).size.height * 0.80,
                child: ListView.builder(
                    itemCount: state.projects.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          widget.onChangeForm(ProjectForm(project: state.projects[index], key: UniqueKey(),));
                        },
                        child: ListItem(
                            name: state.projects[index].name,
                            id: state.projects[index].id),
                      );
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
