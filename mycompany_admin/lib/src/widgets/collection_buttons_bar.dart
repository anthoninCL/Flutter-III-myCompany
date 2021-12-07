import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class CollectionButtonBar extends StatefulWidget {
  const CollectionButtonBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CollectionButtonBarState();
}

class _CollectionButtonBarState extends State<CollectionButtonBar> {
  late String _selected = 'Users';

  bool isSelected(String title) {
    return title == _selected;
  }

  void setSelected(String title) {
    // TODO : FAIRE LA BONNE REQUETE POUR RECUP LES BONNES DONNEES
    setState(() {
      _selected = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: GenericButton(
          title: 'Users',
          onPressed: () => setState(() {
            _selected = 'Users';
          }),
          backColor: isSelected('Users') ? AppColors.primary : AppColors.white,
          fontColor: isSelected('Users') ? AppColors.white : AppColors.primary,
          shadowColor:
              isSelected('Users') ? AppColors.primary : AppColors.white,
          borderColor:
              isSelected('Users') ? AppColors.white : AppColors.primary,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: GenericButton(
          title: 'Groups',
          onPressed: () => setState(() {
            _selected = 'Groups';
          }),
          backColor: isSelected('Groups') ? AppColors.primary : AppColors.white,
          fontColor: isSelected('Groups') ? AppColors.white : AppColors.primary,
          shadowColor:
              isSelected('Groups') ? AppColors.primary : AppColors.white,
          borderColor:
              isSelected('Groups') ? AppColors.white : AppColors.primary,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: GenericButton(
          title: 'Roles',
          onPressed: () => setState(() {
            _selected = 'Roles';
          }),
          backColor: isSelected('Roles') ? AppColors.primary : AppColors.white,
          fontColor: isSelected('Roles') ? AppColors.white : AppColors.primary,
          shadowColor:
              isSelected('Roles') ? AppColors.primary : AppColors.white,
          borderColor:
              isSelected('Roles') ? AppColors.white : AppColors.primary,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: GenericButton(
          title: 'Rights',
          onPressed: () => setState(() {
            _selected = 'Rights';
          }),
          backColor: isSelected('Rights') ? AppColors.primary : AppColors.white,
          fontColor: isSelected('Rights') ? AppColors.white : AppColors.primary,
          shadowColor:
              isSelected('Rights') ? AppColors.primary : AppColors.white,
          borderColor:
              isSelected('Rights') ? AppColors.white : AppColors.primary,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: GenericButton(
          title: 'Projects',
          onPressed: () => setState(() {
            _selected = 'Projects';
          }),
          backColor:
              isSelected('Projects') ? AppColors.primary : AppColors.white,
          fontColor:
              isSelected('Projects') ? AppColors.white : AppColors.primary,
          shadowColor:
              isSelected('Projects') ? AppColors.primary : AppColors.white,
          borderColor:
              isSelected('Projects') ? AppColors.white : AppColors.primary,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: GenericButton(
          title: 'Tasks',
          onPressed: () => setState(() {
            _selected = 'Tasks';
          }),
          backColor: isSelected('Tasks') ? AppColors.primary : AppColors.white,
          fontColor: isSelected('Tasks') ? AppColors.white : AppColors.primary,
          shadowColor:
              isSelected('Tasks') ? AppColors.primary : AppColors.white,
          borderColor:
              isSelected('Tasks') ? AppColors.white : AppColors.primary,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: GenericButton(
          title: 'Meetings',
          onPressed: () => setState(() {
            _selected = 'Meetings';
          }),
          backColor:
              isSelected('Meetings') ? AppColors.primary : AppColors.white,
          fontColor:
              isSelected('Meetings') ? AppColors.white : AppColors.primary,
          shadowColor:
              isSelected('Meetings') ? AppColors.primary : AppColors.white,
          borderColor:
              isSelected('Meetings') ? AppColors.white : AppColors.primary,
        ),
      ),
    ]);
  }
}
