import 'package:flutter/material.dart';

import '../font/monserrat.dart';

SnackBar snackBar(String error) {
  return SnackBar(
    content: Text(
      error,
      style: Montserrat.regular.copyWith(color: Colors.white),
    ),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))),
  );
}
