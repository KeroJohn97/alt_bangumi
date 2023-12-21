import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class CustomGifWidget extends StatefulWidget {
  final String directoryPath;
  final int fileCount;
  final String filePrefix;
  const CustomGifWidget({
    super.key,
    required this.directoryPath,
    required this.fileCount,
    required this.filePrefix,
  });

  @override
  State<CustomGifWidget> createState() => _CustomGifWidgetState();
}

class _CustomGifWidgetState extends State<CustomGifWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<int> _animation;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
      lowerBound: 0,
      upperBound: widget.fileCount.toDouble() - 1,
    )..repeat();
    _animation = IntTween(begin: 0, end: widget.fileCount).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const imageHeight = 50;
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          int index = (_animation.value / 100).floor() % widget.fileCount + 1;
          return Container(
            color: Colors.black54,
            height: 100.h,
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  '${widget.directoryPath}/${widget.filePrefix}${'$index'.padLeft(3, '0')}.gif',
                  fit: BoxFit.contain,
                  cacheHeight: imageHeight,
                  height: imageHeight.toDouble(),
                  gaplessPlayback: true,
                ),
                const SizedBox(height: 8.0),
                CustomShimmerWidget(
                  child: Text(
                    TextConstant.loadingWithDots.getString(context),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
