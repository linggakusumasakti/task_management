import 'package:flutter/material.dart';

import '../../../common/font/monserrat.dart';

class TaskStatusItem extends StatelessWidget {
  const TaskStatusItem(
      {super.key, required this.name, required this.isSelected});

  final String name;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: isSelected ? Colors.pinkAccent[100] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            name,
            style: Montserrat.bold.copyWith(
                fontSize: 14, color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
