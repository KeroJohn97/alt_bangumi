import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/relation_model/relation_model.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';
import 'package:alt_bangumi/screens/subject_sharing_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import 'custom_network_image_widget.dart';
import 'custom_star_rating_widget.dart';

class SubjectDetailSliverAppBar extends StatefulWidget {
  final bool isCollapsed;
  final ValueNotifier<ImageProvider?> imageProvider;
  final SubjectModel? subject;
  final StreamController constraintsController;
  final RelationModel? person;
  const SubjectDetailSliverAppBar({
    super.key,
    required this.isCollapsed,
    required this.imageProvider,
    required this.subject,
    required this.constraintsController,
    required this.person,
  });

  @override
  State<SubjectDetailSliverAppBar> createState() =>
      _SubjectDetailSliverAppBarState();
}

class _SubjectDetailSliverAppBarState extends State<SubjectDetailSliverAppBar> {
  bool isVisible = true;

  @override
  void didUpdateWidget(SubjectDetailSliverAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (mounted) setState(() => isVisible = false);
    });
  }

  _showInBrowser(BuildContext context) async {
    await CommonHelper.showInBrowser(
      context: context,
      url: '${HttpConstant.host}/subject/${widget.subject?.id}',
    );
  }

  _moveToScreenshot(BuildContext context) {
    if (widget.subject == null || widget.imageProvider.value == null) return;
    final temp = widget.subject?.tags;
    if (temp == null) return;
    temp.removeWhere((element) => element.name == 'TV');
    final tags = temp.getRange(0, temp.length >= 5 ? 5 : temp.length).toList();
    final shortTag =
        '${widget.person?.name} · ${tags.map((e) => e.name).toList().join(' · ')}';
    log('message: $shortTag');
    context.push(
      SubjectSharingScreen.route,
      extra: {
        SubjectSharingScreen.idKey: '${widget.subject?.id}',
        SubjectSharingScreen.shortTagKey: shortTag,
        SubjectSharingScreen.imageProviderKey: widget.imageProvider.value,
        SubjectSharingScreen.nameKey: '${widget.subject?.name}',
        SubjectSharingScreen.summaryKey: '${widget.subject?.summary}',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 200.0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      foregroundColor: Colors.white,
      leading: const BackButton(color: Colors.black),
      titleSpacing: 0.0,
      title: Builder(builder: (context) {
        if (!widget.isCollapsed) {
          return const SizedBox.shrink();
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: widget.imageProvider,
                builder: (context, value, child) {
                  if (value == null) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 0.5,
                          spreadRadius: 0.25,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                    child: CustomNetworkImageWidget(
                      height: 40.0,
                      width: 27.5,
                      radius: 8.0,
                      imageProvider: value,
                      heroTag: '$value (AppBar)',
                      onTap: () {},
                    ),
                  );
                }),
            const SizedBox(width: 16.0),
            if (widget.subject != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (widget.subject?.nameCn?.isNotEmpty ?? false)
                          ? '${widget.subject?.nameCn}'
                          : widget.subject?.name ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        CustomStarRatingWidget(
                          size: 12.0,
                          rating: widget.subject?.rating?.score?.toInt() ?? 0,
                        ),
                        const SizedBox(width: 4.0),
                        Text('${widget.subject?.rating?.score ?? ''}'),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        );
      }),
      actions: [
        IconButton(
          onPressed: () => _showInBrowser(context),
          icon: const Icon(
            Icons.open_in_browser_outlined,
            color: Colors.black87,
            size: 24.0,
          ),
        ),
        IconButton(
          onPressed: () => _moveToScreenshot(context),
          icon: const Icon(
            Icons.ios_share_outlined,
            color: Colors.black87,
          ),
        ),
      ],
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        widget.constraintsController.add(constraints);
        return FlexibleSpaceBar(
          background: ValueListenableBuilder(
              valueListenable: widget.imageProvider,
              builder: (context, value, child) {
                return Stack(
                  children: [
                    CustomNetworkImageWidget(
                      height: 250.0,
                      width: 100.w,
                      imageUrl: widget.subject?.images?.small,
                      radius: 0.0,
                      heroTag: '$value (SliverAppBar)',
                      boxFit: BoxFit.cover,
                      onTap: () {},
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(),
                      child: Container(color: Colors.white54),
                    ),
                  ],
                );
              }),
          title: widget.isCollapsed
              ? null
              : Visibility(
                  visible: isVisible,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Visibility(
                      visible: widget.subject?.apiDate != null,
                      child: AutoSizeText(
                        context.formatString(
                          TextConstant.somethingUpdatedAt.getString(context),
                          [widget.subject?.apiDate],
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxFontSize: 14.0,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
        );
      }),
    );
  }
}
