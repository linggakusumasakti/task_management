import 'package:flutter/material.dart';
import 'package:task_management/presentation/add_task/pages/task_status_item.dart';

import '../../../common/font/monserrat.dart';
import '../../../core/data/models/task.dart';

class TaskStatusSection extends StatefulWidget {
  const TaskStatusSection({super.key, required this.onSelected, this.index});

  final Function(TaskStatus) onSelected;
  final int? index;

  @override
  TaskStatusState createState() => TaskStatusState();
}

class TaskStatusState extends State<TaskStatusSection> {
  List<TaskStatus> statusList = TaskStatus.values;
  int? i;

  @override
  void initState() {
    i = widget.index ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
          style: Montserrat.regular.copyWith(fontSize: 12),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: statusList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final status = statusList[index];
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      i = index;
                      widget.onSelected(status);
                    });
                  },
                  child: TaskStatusItem(
                    name: status.displayName,
                    isSelected: i == index,
                  ));
            },
          ),
        ),
      ],
    );
  }
}
