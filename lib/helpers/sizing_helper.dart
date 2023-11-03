import 'package:flutter/material.dart';

class SizingHelper {
  late BuildContext context;

  static final _instance = SizingHelper._();

  SizingHelper._();

  factory SizingHelper.getSize(BuildContext context) {
    _instance.context = context;
    return _instance;
  }

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  MediaQueryData get mediaQuery => MediaQuery.of(context);
}

extension Sizing on num {
  double get w => (this / 100) * SizingHelper._instance.width;
  double get h => (this / 100) * SizingHelper._instance.height;
}
