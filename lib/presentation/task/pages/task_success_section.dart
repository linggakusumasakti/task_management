import 'package:flutter/cupertino.dart';
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
          height: 40,
        ),
        ListView.separated(
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
        )
      ],
    );
  }
}
