import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycompany/src/navigation_screen.dart';
import 'package:mycompany/theme/app_colors.dart';
import 'package:mycompany/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarBrightness: Brightness.dark));

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
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const NavigationScreen();
          }
          return const Text("Loading");
        });
  }
}
