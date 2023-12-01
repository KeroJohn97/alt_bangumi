import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:flutter/material.dart';
import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';

class BannerWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const BannerWidget({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: PageView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return CustomShimmerWidget(
              height: 100.0,
              width: 80.w,
            );
          }),
    );
  }
}
