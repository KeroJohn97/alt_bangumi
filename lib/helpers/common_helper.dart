import 'dart:async';
import 'dart:math' as math;
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommonHelper {
  static double screenHeight(BuildContext context, {required double value}) =>
      MediaQuery.of(context).size.height * value / 100;

  static double screenWidth(BuildContext context, {required double value}) =>
      MediaQuery.of(context).size.width * value / 100;

  // A method that takes a list of Strings as input and returns the standard deviation of the ratings based on the frequencies
  static double standardDeviation(List<int> frequencies) {
    // Check if the list is empty or null
    if (frequencies.isEmpty) {
      return 0.0;
    }
    // Convert the Strings to numbers and multiply each rating by its frequency
    final valueList = [];
    double sumOfFrequencies = 0.0;
    for (int i = 0; i < frequencies.length; i++) {
      final frequency = frequencies[i].toDouble();
      final rating = i + 1.0;
      final totalValue = frequency * rating;
      valueList.add(totalValue);
      sumOfFrequencies += frequency;
    }
    // Calculate the mean of the ratings using the reduce method
    final double? mean = valueList.reduce((a, b) => a + b) / sumOfFrequencies;
    if (mean == null || mean.isNaN) return 1.0;
    // Calculate the sum of squared differences from the mean
    double sum = 0.0;
    for (int i = 0; i < valueList.length; i++) {
      final rating = i + 1.0;
      sum += (rating - mean) * (rating - mean) * frequencies[i].toDouble();
    }
    // Divide the sum by the sum of the frequencies and take the square root
    final result = math.sqrt(sum / sumOfFrequencies);
    return (result * 100).round() / 100;
  }

  static Future<void> showToast(String msg) async {
    await Fluttertoast.cancel()
        .then((value) => Fluttertoast.showToast(msg: msg));
  }

  static void showSnackBar({
    required BuildContext context,
    required String text,
    Duration duration = const Duration(milliseconds: 3000),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static Future<bool> showInBrowser({
    required BuildContext context,
    required String url,
  }) async {
    final isValid = await canLaunchUrlString('${url.ensureUrlScheme()}');
    if (context.mounted && !isValid) {
      showSnackBar(
        context: context,
        text: TextConstant.invalidURL.getString(context),
      );
      return false;
    }
    return await launchUrlString('${url.ensureUrlScheme()}');
  }

  static Future<bool> getStoragePermission(BuildContext context) async {
    PermissionStatus storagePermission = await Permission.storage.status;
    if (storagePermission.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      await Permission.storage.request();
    }
    storagePermission = await Permission.storage.status;
    return storagePermission == PermissionStatus.granted;
  }
}
