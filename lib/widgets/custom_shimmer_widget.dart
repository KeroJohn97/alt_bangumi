import 'dart:math';

import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double? borderRadius;
  const CustomShimmerWidget({
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: Duration(milliseconds: Random().nextInt(5000).clamp(1500, 5000)),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: ColorConstant.themeColor,
          borderRadius: borderRadius == null
              ? null
              : BorderRadius.circular(borderRadius!),
        ),
      ),
    );
  }
}
