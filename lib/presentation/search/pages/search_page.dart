import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/presentation/search/blocs/search_bloc.dart';
import 'package:task_management/presentation/search/pages/search_bar.dart';

import '../../../common/font/monserrat.dart';
import '../../../core/data/models/task.dart';
import '../../../routes/routes.dart';
import '../../task/pages/task_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Tasks',
          style: Montserrat.medium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SearchBarTask(
              onChanged: (value) {
                context.read<SearchBloc>().add(SearchTasksEvent(query: value));
              },
            ),
            Expanded(
              child: BlocSelector<SearchBloc, SearchState, List<Task>?>(
                selector: (state) => state.tasks,
                builder: (context, tasks) {
                  if (tasks == null || tasks.isEmpty) {
                    return Center(
                        child: Text(
                      "No tasks found",
                      style: Montserrat.medium.copyWith(fontSize: 20),
                    ));
                  }
                  return ListView.separated(
                    itemCount: tasks.length,
                    shrinkWrap: true,
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
                        child: TaskItem(task: task),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
