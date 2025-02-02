import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/presentation/add_task/pages/add_task_page.dart';
import 'package:task_management/presentation/auth/pages/login_page.dart';
import 'package:task_management/presentation/task/pages/task_page.dart';

import '../presentation/task/blocs/task_bloc.dart';

class Routes {
  static const login = '/login';
  static const task = '/task';
  static const addTask = '/addTask';

  static Route<double> route(RouteSettings setting) {
    return switch (setting.name) {
      task => MaterialPageRoute(builder: (_) => const TaskPage()),
      addTask => MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.read<TaskBloc>(),
            child: const AddTaskPage(),
          ),
        ),
      _ => MaterialPageRoute(builder: (_) => const LoginPage())
    };
  }
}
