import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/core/utils/constants.dart';
import 'package:task_management/di/injection.dart' as di;
import 'package:task_management/presentation/auth/pages/login_page.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';
import 'package:task_management/presentation/task/pages/task_page.dart';
import 'package:task_management/routes/routes.dart';

import 'common/utils/global_observer.dart';

void main() {
  Bloc.observer = GlobalBlocObserver();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedIn) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<TaskBloc>()..add(GetTasksEvent()),
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: Routes.route,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
          future: isLogIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return snapshot.data == true ? const TaskPage() : const LoginPage();
          },
        ),
      ),
    );
  }
}
