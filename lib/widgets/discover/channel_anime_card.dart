import 'package:alt_bangumi/screens/subject_detail_screen.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChannelAnimeCard extends StatelessWidget {
  final String imageUrl;
  final String followers;
  final String title;
  final int? id;
  final double height;
  final double width;
  final AutoSizeGroup autoSizeGroup;
  final double minFontSize;
  final double maxFontSize;

  const ChannelAnimeCard({
    super.key,
    required this.imageUrl,
    required this.followers,
    required this.title,
    required this.id,
    required this.height,
    required this.width,
    required this.autoSizeGroup,
    this.minFontSize = 12.0,
    this.maxFontSize = double.infinity,
  });

  static final _borderRadius = BorderRadius.circular(8.0);

  _onTap(BuildContext context) {
    context.push(
      SubjectDetailScreen.route,
      extra: {
        SubjectDetailScreen.subjectIdKey: id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: GestureDetector(
        onTap: () => _onTap(context),
        child: Stack(
          children: [
            CustomNetworkImageWidget(
              height: height,
              width: width,
              radius: 8.0,
              imageUrl: imageUrl,
              boxFit: BoxFit.cover,
              onTap: () => _onTap(context),
            ),
            Positioned(
              bottom: 0.00,
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15.0,
                      spreadRadius: 10.0,
                      color: Colors.black54,
                    ),
                  ],
                ),
                child: Container(
                  width: width,
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        followers,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: maxFontSize != double.infinity
                              ? maxFontSize - 5.0
                              : 16.0,
                        ),
                      ),
                      AutoSizeText(
                        title,
                        group: autoSizeGroup,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        minFontSize: minFontSize,
                        maxFontSize: maxFontSize,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
