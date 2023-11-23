import 'dart:io';

import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:image_picker/image_picker.dart';

Future presentImage({
  required BuildContext context,
  required XFile image,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => ViewImageDialog(images: [image], index: 0),
  );
}

Future presentImageList({
  required BuildContext context,
  required List<XFile> images,
  required int index,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => ViewImageDialog(images: images, index: index),
  );
}

class ViewImageDialog extends StatefulWidget {
  final List<XFile> images;
  final int index;
  const ViewImageDialog({
    Key? key,
    required this.images,
    required this.index,
  }) : super(key: key);

  @override
  State<ViewImageDialog> createState() => _ViewImageDialogState();
}

class _ViewImageDialogState extends State<ViewImageDialog> {
  late final PageController _controller;
  var _index = 0;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _controller = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateIndex(int index) {
    setState(() {
      _index = index;
    });
  }

  void _removeImg() async {
    // if (_index != 0) _index = _index - 1;
    widget.images.removeAt(_index);
    setState(() {});
    Navigator.pop(context, '');
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    const horizontalPadding = 40.0;
    const verticalPadding = 24.0;
    final radius = 2.h;
    final iconSize = 2.h;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
            children: [
              Dialog(
                child: PhotoViewGallery.builder(
                  pageController: _controller,
                  itemCount: widget.images.length,
                  onPageChanged: _updateIndex,
                  builder: (_, index) {
                    final file = File(widget.images[index].path);
                    return PhotoViewGalleryPageOptions(
                      imageProvider: Image.file(file).image,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained * 2,
                    );
                  },
                ),
              ),
              if (widget.images.length > 1) ...[
                if (_index > 0)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: horizontalPadding + 2.w,
                    child: _ArrowButton(
                      icon: Icons.keyboard_arrow_left,
                      onTap: () => _controller.animateToPage(
                        _index - 1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      ),
                    ),
                  ),
                if (_index < widget.images.length - 1)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: horizontalPadding + 2.w,
                    child: _ArrowButton(
                      icon: Icons.keyboard_arrow_right,
                      onTap: () => _controller.animateToPage(
                        _index + 1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: verticalPadding + 1.h,
                  right: horizontalPadding + 2.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.8.h, horizontal: 4.5.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: AutoSizeText(
                      '${_index + 1}/${widget.images.length}',
                      maxLines: 1,
                      stepGranularity: 0.1,
                    ),
                  ),
                ),
              ],
              Positioned(
                top: radius / 2 + iconSize / 2,
                right: horizontalPadding - (radius / 2 + iconSize / 2),
                child: GestureDetector(
                  onTap: Navigator.of(context).pop,
                  behavior: HitTestBehavior.translucent,
                  child: CircleAvatar(
                    radius: radius,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.close,
                      size: iconSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        //   child: RectangularButton(
        //     label: TextConstant.removeImg,
        //     onPressed: _removeImg,
        //     buttonColor: Colors.white,
        //     textColor: primaryColor,
        //   ),
        // ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ArrowButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap.call,
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.4),
        child: Icon(
          icon,
          color: Colors.white.withOpacity(0.6),
          size: 3.h,
        ),
      ),
    );
  }
}
