import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiselect/multiselect.dart';
import 'package:mycompany_admin/src/blocs/projects/projects_bloc.dart';
import 'package:mycompany_admin/src/models/project.dart';
import 'package:mycompany_admin/src/widgets/dropdown_menu_widget.dart';
import 'package:mycompany_admin/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectInput extends StatefulWidget {
  const ProjectInput(
      {Key? key,
      required this.multi,
      this.selectedItems,
      this.selectedItem,
      required this.fieldTitle,
      required this.onEmpty,
      this.onMultiChange,
      this.onChange})
      : super(key: key);

  final bool multi;
  final List<Project>? selectedItems;
  final Project? selectedItem;
  final String fieldTitle;
  final String onEmpty;
  final Function(List<Project>)? onMultiChange;
  final Function(Project)? onChange;

  @override
  _ProjectInputState createState() => _ProjectInputState();
}

class _ProjectInputState extends State<ProjectInput> {
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
            return buildProjectInput(context, state.projects);
          } else if (state is ProjectError) {
            return AlertDialog(
                title: const Text('Error'),
                content: Text(state.error),
                actions: [
                  ElevatedButton(
                    child: const Text('Got it'),
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

  Widget buildProjectInput(BuildContext context, List<Project> projects) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            child: Text(
              widget.fieldTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.black),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 20, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.black)),
              child: widget.multi
                  ? buildMultiSelectInput(context, projects)
                  : buildSelectInput(context, projects))
        ],
      ),
    );
  }

  Widget buildMultiSelectInput(BuildContext context, List<Project> projects) {
    return DropDownMultiSelect(
      onChanged: (strings) {
        List<Project> newProjects = [];

        for (var string in strings) {
          newProjects.add(projects
              .elementAt(projects.indexWhere((e) => e.name == string)));
        }
        widget.onMultiChange!(newProjects);
      },
      options: projects.map((project) => project.name).toList(),
      selectedValues:
      widget.selectedItems!.map((project) => project.name).toList(),
      childBuilder: buildChildItem,
      whenEmpty: widget.onEmpty,
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          )),
    );
  }

  Widget buildSelectInput(BuildContext context, List<Project> projects) {
    return DropDownMenuWidget(
        items: projects.map((project) => project.name).toList(),
        changeItem: (string) {
          widget.onChange!(
              projects.elementAt(projects.indexWhere((e) => e.name == string)));
        },
        initialItem: widget.selectedItem?.name);
  }

  Widget buildChildItem(List<String> selectedItems) {
    return Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                selectedItems.isNotEmpty
                    ? selectedItems.reduce((a, b) => a + ' , ' + b)
                    : widget.onEmpty,
                style: TextStyle(
                    color: selectedItems.isNotEmpty
                        ? AppColors.black
                        : AppColors.grey,
                    fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.black, size: 32)
          ],
        ),
        alignment: Alignment.centerLeft);
  }
}
