import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/common/font/monserrat.dart';
import 'package:task_management/common/utils/ext/date_time.dart';
import 'package:task_management/common/utils/ext/string.dart';
import 'package:task_management/common/widgets/custom_dialog.dart';
import 'package:task_management/common/widgets/custom_text_field.dart';
import 'package:task_management/common/widgets/primary_button.dart';
import 'package:task_management/core/data/models/task.dart';
import 'package:task_management/presentation/add_task/pages/date_section.dart';
import 'package:task_management/presentation/add_task/pages/task_status_section.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';

import '../../../common/utils/status.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key, this.task});

  final Task? task;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var dueDate = DateTime.now().formatDate() ?? '';
    var taskStatus = TaskStatus.pending;
    if (task != null) {
      titleController.text = task?.title ?? '';
      descriptionController.text = task?.description ?? '';
      dueDate = task?.dueDate ?? '';
      taskStatus = task?.status ?? TaskStatus.pending;
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: task != null,
            child: IconButton(
                onPressed: () {
                  customDialog(context, 'message', onPressed: () {
                    context
                        .read<TaskBloc>()
                        .add(DeleteTaskEvent(id: task?.id ?? 0));
                    context.read<TaskBloc>().add(GetTasksEvent());
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  size: 30,
                  color: Colors.black54,
                )),
          )
        ],
        title: Text(
          task == null ? 'Add Task' : 'Your Task',
          style: Montserrat.medium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        labelText: 'Title',
                        hintText: 'Add task title',
                        controller: titleController,
                        maxLines: 5,
                        maxLength: 50,
                        validator: (value) =>
                            'Title can\'t be empty'.validator(value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        labelText: 'Description',
                        hintText: 'Add task description',
                        minLines: 5,
                        maxLines: 10,
                        controller: descriptionController,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              DateSection(
                date: dueDate,
                onSelected: (date) {
                  dueDate = date;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TaskStatusSection(
                index: taskStatus.index,
                onSelected: (status) {
                  taskStatus = status;
                },
              ),
              const Spacer(),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                  return PrimaryButton(
                    text: task == null ? 'Create Task' : 'Update Task',
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        if (task == null) {
                          context.read<TaskBloc>().add(AddTaskEvent(
                              task: Task(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  dueDate: dueDate,
                                  status: taskStatus)));
                        } else {
                          context.read<TaskBloc>().add(UpdateTaskEvent(
                              task: Task(
                                  id: task?.id,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  dueDate: dueDate,
                                  status: taskStatus)));
                          switch (taskStatus) {
                            case TaskStatus.pending:
                              context.read<TaskBloc>().add(
                                  const FilterTasksEvent(
                                      status: TaskStatus.pending));
                              break;
                            case TaskStatus.inProgress:
                              context.read<TaskBloc>().add(
                                  const FilterTasksEvent(
                                      status: TaskStatus.inProgress));
                              break;
                            case TaskStatus.completed:
                              context.read<TaskBloc>().add(
                                  const FilterTasksEvent(
                                      status: TaskStatus.completed));
                              break;
                            default:
                              break;
                          }
                        }

                        context.read<TaskBloc>().add(GetTasksEvent());
                        Navigator.of(context).pop();
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
