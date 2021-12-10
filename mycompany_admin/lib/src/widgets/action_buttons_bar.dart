import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class ActionButtonBar extends StatefulWidget {
  const ActionButtonBar({Key? key, required this.creation}) : super(key: key);

  final bool creation;

  @override
  State<ActionButtonBar> createState() => _ActionButtonBarState();
}

class _ActionButtonBarState extends State<ActionButtonBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.greyLight),
        ),
        color: AppColors.background,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          widget.creation ? buildCreateButton(context) : Container(),
          !widget.creation ? buildEditButton(context) : Container(),
          !widget.creation ? buildDeleteButton(context) : Container(),
        ]),
      ),
    );
  }

  Widget buildCreateButton(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GenericButton(
        title: 'Create',
        onPressed: null,
        backColor: AppColors.white,
        fontColor: AppColors.green,
        shadowColor: AppColors.greenShadow,
        borderColor: AppColors.green,
        radius: 30,
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GenericButton(
        title: 'Delete',
        onPressed: null,
        backColor: AppColors.white,
        fontColor: AppColors.red,
        shadowColor: AppColors.redShadow,
        borderColor: AppColors.red,
        radius: 30,
      ),
    );
  }
  Widget buildEditButton(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GenericButton(
        title: 'Edit',
        onPressed: null,
        backColor: AppColors.white,
        fontColor: AppColors.orange,
        shadowColor: AppColors.orangeShadow,
        borderColor: AppColors.orange,
        radius: 30,
      ),
    );
  }

}
