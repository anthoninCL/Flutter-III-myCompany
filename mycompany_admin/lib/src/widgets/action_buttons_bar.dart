import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class ActionButtonBar extends StatelessWidget {
  const ActionButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
      Padding(
        padding: EdgeInsets.all(10),
        child: GenericButton(
          title: 'Disable',
          onPressed: null,
          backColor: AppColors.white,
          fontColor: AppColors.primaryLight,
          shadowColor: AppColors.primaryLight,
          borderColor: AppColors.primaryLight,
          radius: 30,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: GenericButton(
          title: 'Edit',
          onPressed: null,
          backColor: AppColors.white,
          fontColor: AppColors.orange,
          shadowColor: AppColors.orangeShadow,
          borderColor: AppColors.orange,
          radius: 30,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: GenericButton(
          title: 'Delete',
          onPressed: null,
          backColor: AppColors.white,
          fontColor: AppColors.red,
          shadowColor: AppColors.redShadow,
          borderColor: AppColors.red,
          radius: 30,
        ),
      ),
    ]);
  }
}
