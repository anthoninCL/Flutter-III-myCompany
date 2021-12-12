import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/blocs/users/user_bloc.dart';

import 'package:mycompany_admin/src/widgets/action_buttons_bar.dart';
import 'package:mycompany_admin/src/widgets/app_title.dart';
import 'package:mycompany_admin/src/widgets/collection_buttons_bar.dart';
import 'package:mycompany_admin/src/widgets/document_list.dart';
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
  const MainScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;

  static const id = "/admin-panel";

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String _selectedScreen = 'Users';
  late List<ListItem> _datas = listUser;

  final _firstNameController = TextEditingController();
  late StreamSubscription blocSubscription;

  @override
  void initState() {
    super.initState();
  }

  void onChangeScreen(String title) {
    setState(() {
      _selectedScreen = title;

      // TODO : remove this when blocks implemented
      if (title == 'Users') {
        _datas = listUser;
      } else if (title == 'Groups') {
        _datas = listGroups;
      } else if (title == 'Roles') {
        _datas = listRoles;
      } else if (title == 'Rights') {
        _datas = listRights;
      } else if (title == 'Projects') {
        _datas = listProjects;
      } else if (title == 'Tasks') {
        _datas = listTasks;
      } else if (title == 'Meetings') {
        _datas = listMeetings;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_firstNameController);
    return Scaffold(
      appBar: AppBar(
        title: const AppTitle(title: 'MyCompany'),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              border: const Border(
                bottom: BorderSide(color: AppColors.greyLight),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkLight.withOpacity(0.25),
                  spreadRadius: -5,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: CollectionButtonBar(
              selected: _selectedScreen,
              onChange: onChangeScreen,
            ),
          ),
          Row(
            children: [
              Container( // DOCUMENT LIST
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.85,
                color: AppColors.background,
                child: DocumentList(datas: _datas),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: const ActionButtonBar(),
                    ),
                    Container( // DOCUMENT DETAIL
                      color: AppColors.primaryLight,
                      height: MediaQuery.of(context).size.height * 0.75,
                    ),
                  ],
                ),
              ),
              Container( // GROUP/ROLE ???
                width: MediaQuery.of(context).size.width * 0.25,
                color: AppColors.redShadow,
                height: MediaQuery.of(context).size.height * 0.85,
              ),
            ]
          )
        ]
      ),
    );
  }
}
