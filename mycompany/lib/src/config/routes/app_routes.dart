import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/blocs/login/login_bloc.dart';
import 'package:mycompany/src/presentation/screens/login.dart';
import 'package:mycompany/src/presentation/screens/home_screen.dart';
import 'package:mycompany/src/presentation/screens/meetings_screen.dart';
import 'package:mycompany/src/presentation/screens/navigation_screen.dart';
import 'package:mycompany/src/presentation/screens/new_meeting.dart';
import 'package:mycompany/src/presentation/screens/new_task.dart';
import 'package:mycompany/src/presentation/screens/profile_screen.dart';
import 'package:mycompany/src/presentation/screens/tasks_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const NavigationScreen());
      case '/login':
        return _materialBlocRoute(LoginBloc(), const LoginScreen());
      case '/home':
        return _materialRoute(const HomeScreen());
      case '/tasks':
        return _materialRoute(const TasksScreen());
      case '/meetings':
        return _materialRoute(const MeetingsScreen());
      case '/profile':
        return _materialRoute(const ProfileScreen());
      case '/newTask':
        return _materialRoute(const NewTask());
      case '/newMeeting':
        return _materialRoute(const NewMeeting());
      default:
        return _materialRoute(const NavigationScreen());
    }
  }

  static Route<dynamic> _materialBlocRoute(BlocBase<Object?> bloc, Widget view) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(create: (context) => bloc, child: view,);
    });
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}