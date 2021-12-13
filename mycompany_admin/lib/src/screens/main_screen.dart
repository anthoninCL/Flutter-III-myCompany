import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/blocs/users/user_bloc.dart';

import 'package:mycompany_admin/src/widgets/app_title.dart';
import 'package:mycompany_admin/src/widgets/collection_buttons_bar.dart';
import 'package:mycompany_admin/src/widgets/document_list.dart';
import 'package:mycompany_admin/src/widgets/document_list/meeting_document_list.dart';
import 'package:mycompany_admin/src/widgets/document_list/pole_document_list.dart';
import 'package:mycompany_admin/src/widgets/document_list/project_document_list.dart';
import 'package:mycompany_admin/src/widgets/document_list/task_document_list.dart';
import 'package:mycompany_admin/src/widgets/document_list/user_document_list.dart';
import 'package:mycompany_admin/src/widgets/list_item.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

// CONSTANTS IMPORT TO REMOVE WHEN IMPLEMENT BLOCKS
import 'package:mycompany_admin/src/constants/groups_datas.dart';
import 'package:mycompany_admin/src/constants/projects_data.dart';
import 'package:mycompany_admin/src/constants/tasks_datas.dart';
import 'package:mycompany_admin/src/constants/users_dats.dart';
import 'package:mycompany_admin/src/constants/meetings_datas.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const id = "/admin_panel";

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _selectedScreen = '';
  List<ListItem> _data = listUser;
  Widget form = Container();
  Widget documentList = Container();

  final _firstNameController = TextEditingController();
  late StreamSubscription blocSubscription;

  @override
  void initState() {
    super.initState();
  }

  void onChangeScreen(String title) {
    setState(() {
      _selectedScreen = title;

      // TODO : remove this when blocks implemented except for the form
      if (title == 'Users') {
        _data = listUser;
        form = Container();
        documentList = UserDocumentList(data: _data, onChangeForm: changeForm);
      } else if (title == 'Poles') {
        _data = listGroups;
        form = Container();
        documentList = PoleDocumentList(data: _data, onChangeForm: changeForm);
      } else if (title == 'Projects') {
        _data = listProjects;
        form = Container();
        documentList = ProjectDocumentList(data: _data, onChangeForm: changeForm);
      } else if (title == 'Tasks') {
        _data = listTasks;
        form = Container();
        documentList = TaskDocumentList(data: _data, onChangeForm: changeForm);
      } else if (title == 'Meetings') {
        _data = listMeetings;
        form = Container();
        documentList = MeetingDocumentList(data: _data, onChangeForm: changeForm);
      }
    });
  }

  void changeForm(Widget newForm) {
    setState(() {
      form = newForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_firstNameController);
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
              child: documentList,
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
