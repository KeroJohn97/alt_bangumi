// ignore_for_file: use_build_context_synchronously

import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/helpers/storage_helper.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _confirmClearCache({
    required BuildContext context,
    required StorageHelperOption option,
  }) async {
    final result = await CommonHelper.showConfirmation(context);
    if (!result) return;
    final isDeleted = await StorageHelper.delete(option);
    if (isDeleted) {
      CommonHelper.showToast(t.somethingCleared(something: option));
    }
  }

  void _confirmChooseLanguage({
    required BuildContext context,
    required LanguageEnum languageEnum,
  }) async {
    final result = await CommonHelper.showConfirmation(context);
    if (!result) return;
    final appLocale = AppLocale.values.firstWhereOrNull(
      (element) =>
          element.languageCode == languageEnum.languageCode() &&
          (element.countryCode ?? '') == languageEnum.countryCode(),
    );
    if (appLocale == null) return;
    LocaleSettings.setLocale(appLocale);
  }

  static const route = '/settings';
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustomed(
      leading: const BackButton(color: Colors.black),
      // trailing: const SizedBox.shrink(),
      title: context.t.settings,
      titleWidget: Text(
        context.t.settings,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      body: ListView(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.t.clearCache,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          ...StorageHelperOption.values.map((e) => ListTile(
                title: Text(e.getString(context)),
                onTap: () => _confirmClearCache(context: context, option: e),
              )),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.t.applicationLanguage,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          ...LanguageEnum.values.map(
            (e) => ListTile(
              title: Text(e.getString(context)),
              onTap: () =>
                  _confirmChooseLanguage(context: context, languageEnum: e),
            ),
          ),
        ],
      ),
    );
  }
}
