import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management/presentation/add_task/pages/add_task_page.dart';
import 'package:task_management/presentation/auth/pages/login_page.dart';
import 'package:task_management/presentation/search/blocs/search_bloc.dart';
import 'package:task_management/presentation/search/pages/search_page.dart';
import 'package:task_management/presentation/task/pages/task_page.dart';

import '../core/data/models/task.dart';
import '../presentation/task/blocs/task_bloc.dart';

class Routes {
  static const login = '/login';
  static const task = '/task';
  static const addTask = '/addTask';
  static const search = '/search';

  static Route<double> route(RouteSettings setting) {
    return switch (setting.name) {
      task => MaterialPageRoute(builder: (_) => const TaskPage()),
      addTask => MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.read<TaskBloc>(),
            child: AddTaskPage(
              task: setting.arguments as Task?,
            ),
          ),
        ),
      search => MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => GetIt.instance<SearchBloc>(),
                child: const SearchPage(),
              )),
      _ => MaterialPageRoute(builder: (_) => const LoginPage())
    };
  }
}
