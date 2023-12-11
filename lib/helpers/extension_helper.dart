import 'dart:convert';
import 'dart:math' as math;
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

extension StringExtension on String? {
  String capitalizeFirst() {
    if (this?.trim().isEmpty ?? true) return '$this';
    return this![0].toUpperCase() + this!.substring(1).toLowerCase();
  }

  String? decode() {
    if (this == null) return this;
    try {
      return utf8.decode(this!.runes.toList());
    } catch (e) {
      return null;
    }
  }

  String? showHTML() {
    return parse(this).firstChild?.text;
  }

  String? ensureUrlScheme({String defaultScheme = 'https'}) {
    if ((this?.isNotEmpty ?? false) && !this!.contains('http')) {
      // If the URL doesn't contain a scheme, add the default scheme
      return '$defaultScheme:$this';
    } else {
      // If the URL already has a scheme, return it as is
      return this;
    }
  }

  String? getNumber() {
    return this?.replaceAll(RegExp(r'[^0-9]'), '');
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
