import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycompany/src/pages/create_company.dart';
import 'package:mycompany/src/pages/login.dart';
import 'package:mycompany/src/pages/welcome.dart';
import 'package:mycompany/src/navigation_screen.dart';
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
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const NavigationScreen();// This trailing comma makes auto-formatting nicer for build methods.
  }
}