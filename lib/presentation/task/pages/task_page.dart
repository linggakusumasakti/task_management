import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/common/utils/status.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';
import 'package:task_management/presentation/task/pages/task_empty_section.dart';
import 'package:task_management/presentation/task/pages/task_success_section.dart';

import '../../../routes/routes.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                navigateToAddTask(context);
              },
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                size: 35,
                color: Colors.black54,
              ))
        ],
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                switch (state.status) {
                  case Status.success:
                    return TaskSuccessSection(
                      text: state.getInformationTask(),
                      tasks: state.tasks ?? [],
                    );
                  case Status.empty:
                    return TaskEmptySection(
                      text: state.getInformationTask(),
                      onPressed: () {
                        navigateToAddTask(context);
                      },
                    );
                  default:
                    return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      )),
    );
  }

  void navigateToAddTask(BuildContext context) {
    Navigator.pushNamed(context, Routes.addTask);
  }
}
