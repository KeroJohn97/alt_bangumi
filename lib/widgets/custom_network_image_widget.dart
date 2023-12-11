import 'package:alt_bangumi/gen/assets.gen.dart';
import 'package:alt_bangumi/helpers/file_helper.dart';
import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

import '../constants/text_constant.dart';
import '../helpers/common_helper.dart';

class CustomNetworkImageWidget extends StatefulWidget {
  final double height;
  final double width;
  final double? radius;
  final String? imageUrl;
  final ImageProvider? imageProvider;
  final VoidCallback? onTap;
  final String? heroTag;
  final Alignment alignment;
  final BoxFit boxFit;

  /// set image scale
  final double scale;
  const CustomNetworkImageWidget({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
    this.imageUrl,
    this.imageProvider,
    this.onTap,
    this.heroTag,
    this.alignment = Alignment.center,
    this.boxFit = BoxFit.contain,
    this.scale = 1.0,
  });

  @override
  State<CustomNetworkImageWidget> createState() =>
      _CustomNetworkImageWidgetState();
}

class _CustomNetworkImageWidgetState extends State<CustomNetworkImageWidget>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<ImageProvider?> _imageProvider;

  @override
  void initState() {
    super.initState();
    _imageProvider = ValueNotifier(widget.imageProvider);
  }

  void _viewPhoto({
    required ImageProvider? imageProvider,
    required String heroTag,
  }) {
    if (widget.onTap != null) {
      widget.onTap!.call();
      return;
    }
    if (imageProvider == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _CustomPhotoView(
          imageProvider: imageProvider,
          heroTag: heroTag,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius ?? 0.00),
      child: (widget.imageProvider != null)
          ? GestureDetector(
              onTap: () => _viewPhoto(
                imageProvider: widget.imageProvider,
                heroTag: widget.heroTag ?? '${widget.imageProvider}',
              ),
              child: Hero(
                tag: widget.heroTag ?? '${widget.imageProvider}',
                child: Transform.scale(
                  scale: widget.scale,
                  child: Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(widget.radius ?? 0.00),
                      image: DecorationImage(
                        alignment: widget.alignment,
                        image: widget.imageProvider!,
                        fit: widget.boxFit,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : (widget.imageUrl == null || widget.imageUrl!.isEmpty)
              ? _ErrorWidget(
                  height: widget.height,
                  width: widget.width,
                  radius: widget.radius,
                )
              : ValueListenableBuilder(
                  valueListenable: _imageProvider,
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () => _viewPhoto(
                          heroTag: widget.heroTag ?? widget.imageUrl!,
                          imageProvider: value),
                      child: Hero(
                        tag: widget.heroTag ?? widget.imageUrl!,
                        child: CachedNetworkImage(
                          height: widget.height,
                          width: widget.width,
                          imageUrl: widget.imageUrl!,
                          imageBuilder: (context, imageProvider) {
                            Future.delayed(Duration.zero).then((value) =>
                                _imageProvider.value = imageProvider);
                            return Transform.scale(
                              scale: widget.scale,
                              alignment: widget.alignment,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      widget.radius ?? 0.00),
                                  image: DecorationImage(
                                    alignment: widget.alignment,
                                    image: imageProvider,
                                    fit: widget.boxFit,
                                  ),
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => _LoadingWidget(
                            height: widget.height,
                            width: widget.width,
                            radius: widget.radius,
                          ),
                          errorWidget: (context, url, error) => _ErrorWidget(
                            height: widget.height,
                            width: widget.width,
                            radius: widget.radius,
                          ),
                          fit: widget.boxFit,
                        ),
                      ),
                    );
                  }),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  final double height;
  final double width;
  final double? radius;
  const _LoadingWidget({
    required this.height,
    required this.width,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0.00),
      ),
      child: CustomShimmerWidget(radius: radius),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final double height;
  final double width;
  final double? radius;
  const _ErrorWidget({
    required this.height,
    required this.width,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0.00),
        ),
        child: Assets.images.default240.image(fit: BoxFit.cover),
        // TODO remove comment below
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Icon(
        //       Icons.broken_image_outlined,
        //       size: width / 2,
        //       color: ColorConstant.themeColor,
        //     ),
        //     Text(
        //       TextConstant.imageBroken.getString(context),
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         color: ColorConstant.themeColor,
        //         fontWeight: FontWeight.bold,
        //         fontSize: width / 5,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class _CustomPhotoView extends StatefulWidget {
  final ImageProvider imageProvider;
  final String heroTag;
  const _CustomPhotoView({
    required this.imageProvider,
    required this.heroTag,
  });

  @override
  State<_CustomPhotoView> createState() => _CustomPhotoViewState();
}

class _CustomPhotoViewState extends State<_CustomPhotoView> {
  late final PhotoViewController _photoViewController;
  late final PhotoViewScaleStateController _scaleStateController;
  late final ValueNotifier<bool> _disabledValue;

  @override
  void initState() {
    super.initState();
    _photoViewController = PhotoViewController();
    _scaleStateController = PhotoViewScaleStateController();
    _disabledValue = ValueNotifier(false);
  }

  void _enable() => _disabledValue.value = false;

  @override
  void dispose() {
    _photoViewController.dispose();
    _scaleStateController.dispose();
    super.dispose();
  }

  // TODO remove unused code
  void _checkScaleEndDetails({
    required BuildContext context,
    required ScaleEndDetails details,
    required PhotoViewControllerValue controllerValue,
  }) {
    // widget.photoViewController.scale =
    //     (1.0 / details.velocity.pixelsPerSecond.dy / 100.h).clamp(0.2, 1.0);
    // widget.photoViewController.position = Offset(
    //   widget.photoViewController.position.dx,
    //   widget.photoViewController.position.dy + 5.h,
    // );
    // setState(() {
    //   updateScale(scale);
    //   updatePosition(
    //     Offset(
    //       widget.photoViewController.position.dx,
    //       widget.photoViewController.position.dy + 5.h,
    //     ),
    //   );
    // });
    final isZoomedIn =
        _scaleStateController.scaleState == PhotoViewScaleState.zoomedIn;
    final otherPosition = controllerValue.position.dx >= 10.0 ||
        controllerValue.position.dx <= -10.0 ||
        controllerValue.position.dy >= 10.0 ||
        controllerValue.position.dy <= -10.0;
    if (!isZoomedIn && otherPosition) {
      _photoViewController.position = const Offset(0, 0);
    }
    // if (!isZoomedIn && controllerValue.position.dy >= 0) {
    //   _photoViewController.scale = 0.95 * (_photoViewController.scale ?? 1.00);
    // }
    final isMovingDown =
        details.velocity.pixelsPerSecond.dy.abs() > (isZoomedIn ? 1600 : 800);
    if (isMovingDown) context.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          imageProvider: widget.imageProvider,
          controller: _photoViewController,
          scaleStateController: _scaleStateController,
          minScale: PhotoViewComputedScale.contained,
          maxScale: 2.0,
          onScaleEnd: (context, details, controllerValue) =>
              _checkScaleEndDetails(
            context: context,
            details: details,
            controllerValue: controllerValue,
          ),
          heroAttributes: PhotoViewHeroAttributes(tag: widget.heroTag),
          enablePanAlways: true,
        ),
        Positioned(
          bottom: 8.0,
          right: 8.0,
          child: ValueListenableBuilder(
              valueListenable: _disabledValue,
              builder: (context, disabled, child) {
                return IconButton(
                  icon: const Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  onPressed: () async {
                    if (disabled == true) return;
                    _disabledValue.value = true;
                    final storagePermission =
                        await CommonHelper.getStoragePermission(context);
                    if (storagePermission == false) {
                      if (!mounted) return _enable();
                      CommonHelper.showToast(
                        TextConstant.pleaseGrantStoragePermission
                            .getString(context),
                      );
                      return _enable();
                    }
                    final file = await FileHelper.saveImageProvider(
                        widget.imageProvider);
                    if (!mounted) return _enable();
                    if (file != null) {
                      CommonHelper.showToast(
                        context.formatString(
                          TextConstant.theFileSaved.getString(context),
                          [file.path],
                        ),
                      ).then((value) => _enable());
                    } else {
                      CommonHelper.showToast(
                        TextConstant.fileSaveTimeout.getString(context),
                      ).then((value) => _enable());
                    }
                  },
                );
              }),
        ),
      ],
    );
  }
}
