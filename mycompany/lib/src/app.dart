import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycompany/src/pages/login.dart';
import 'package:mycompany/theme/app_colors.dart';
import 'package:mycompany/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarBrightness: Brightness.dark
    ));

    return MaterialApp(
      title: 'myCompany',
      theme: AppTheme.defaultTheme,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}