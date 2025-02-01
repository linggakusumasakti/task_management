import 'package:flutter/material.dart';
import 'package:task_management/common/font/monserrat.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? sizeWidth;
  final double? sizeHeight;
  final Color? borderSideColor;
  final Color? colorButton;
  final Color? textColor;
  final bool? isLoading;

  const PrimaryButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.sizeWidth,
      this.sizeHeight,
      this.borderSideColor,
      this.colorButton,
      this.textColor,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (isLoading ?? false) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          Size(sizeWidth ?? double.infinity, sizeHeight ?? 60),
        ),
        backgroundColor: WidgetStateProperty.all(colorButton ?? Colors.black),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        side: WidgetStateProperty.all(
          BorderSide(color: borderSideColor ?? Colors.black),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
      child: Center(
        child: Text(
          text,
          style: Montserrat.medium.copyWith(
            color: textColor ?? Colors.white,
            fontSize: 16
          ),
        ),
      ),
    );
  }
}
