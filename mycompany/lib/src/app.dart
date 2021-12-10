import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/pages/login.dart';
import 'package:mycompany/theme/app_colors.dart';
import 'package:mycompany/theme/app_theme.dart';

import 'blocs/login/login_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarBrightness: Brightness.dark));

    return MaterialApp(
      title: 'myCompany',
      theme: AppTheme.defaultTheme,
      home:  const MyHomePage(),
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
            return Scaffold(body: Center(child: Text(snapshot.error.toString())));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocProvider(create: (context) => LoginBloc(), child: const LoginScreen());
          }
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }
}
