import 'package:flutter/material.dart';
import 'package:task_management/common/font/monserrat.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool? isPassword;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;

  const CustomTextFormField(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.isPassword,
      this.controller,
      this.validator,
      this.onChanged,
      this.maxLines,
      this.minLines});

  @override
  CustomTextFormFieldState createState() {
    return CustomTextFormFieldState();
  }
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Montserrat.regular.copyWith(fontSize: 12),
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          minLines: widget.minLines ?? 1,
          maxLines: widget.maxLines ?? 1,
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: widget.isPassword ?? false ? passwordVisibility : false,
          validator: widget.validator,
          style: Montserrat.regular,
          decoration: InputDecoration(
              hintText: widget.hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.red)),
              suffixIconConstraints:
                  const BoxConstraints(minHeight: 24, minWidth: 24),
              suffixIcon: widget.isPassword ?? false
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          },
                          child: passwordVisibility
                              ? const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.black54,
                                )
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.black54,
                                )),
                    )
                  : null),
        ),
      ],
    );
  }
}
