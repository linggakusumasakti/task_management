import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_management/common/font/monserrat.dart';
import 'package:task_management/core/data/models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        color: getRandomColor(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title, style: Montserrat.bold.copyWith(fontSize: 24)),
              Expanded(
                  child: Text(
                task.description ?? '',
                style: Montserrat.medium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )),
              Row(
                children: [
                  Card(
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: getRandomColor(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        task.status.displayName,
                        style: Montserrat.medium.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0.1,
                    color: getRandomColor(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        task.dueDate,
                        style: Montserrat.medium.copyWith(fontSize: 12),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      150,
      150 + random.nextInt(106),
      150 + random.nextInt(106),
      150 + random.nextInt(106),
    );
  }
}
