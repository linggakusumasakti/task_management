import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';
import 'package:task_management/presentation/task/pages/task_filter_section.dart';
import 'package:task_management/presentation/task/pages/task_item.dart';

import '../../../common/font/monserrat.dart';
import '../../../core/data/models/task.dart';
import '../../../routes/routes.dart';

class TaskSuccessSection extends StatelessWidget {
  const TaskSuccessSection(
      {super.key, required this.text, required this.tasks});

  final String text;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "Hello,",
          style: Montserrat.medium.copyWith(fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Montserrat.regular.copyWith(fontSize: 18),
        ),
        const SizedBox(
          height: 20,
        ),
        TaskFilterSection(
          onSelected: (value) {
            switch (value) {
              case 0:
                context.read<TaskBloc>().add(GetTasksEvent());
                break;
              case 1:
                context
                    .read<TaskBloc>()
                    .add(const FilterTasksEvent(status: TaskStatus.pending));
                break;
              case 2:
                context
                    .read<TaskBloc>()
                    .add(const FilterTasksEvent(status: TaskStatus.inProgress));
                break;
              case 3:
                context
                    .read<TaskBloc>()
                    .add(const FilterTasksEvent(status: TaskStatus.completed));
                break;
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        _content()
      ],
    );
  }

  Widget _content() {
    if (tasks.isEmpty) {
      return Center(
          child: Text(
        "No tasks found",
        style: Montserrat.medium.copyWith(fontSize: 20),
      ));
    }
    return ListView.separated(
      itemCount: tasks.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final task = tasks[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.addTask,
              arguments: task,
            );
          },
          child: TaskItem(
            task: task,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
