import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mycompany_admin/src/widgets/action_buttons_bar.dart';
import 'package:mycompany_admin/src/widgets/app_title.dart';
import 'package:mycompany_admin/src/widgets/collection_buttons_bar.dart';
import 'package:mycompany_admin/src/widgets/document_list.dart';
import 'package:mycompany_admin/src/widgets/forms/meeting_form.dart';
import 'package:mycompany_admin/src/widgets/forms/pole_form.dart';
import 'package:mycompany_admin/src/widgets/forms/project_form.dart';
import 'package:mycompany_admin/src/widgets/forms/task_form.dart';
import 'package:mycompany_admin/src/widgets/forms/user_form.dart';
import 'package:mycompany_admin/src/widgets/list_item.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

// CONSTANTS IMPORT TO REMOVE WHEN IMPLEMENT BLOCKS
import 'package:mycompany_admin/src/constants/groups_datas.dart';
import 'package:mycompany_admin/src/constants/projects_data.dart';
import 'package:mycompany_admin/src/constants/rights_datas.dart';
import 'package:mycompany_admin/src/constants/roles_datas.dart';
import 'package:mycompany_admin/src/constants/tasks_datas.dart';
import 'package:mycompany_admin/src/constants/users_dats.dart';
import 'package:mycompany_admin/src/constants/meetings_datas.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const id = "/admin-panel";

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String _selectedScreen = 'Users';
  late List<ListItem> _datas = listUser;
  late Widget form = const UserForm();

  void onChangeScreen(String title) {
    setState(() {
      _selectedScreen = title;

      // TODO : remove this when blocks implemented
      if (title == 'Users') {
        _datas = listUser;
        form = const UserForm();
      } else if (title == 'Poles') {
        _datas = listGroups;
        form = const PoleForm();
      } else if (title == 'Projects') {
        _datas = listProjects;
        form = const ProjectForm();
      } else if (title == 'Tasks') {
        _datas = listTasks;
        form = const TaskForm();
      } else if (title == 'Meetings') {
        _datas = listMeetings;
        form = const MeetingForm();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CollectionButtonBar(
                selected: _selectedScreen,
                onChange: onChangeScreen,
              ),
              const AppTitle(title: 'MyCompany'),
            ],
          ),
          backgroundColor: AppColors.background,
        ),
        body: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.background,
                  border:
                      Border(right: BorderSide(color: AppColors.greyLight))),
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height,
              child: DocumentList(datas: _datas),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height,
                color: AppColors.background,
                child: form),
          ],
        ));
  }
}
