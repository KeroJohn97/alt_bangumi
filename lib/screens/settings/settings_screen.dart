// ignore_for_file: use_build_context_synchronously

import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/helpers/storage_helper.dart';
import 'package:alt_bangumi/main.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

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
      CommonHelper.showToast(
        context.formatString(
          TextConstant.somethingCleared.getString(context),
          [option.getString(context)],
        ),
      );
    }
  }

  void _confirmChooseLanguage({
    required BuildContext context,
    required LanguageEnum languageEnum,
  }) async {
    final result = await CommonHelper.showConfirmation(context);
    if (!result) return;
    localization.translate(languageEnum.languageCode());
  }

  static const route = '/settings';
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustomed(
      leading: const BackButton(color: Colors.black),
      // trailing: const SizedBox.shrink(),
      title: TextConstant.settings.getString(context),
      titleWidget: Text(
        TextConstant.settings.getString(context),
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      body: ListView(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              TextConstant.clearCache.getString(context),
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
              TextConstant.applicationLanguage.getString(context),
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
