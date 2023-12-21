import 'dart:math';

import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import '../gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random().nextInt(7);
    return SizedBox(
      height: 50.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.musume.values[random].image(),
          Text(TextConstant.nothingThere.getString(context)),
        ],
      ),
    );
  }
}
