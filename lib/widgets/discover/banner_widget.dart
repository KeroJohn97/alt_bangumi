import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:alt_bangumi/widgets/shimmer_widget.dart';

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
            return CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const ShimmerWidget(),
              errorWidget: (context, url, error) => const ShimmerWidget(),
            );
          }),
    );
  }
}
