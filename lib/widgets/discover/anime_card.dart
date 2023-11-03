import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bangumi/helpers/sizing_helper.dart';
import 'package:flutter_bangumi/widgets/shimmer_widget.dart';

class AnimeCard extends StatelessWidget {
  final String imageUrl;
  const AnimeCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const ShimmerWidget(),
            ),
          ),
        ),
        Positioned(
          bottom: 0.00,
          child: Container(
            height: 75.0,
            width: 100.w,
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [Colors.black, Colors.black45],
              //   begin: Alignment.bottomCenter,
              //   end: Alignment.topCenter,
              // ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 15.0, spreadRadius: 5.0, color: Colors.black87),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                    '13989人关注',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '陰陽師の異世界転生記',
                    style: TextStyle(
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
    );
  }
}
