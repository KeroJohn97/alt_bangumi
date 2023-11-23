import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/widgets/shimmer_widget.dart';

class AnimeCard extends StatelessWidget {
  final String imageUrl;
  final String followers;
  final String title;
  const AnimeCard({
    super.key,
    required this.imageUrl,
    required this.followers,
    required this.title,
  });

  static final _borderRadius = BorderRadius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const ShimmerWidget(),
          ),
          Positioned(
            bottom: 0.00,
            child: Container(
              height: 75.0,
              width: 100.w,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15.0,
                    spreadRadius: 10.0,
                    color: Colors.black54,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '$followers人关注',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
