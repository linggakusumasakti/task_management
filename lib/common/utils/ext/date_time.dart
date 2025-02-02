import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String? formatDate({String? format}) {
    final DateFormat dateFormat = DateFormat(format ?? 'dd MMM yyyy');
    return dateFormat.format(this);
  }
}
