import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class CollectionButtonBar extends StatefulWidget {
  const CollectionButtonBar(
      {Key? key, required this.onChange, required this.selected})
      : super(key: key);

  final Function onChange;
  final String selected;

  @override
  State<StatefulWidget> createState() => _CollectionButtonBarState();
}

class _CollectionButtonBarState extends State<CollectionButtonBar> {
  late String _selected = 'Users';

  bool isSelected(String title) {
    return title == widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: GenericButton(
          title: 'Users',
          onPressed: () => widget.onChange('Users'),
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
          title: 'Poles',
          onPressed: () => widget.onChange('Poles'),
          backColor: isSelected('Poles') ? AppColors.primary : AppColors.white,
          fontColor: isSelected('Poles') ? AppColors.white : AppColors.primary,
          shadowColor:
              isSelected('Poles') ? AppColors.primary : AppColors.white,
          borderColor:
              isSelected('Poles') ? AppColors.white : AppColors.primary,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: GenericButton(
          title: 'Projects',
          onPressed: () => widget.onChange('Projects'),
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
          onPressed: () => widget.onChange('Tasks'),
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
          onPressed: () => widget.onChange('Meetings'),
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
