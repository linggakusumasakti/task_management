import 'package:flutter/cupertino.dart';

import '../../../common/font/monserrat.dart';
import '../../../common/widgets/primary_button.dart';

class TaskEmptySection extends StatelessWidget {
  const TaskEmptySection(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          height: 30,
        ),
        Center(
          child: PrimaryButton(
            text: 'Add a task',
            sizeHeight: 40,
            sizeWidth: 150,
            onPressed: onPressed,
          ),
        )
      ],
    );
  }
}
