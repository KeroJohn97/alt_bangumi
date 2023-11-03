import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bangumi/widgets/shimmer_widget.dart';

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
              errorWidget: (context, url, error) => const ShimmerWidget(),
            );
          }),
    );
  }
}
