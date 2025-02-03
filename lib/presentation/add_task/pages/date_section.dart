import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/common/font/monserrat.dart';
import 'package:task_management/common/utils/ext/date_time.dart';

class DateSection extends StatefulWidget {
  const DateSection({super.key, required this.onSelected, required this.date});

  final String? date;
  final Function(String) onSelected;

  @override
  DateSectionState createState() => DateSectionState();
}

class DateSectionState extends State<DateSection> {
  String? date;

  @override
  void initState() {
    date = widget.date ?? DateTime.now().formatDate() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: Montserrat.regular.copyWith(fontSize: 12),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () async {
            DateTime now = DateTime.now();
            DateTime initialDate = DateTime(now.year, now.month, now.day);

            DateTime? selectedDate = initialDate;
            if (Platform.isIOS) {
              await showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 300,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: initialDate,
                            minimumDate: initialDate,
                            maximumDate: DateTime(2030),
                            onDateTimeChanged: (DateTime dateTime) {
                              selectedDate = dateTime;
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: Text(
                            'Done',
                            style: Montserrat.regular
                                .copyWith(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context, selectedDate);
                            String formattedDate =
                                selectedDate?.formatDate() ?? '';
                            widget.onSelected(formattedDate);
                            setState(() {
                              date = formattedDate;
                            });
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (Platform.isAndroid) {
              DateTime? picked = await showDatePicker(
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Colors.black12,
                          onPrimary: Colors.black,
                          onSurface: Colors.black,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030));
              String formattedDate = picked?.formatDate() ?? '';
              widget.onSelected(formattedDate);
              setState(() {
                date = formattedDate;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            width: double.infinity,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date!,
                  style: Montserrat.regular.copyWith(fontSize: 16),
                ),
                const Icon(
                  Icons.date_range_outlined,
                  color: Colors.black54,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
