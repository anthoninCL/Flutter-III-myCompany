import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/screens/login_screen.dart';
import 'package:mycompany_admin/src/screens/main_screen.dart';
import 'package:mycompany_admin/theme/app_colors.dart';
import 'package:mycompany_admin/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

import 'blocs/users/user_bloc.dart';

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
      home: MultiBlocProvider(providers: [
        BlocProvider<UserBloc>(create: (BuildContext context) => UserBloc()),
      ], child: const MyHomePage()),
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarBrightness: Brightness.dark));

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'myCompany',
              theme: AppTheme.defaultTheme,
              initialRoute: '/',
              routes: {
                '/': (context) => const MainScreen(userId: 'TMAuv8NRMhcL3mdZOppWbFun6N02',),
              },
              debugShowCheckedModeBanner: false,
            );
          }
          return const Text("Loading");
        });
  }
}
