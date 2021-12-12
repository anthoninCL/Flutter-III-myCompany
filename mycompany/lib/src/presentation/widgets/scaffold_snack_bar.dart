import 'package:flutter/material.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> scaffoldSnackBar(BuildContext context, state) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.red,
        content: Text(
          state.error,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
  );
}