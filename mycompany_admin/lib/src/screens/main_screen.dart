import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/action_buttons_bar.dart';
import 'package:mycompany_admin/src/widgets/app_title.dart';
import 'package:mycompany_admin/src/widgets/collection_buttons_bar.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const id = "/admin-panel";

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
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
            child: const CollectionButtonBar(),
          ),
          Row(
            children: [
              Container( // DOCUMENT LIST
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.85,
                color: AppColors.greenShadow,
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
