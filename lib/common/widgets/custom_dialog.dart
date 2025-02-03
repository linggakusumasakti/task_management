import 'package:flutter/material.dart';
import 'package:task_management/common/font/monserrat.dart';
import 'package:task_management/common/widgets/primary_button.dart';

Future<void> customDialog(BuildContext context, String message,
    {required VoidCallback onPressed}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Delete task',
          style: Montserrat.medium,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                'Are you sure want to delete this task?',
                style: Montserrat.regular,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                  child: PrimaryButton(
                text: 'Cancel',
                sizeHeight: 30,
                colorButton: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: PrimaryButton(
                text: 'Delete',
                sizeHeight: 30,
                onPressed: onPressed,
              )),
            ],
          )
        ],
      );
    },
  );
}
