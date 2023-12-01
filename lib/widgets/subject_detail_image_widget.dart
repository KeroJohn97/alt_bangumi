import 'package:flutter/material.dart';

import 'custom_network_image_widget.dart';

class SubjectDetailImageWidget extends StatelessWidget {
  final String? imageUrl;
  const SubjectDetailImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: CustomNetworkImageWidget(
        height: 160.0,
        width: 125.0,
        imageUrl: imageUrl,
        radius: 16.0,
      ),
    );
  }
}
