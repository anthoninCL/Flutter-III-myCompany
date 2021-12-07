import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycompany_admin/src/screens/login_screen.dart';
import 'package:mycompany_admin/src/screens/main_screen.dart';
import 'package:mycompany_admin/theme/app_colors.dart';
import 'package:mycompany_admin/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarBrightness: Brightness.dark
    ));

    return MaterialApp(
      title: 'myCompany',
      theme: AppTheme.defaultTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
