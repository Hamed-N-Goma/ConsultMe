import 'package:flutter/material.dart';
import 'package:consultme/shard/utils/extensions/string_extensions.dart';

extension MyUtils on TimeOfDay {
  String get timeString {
    return '$hour:$minute';
  }

  DateTime toDateTime() {
    return DateTime(0, 0, 0, hour, minute);
  }

  DateTime toDateTimeFromValue(DateTime value) {
    return DateTime(value.year, value.month, value.day, hour, minute);
  }
}

extension MyDateUtil on DateTime {
  DateTime get shortDate => toString().substring(0, 10).toDateTime;

  String get shortString => toString().substring(0, 10);
}
