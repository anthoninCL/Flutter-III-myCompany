import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/screens/login_screen.dart';
import 'package:mycompany_admin/src/screens/main_screen.dart';
import 'package:mycompany_admin/src/screens/register_screen.dart';
import 'package:mycompany_admin/theme/app_colors.dart';
import 'package:mycompany_admin/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/register/register_bloc.dart';
import 'blocs/users/user_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
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
            return MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>(
                  create: (BuildContext context) => AuthBloc(),
                ),
                BlocProvider<RegisterBloc>(
                  create: (BuildContext context) => RegisterBloc(),
                )
              ],
              child: MaterialApp(
                title: 'myCompany',
                theme: AppTheme.defaultTheme,
                initialRoute: LoginScreen.id,
                routes: {
                  LoginScreen.id: (context) => const LoginScreen(),
                  RegisterScreen.id: (context) => const RegisterScreen(),
                  MainScreen.id: (context) => const MainScreen(),
                },
                debugShowCheckedModeBanner: false,
              ),
            );
          }
          return const Scaffold(
              body: CircularProgressIndicator()
          );
        });
  }
}
