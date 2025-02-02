import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/common/font/monserrat.dart';
import 'package:task_management/common/utils/ext/string.dart';
import 'package:task_management/common/widgets/custom_text_field.dart';
import 'package:task_management/common/widgets/primary_button.dart';
import 'package:task_management/core/data/models/task.dart';
import 'package:task_management/presentation/add_task/pages/date_section.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';

import '../../../common/utils/status.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var dueDate = '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: Montserrat.medium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
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
                        validator: (value) =>
                            'Description can\'t be empty'.validator(value),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              DateSection(
                onSelected: (date) {
                  dueDate = date;
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
                    text: 'Create Task',
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<TaskBloc>().add(AddTaskEvent(
                            task: Task(
                                title: titleController.text,
                                description: descriptionController.text,
                                dueDate: dueDate,
                                status: TaskStatus.pending)));
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
