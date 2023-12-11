import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/relation_model/relation_model.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';
import 'package:alt_bangumi/screens/subject_sharing_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_network_image_widget.dart';
import 'custom_star_rating_widget.dart';

class SubjectDetailSliverAppBar extends StatelessWidget {
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

  _showInBrowser(BuildContext context) async {
    await CommonHelper.showInBrowser(
      context: context,
      url: '${HttpConstant.host}/subject/${subject?.id}',
    );
  }

  _moveToScreenshot(BuildContext context) {
    if (subject == null || imageProvider.value == null) return;
    final temp = subject?.tags;
    if (temp == null) return;
    temp.removeWhere((element) => element.name == 'TV');
    final tags = temp.getRange(0, temp.length >= 5 ? 5 : temp.length).toList();
    final shortTag =
        '${person?.name} · ${tags.map((e) => e.name).toList().join(' · ')}';
    log('message: $shortTag');
    context.push(
      SubjectSharingScreen.route,
      extra: {
        SubjectSharingScreen.idKey: '${subject?.id}',
        SubjectSharingScreen.shortTagKey: shortTag,
        SubjectSharingScreen.imageProviderKey: imageProvider.value,
        SubjectSharingScreen.nameKey: '${subject?.name}',
        SubjectSharingScreen.summaryKey: '${subject?.summary}',
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
        if (!isCollapsed) {
          return const SizedBox.shrink();
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: imageProvider,
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
            if (subject != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject?.nameCn ?? '',
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
                          rating: subject?.rating?.score?.toInt() ?? 0,
                        ),
                        const SizedBox(width: 4.0),
                        Text('${subject?.rating?.score ?? ''}'),
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
        constraintsController.add(constraints);
        return FlexibleSpaceBar(
          background: ValueListenableBuilder(
              valueListenable: imageProvider,
              builder: (context, value, child) {
                return Stack(
                  children: [
                    CustomNetworkImageWidget(
                      height: 250.0,
                      width: 100.w,
                      imageUrl: subject?.images?.small,
                      radius: 0.0,
                      heroTag: '$value (SliverAppBar)',
                      boxFit: BoxFit.cover,
                      onTap: () {},
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(),
                      child: Container(color: Colors.white54),
                    ),
                    // Positioned(
                    //   bottom: -155.0,
                    //   left: 12.0,
                    //   child: _SubjectImage(
                    //       imageUrl:
                    //           subject.images?.large),
                    // ),
                  ],
                );
              }),
        );
      }),
    );
  }
}
