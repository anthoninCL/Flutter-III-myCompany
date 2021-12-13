import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData defaultTheme = _buildLightTheme();
  static final ThemeData darkTheme = _buildDarkTheme();

  static ThemeData _buildLightTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      brightness: Brightness.dark,

      primaryColor: AppColors.primary,
      primaryColorDark: AppColors.primaryDark,
      primaryColorLight: AppColors.primaryLight,
      primaryColorBrightness: Brightness.light,

      scaffoldBackgroundColor: AppColors.background,
      backgroundColor: AppColors.background,

      textTheme: base.textTheme.copyWith(
        headline1: base.textTheme.headline1!.copyWith(fontSize: 36),
        headline2: base.textTheme.headline2!.copyWith(fontSize: 30),
        headline3: base.textTheme.headline3!.copyWith(fontSize: 20),
        headline4: base.textTheme.headline4!.copyWith(fontSize: 18),
        headline5: base.textTheme.headline5!.copyWith(fontSize: 15),
        bodyText1: base.textTheme.bodyText1!.copyWith(fontSize: 14),
        bodyText2: base.textTheme.bodyText2!.copyWith(fontSize: 12),
      ),
    );
  }

  static ThemeData _buildDarkTheme() {
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      brightness: Brightness.dark,

      primaryColor: AppColors.primary,
      primaryColorDark: AppColors.primaryDark,
      primaryColorLight: AppColors.primaryLight,
      primaryColorBrightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.darkLight,
      backgroundColor: AppColors.darkLight,

      textTheme: base.textTheme.copyWith(
        headline1: base.textTheme.headline1!.copyWith(fontSize: 36),
        headline2: base.textTheme.headline2!.copyWith(fontSize: 30),
        headline3: base.textTheme.headline3!.copyWith(fontSize: 20),
        headline4: base.textTheme.headline4!.copyWith(fontSize: 18),
        headline5: base.textTheme.headline5!.copyWith(fontSize: 15),
        bodyText1: base.textTheme.bodyText1!.copyWith(fontSize: 14),
        bodyText2: base.textTheme.bodyText2!.copyWith(fontSize: 12),
      ),
    );
  }
}