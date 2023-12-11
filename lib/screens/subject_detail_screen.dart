import 'dart:async';
import 'dart:io';

import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/providers/subject_detail_screen_provider.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:alt_bangumi/widgets/subject_detail_character_widget.dart';
import 'package:alt_bangumi/widgets/subject_detail_episode_widget.dart';
import 'package:alt_bangumi/widgets/subject_detail_infobox_widget.dart';
import 'package:alt_bangumi/widgets/subject_detail_person_widget.dart';
import 'package:alt_bangumi/widgets/subject_detail_rating_widget.dart';
import 'package:alt_bangumi/widgets/subject_detail_relation_widget.dart';
import 'package:alt_bangumi/widgets/subject_detail_sliver_app_bar.dart';
import 'package:alt_bangumi/widgets/subject_detail_tag_widget.dart';
import 'package:alt_bangumi/widgets/subject_detail_title_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SubjectDetailScreen extends ConsumerStatefulWidget {
  static const route = '/subject';
  final int subjectId;
  const SubjectDetailScreen({super.key, required this.subjectId});

  static const subjectIdKey = 'subject_id_key';

  @override
  ConsumerState<SubjectDetailScreen> createState() =>
      _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends ConsumerState<SubjectDetailScreen> {
  late final ScrollController _scrollController;
  late final PageController _pageController;
  late final ValueNotifier<int> _pageIndex;
  late final ValueNotifier<ImageProvider?> _imageProvider;
  late final TextSelectionControls _selectionControls;
  late final StreamController<BoxConstraints?> _constraintsController;

  static const _extraHeight = 30.0;

  @override
  void initState() {
    super.initState();
    _pageIndex = ValueNotifier(0);
    _imageProvider = ValueNotifier(null);
    _scrollController = ScrollController();
    _pageController = PageController()..addListener(_pageListener);
    _selectionControls = Platform.isAndroid
        ? MaterialTextSelectionControls()
        : CupertinoTextSelectionControls();
    _constraintsController = StreamController.broadcast();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(subjectDetailScreenProvider.notifier)
          .loadSubject('${widget.subjectId}');
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _constraintsController.close();
    _pageController
      ..removeListener(_pageListener)
      ..dispose();
    super.dispose();
  }

  void _pageListener() {
    if (_pageController.page == null) return;
    _pageIndex.value = _pageController.page!.round();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subjectDetailScreenProvider);
    final stateEnum = state.stateEnum;
    return Builder(builder: (context) {
      final subject = state.subject;
      final episode = state.episode;
      final characters = state.characters;
      final relations = state.relations;
      final persons = state.persons;
      final subjectOption = ScreenSubjectOption.values
          .firstWhereOrNull((element) => element.value == subject?.type);

      final pageCount = ((episode?.total ?? 0) / 32).ceil();
      final total = (int.tryParse('${subject?.collection?.wish}') ?? 0) +
          (int.tryParse('${subject?.collection?.collect}') ?? 0) +
          (int.tryParse('${subject?.collection?.doing}') ?? 0) +
          (int.tryParse('${subject?.collection?.onHold}') ?? 0) +
          (int.tryParse('${subject?.collection?.dropped}') ?? 0);

      // use for app bar image
      Future.delayed(Duration.zero).then((value) {
        if (subject?.images?.small != null) {
          _imageProvider.value =
              CachedNetworkImageProvider('${subject?.images?.small}');
        }
      });

      return SelectionArea(
        selectionControls: _selectionControls,
        child: ScaffoldCustomed(
          showAppBar: false,
          leading: const SizedBox.shrink(),
          backgroundColor: Colors.transparent,
          body: StreamBuilder(
              stream: _constraintsController.stream,
              builder: (context, snapshot) {
                double? top;
                bool isCollapsed = false;
                if (snapshot.data != null) {
                  top = snapshot.data!.biggest.height;
                  isCollapsed = top <=
                      MediaQuery.of(context).padding.top +
                          kToolbarHeight +
                          20.0;
                }
                return Builder(builder: (context) {
                  return CustomScrollView(
                    controller: _scrollController,
                    clipBehavior: Clip.none,
                    slivers: [
                      SliverStack(
                        // insetOnOverlap: true,
                        children: [
                          SubjectDetailSliverAppBar(
                            isCollapsed: isCollapsed,
                            imageProvider: _imageProvider,
                            subject: subject,
                            constraintsController: _constraintsController,
                            person: persons?.isNotEmpty ?? false
                                ? persons?.first
                                : null,
                          ),
                          // SliverPositioned.fill(
                          //   top: 200.0,
                          //   child: Container(),
                          // ),
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  SubjectDetailTitleWidget(
                                      subject: subject,
                                      extraHeight: _extraHeight),
                                  Row(
                                    children: [
                                      Text(
                                        TextConstant.favourite
                                            .getString(context),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.folder_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.close_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        TextConstant.notAddedToFavourites
                                            .getString(context),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${subject?.collection?.wish ?? ''}${TextConstant.wished.getString(context)} / '
                                          '${subject?.collection?.collect ?? ''}${TextConstant.watched.getString(context)} / '
                                          '${subject?.collection?.doing ?? ''}${TextConstant.watching.getString(context)} / '
                                          '${subject?.collection?.onHold ?? ''}${TextConstant.onHold.getString(context)} / '
                                          '${subject?.collection?.dropped ?? ''}${TextConstant.dropped.getString(context)} / '
                                          '${TextConstant.total.getString(context)}$total',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SubjectDetailEpisodeWidget(
                                    episode: episode,
                                    pageController: _pageController,
                                    pageCount: pageCount,
                                    pageIndex: _pageIndex,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    TextConstant.tag.getString(context),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  SubjectDetailTagWidget(tags: subject?.tags),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Text(
                                        TextConstant.summary.getString(context),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.translate_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  if (subject?.summary != null)
                                    Text(subject?.summary ?? ''),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Text(
                                        TextConstant.preview.getString(context),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          '${TextConstant.more.getString(context)} >',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    children: [
                                      Text(
                                        TextConstant.details.getString(context),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          '${TextConstant.revise.getString(context)} >',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  SubjectDetailInfoboxWidget(
                                      infobox: subject?.infobox),
                                  SubjectDetailRatingWidget(
                                      rating: subject?.rating),
                                  SubjectDetailCharacterWidget(
                                      characters: characters,
                                      subjectOption: subjectOption),
                                  SubjectDetailPersonWidget(
                                      persons: persons,
                                      subjectOption: subjectOption),
                                  SubjectDetailRelationWidget(
                                      relations: relations,
                                      subjectOption: subjectOption),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Text(
                                        TextConstant.catalog.getString(context),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          '${TextConstant.more.getString(context)} >',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Text(
                                        TextConstant.log.getString(context),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          '${TextConstant.more.getString(context)} >',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Text(
                                        TextConstant.post.getString(context),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          '${TextConstant.more.getString(context)} >',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Text(
                                        TextConstant.comment.getString(context),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          '${TextConstant.more.getString(context)} >',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SliverToBoxAdapter(
                      //   child: Container(
                      //     transform: Matrix4.translationValues(
                      //         0.0, -_extraHeight, 0.0),
                      //     child:
                      //     ),
                      //   ),
                      // ),
                    ],
                  );
                });
              }),
        ),
      );
    });
  }
}
