import 'package:flutter/material.dart';

class CommonHelper {
  static double screenHeight(BuildContext context, {required double value}) =>
      MediaQuery.of(context).size.height * value / 100;

  static double screenWidth(BuildContext context, {required double value}) =>
      MediaQuery.of(context).size.width * value / 100;
}
