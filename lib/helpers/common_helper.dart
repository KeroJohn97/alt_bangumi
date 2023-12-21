// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/helpers/loading_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/helpers/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'http_helper.dart';

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

  static Future<String?> translate({
    required BuildContext context,
    required String? text,
    required bool isRefresh,
    Locale? locale,
  }) async {
    if (text == null) return text;
    Locale? result = locale;
    result ??= await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              height: 50.h + 60.0,
              child: Column(
                children: [
                  ListTile(
                    title:
                        Text(TextConstant.chooseALanguage.getString(context)),
                  ),
                  SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                        itemCount: window.locales.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${window.locales[index]}'),
                            onTap: () {
                              context.pop(window.locales[index]);
                            },
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        });
    if (result == null) return null;
    try {
      LoadingHelper.instance().show(context: context);

      final existingTranslation =
          await StorageHelper.read(StorageHelperOption.translationHistory);
      final Map<String, dynamic> map = jsonDecode(existingTranslation ?? '{}');

      late List<String> list;
      if ((map[text] != null && map[text][result.languageCode] != null) &&
          !isRefresh) {
        final String json = map[text][result.languageCode];
        list = json.split('\n');
      } else {
        list = text.split('\n');
        for (var i = 0; i < list.length; i++) {
          final dynamic response = await HttpHelper.translate(
            locale: result,
            body: jsonEncode([
              {'Text': list[i]}
            ]),
          );
          if (response is! List<dynamic>) continue;
          final List<dynamic> translations = response.first['translations'];
          if (translations.isEmpty) continue;
          list[i] = translations.first['text'];
        }
      }
      // final dynamic response = await HttpHelper.translate(
      //   locale: result,
      //   text: text,
      // );
      // LoadingHelper.instance().hide();
      // if (response is! List<dynamic>) return;
      // final List<dynamic> translations = response.first['translations'];
      // if (translations.isEmpty) return;

      map[text] ??= {};
      map[text][result.languageCode] = list.join('\n');
      StorageHelper.write(
        option: StorageHelperOption.translationHistory,
        value: jsonEncode(map),
      );
      _showTranslation(
        context: context,
        text: text,
        translation: list.join('\n'),
        locale: result,
      );
    } on FormatException catch (e) {
      log('FormatException: $e');
    } on SocketException {
      CommonHelper.showToast(
        TextConstant.noInternetConnection.getString(context),
      );
    } finally {
      LoadingHelper.instance().hide();
    }
    return null;
  }

  static void _showTranslation({
    required BuildContext context,
    required String text,
    required String translation,
    required Locale locale,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          scrollable: true,
          title: Row(
            children: [
              Text(TextConstant.translation.getString(dialogContext)),
              const Spacer(),
              IconButton(
                onPressed: () {
                  dialogContext.pop();
                  translate(
                    context: context,
                    text: text,
                    locale: locale,
                    isRefresh: true,
                  );
                },
                icon: const Icon(Icons.refresh_outlined),
              ),
            ],
          ),
          content: GestureDetector(
            onLongPress: () {
              Clipboard.setData(
                ClipboardData(text: translation),
              );
              CommonHelper.showToast(TextConstant.copied.getString(context));
            },
            child: Text(translation),
          ),
        );
      },
    );
  }

  static Future<bool> showConfirmation(BuildContext context) async {
    return await showDialog<bool?>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(TextConstant.areYouSureContinue.getString(context)),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(false),
                    child: Text(TextConstant.no.getString(context)),
                  ),
                  TextButton(
                    onPressed: () => context.pop(true),
                    child: Text(TextConstant.yes.getString(context)),
                  ),
                ],
              );
            }) ??
        false;
  }
}
