import 'dart:math' as math;
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

extension StringExtension on String? {
  String capitalizeFirst() {
    if (this?.trim().isEmpty ?? true) return '$this';
    return this![0].toUpperCase() + this!.substring(1).toLowerCase();
  }

  String? showHTML() {
    return parse(this).firstChild?.text;
  }

  DateTime? toDateTime() {
    if (this == null) return null;
    final DateFormat format = DateFormat('yyyy-MM-dd');
    try {
      final DateTime parsedDate = format.parseStrict(this!);
      return parsedDate;
    } catch (e) {
      const FormatException('Invalid date format');
      return null;
    }
  }
}

extension DoubleExtension on double {
  double decimalRounding({int decimalPlaces = 2}) {
    final multiplier = math.pow(10, decimalPlaces.toDouble());
    return (this * multiplier).round() / multiplier;
  }
}
