import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/blocs/meeting/meeting_bloc.dart';
import 'package:mycompany/src/config/routes/app_routes.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/config/themes/app_theme.dart';
import 'package:mycompany/src/presentation/screens/login.dart';

import 'blocs/login/login_bloc.dart';
import 'blocs/project/project_bloc.dart';
import 'blocs/task/task_bloc.dart';
import 'blocs/user/user_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarBrightness: Brightness.dark));

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
        BlocProvider<TaskBloc>(
          create: (BuildContext context) => TaskBloc(),
        ),
        BlocProvider<MeetingBloc>(
          create: (BuildContext context) => MeetingBloc(),
        ),
        BlocProvider<ProjectBloc>(
          create: (BuildContext context) => ProjectBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'myCompany',
        theme: AppTheme.defaultTheme,
        home: const MyHomePage(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        debugShowCheckedModeBanner: false,
      ),
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
            return Scaffold(
                body: Center(child: Text(snapshot.error.toString())));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        });
  }
}
