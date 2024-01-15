import 'dart:math';

import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import '../gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random().nextInt(7);
    return SizedBox(
      height: 50.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.musume.values[random].image(),
          Text(t.unknownError),
        ],
      ),
    );
  }
}
