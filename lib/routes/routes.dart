import 'package:flutter/material.dart';
import 'package:task_management/presentation/auth/pages/login_page.dart';
import 'package:task_management/presentation/task/pages/task_page.dart';

class Routes {
  static const login = '/login';
  static const task = '/task';

  static Route<double> route(RouteSettings setting) {
    return switch (setting.name) {
      task => MaterialPageRoute(builder: (_) => const TaskPage()),
      _ => MaterialPageRoute(builder: (_) => const LoginPage())
    };
  }
}
