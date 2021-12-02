import 'package:flutter/material.dart';
import 'package:mycompany/src/presentation/screens/home_screen.dart';
import 'package:mycompany/src/presentation/screens/meetings_screen.dart';
import 'package:mycompany/src/presentation/screens/navigation_screen.dart';
import 'package:mycompany/src/presentation/screens/new_task.dart';
import 'package:mycompany/src/presentation/screens/profile_screen.dart';
import 'package:mycompany/src/presentation/screens/tasks_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const NavigationScreen());
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
      default:
        return _materialRoute(const NavigationScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}