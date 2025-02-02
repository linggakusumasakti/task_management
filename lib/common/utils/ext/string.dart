extension StringExt on String {
  String? validator(String? value) =>
      value == null || value.isEmpty ? this : null;
}
