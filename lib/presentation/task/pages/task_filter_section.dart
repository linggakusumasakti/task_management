import 'package:flutter/material.dart';

import '../../../core/data/models/task.dart';
import '../../add_task/pages/task_status_item.dart';

class TaskFilterSection extends StatefulWidget {
  const TaskFilterSection({super.key, this.onSelected});

  final Function(int)? onSelected;

  @override
  TaskFilterSectionState createState() => TaskFilterSectionState();
}

class TaskFilterSectionState extends State<TaskFilterSection> {
  var i = 0;

  @override
  Widget build(BuildContext context) {
    List<TaskStatus> statusList = List.from(TaskStatus.values)
      ..insert(0, TaskStatus.pending);
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: statusList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final status = statusList[index];
          return GestureDetector(
              onTap: () {
                setState(() {
                  i = index;
                  widget.onSelected!(index);
                });
              },
              child: TaskStatusItem(
                name: index == 0 ? 'All' : status.displayName,
                isSelected: i == index,
              ));
        },
      ),
    );
  }
}
