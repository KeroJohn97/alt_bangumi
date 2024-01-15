import 'dart:async';
import 'dart:io';

import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../helpers/common_helper.dart';

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
  late final AutoDisposeStateNotifierProvider<SubjectDetailScreenNotifier,
      SubjectDetailScreenState> subjectDetailScreenProvider;

  static const _extraHeight = 30.0;

  @override
  void initState() {
    super.initState();
    subjectDetailScreenProvider = AutoDisposeStateNotifierProvider<
        SubjectDetailScreenNotifier, SubjectDetailScreenState>((ref) {
      return SubjectDetailScreenNotifier();
    });
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
  // TODO: fetchTopic, fetchBlog

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subjectDetailScreenProvider);
    // final stateEnum = state.stateEnum;
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
          backgroundColor: Colors.white,
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
                return RefreshIndicator(
                  // edgeOffset: kToolbarHeight,
                  onRefresh: () async => ref
                      .read(subjectDetailScreenProvider.notifier)
                      .loadSubject('${widget.subjectId}', isRefresh: true),
                  child: Builder(builder: (context) {
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
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                SubjectDetailTitleWidget(
                                    subject: subject,
                                    extraHeight: _extraHeight),
                                // Row(
                                //   children: [
                                //     Text(
                                //      context.t.favourite,
                                //       style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 18.0,
                                //       ),
                                //     ),
                                //     const Spacer(),
                                //     IconButton(
                                //       onPressed: () {},
                                //       icon: const Icon(
                                //         Icons.folder_outlined,
                                //         color: Colors.grey,
                                //       ),
                                //     ),
                                //     IconButton(
                                //       onPressed: () {},
                                //       icon: const Icon(
                                //         Icons.close_outlined,
                                //         color: Colors.grey,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(height: 8.0),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //      context.t.notAddedToFavourites
                                //           ,
                                //       style: const TextStyle(
                                //         fontSize: 16.0,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(height: 8.0),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${subject?.collection?.wish ?? ''}${t.wished} / '
                                        '${subject?.collection?.collect ?? ''}${t.watched} / '
                                        '${subject?.collection?.doing ?? ''}${t.watching} / '
                                        '${subject?.collection?.onHold ?? ''}${t.onHold} / '
                                        '${subject?.collection?.dropped ?? ''}${t.dropped} / '
                                        '${t.total}$total',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                if (subjectOption ==
                                        ScreenSubjectOption.anime ||
                                    subjectOption ==
                                        ScreenSubjectOption.music ||
                                    subjectOption == ScreenSubjectOption.film)
                                  SubjectDetailEpisodeWidget(
                                    episode: episode,
                                    provider: subjectDetailScreenProvider,
                                    pageController: _pageController,
                                    pageCount: pageCount,
                                    pageIndex: _pageIndex,
                                    isMusic: subjectOption ==
                                        ScreenSubjectOption.music,
                                  ),
                                const SizedBox(height: 8.0),
                                Text(
                                  context.t.tag,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                if (subjectOption != null) ...[
                                  const SizedBox(height: 8.0),
                                  SubjectDetailTagWidget(
                                    tags: subject?.tags,
                                    subjectOption: subjectOption,
                                  ),
                                ],
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Text(
                                      context.t.summary,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () => CommonHelper.translate(
                                        context: context,
                                        text: subject?.summary,
                                        isRefresh: false,
                                      ),
                                      icon: const Icon(
                                        Icons.translate_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                                if (subject?.summary != null) ...[
                                  const SizedBox(height: 8.0),
                                  Text(subject?.summary ?? ''),
                                ],
                                // const SizedBox(height: 8.0),
                                // Row(
                                //   children: [
                                //     Text(
                                //      context.t.preview,
                                //       style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 18.0,
                                //       ),
                                //     ),
                                //     const Spacer(),
                                //     TextButton(
                                //       onPressed: () {},
                                //       child: Text(
                                //         '${t.more} >',
                                //         style:
                                //             const TextStyle(color: Colors.grey),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Text(
                                      context.t.details,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    // const Spacer(),
                                    // TextButton(
                                    //   onPressed: () {},
                                    //   child: Text(
                                    //     '${t.revise} >',
                                    //     style:
                                    //         const TextStyle(color: Colors.grey),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                SubjectDetailInfoboxWidget(
                                    infobox: subject?.infobox),
                                SubjectDetailRatingWidget(
                                  rating: subject?.rating,
                                  subjectId: subject?.id,
                                ),
                                SubjectDetailCharacterWidget(
                                  subject: subject,
                                  characters: characters,
                                  subjectOption: subjectOption,
                                ),
                                SubjectDetailPersonWidget(
                                  subject: subject,
                                  persons: persons,
                                  subjectOption: subjectOption,
                                ),
                                SubjectDetailRelationWidget(
                                  relations: relations,
                                  subjectOption: subjectOption,
                                ),
                                const SizedBox(height: 8.0),
                                // Row(
                                //   children: [
                                //     Text(
                                //      context.t.catalog,
                                //       style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 18.0,
                                //       ),
                                //     ),
                                //     const Spacer(),
                                //     TextButton(
                                //       onPressed: () {},
                                //       child: Text(
                                //         '${t.more} >',
                                //         style:
                                //             const TextStyle(color: Colors.grey),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(height: 8.0),
                                // const SizedBox(height: 8.0),
                                // Row(
                                //   children: [
                                //     Text(
                                //      context.t.log,
                                //       style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 18.0,
                                //       ),
                                //     ),
                                //     const Spacer(),
                                //     TextButton(
                                //       onPressed: () {},
                                //       child: Text(
                                //         '${t.more} >',
                                //         style:
                                //             const TextStyle(color: Colors.grey),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(height: 8.0),
                                // const SizedBox(height: 8.0),
                                // Row(
                                //   children: [
                                //     Text(
                                //      context.t.post,
                                //       style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 18.0,
                                //       ),
                                //     ),
                                //     const Spacer(),
                                //     TextButton(
                                //       onPressed: () {},
                                //       child: Text(
                                //         '${t.more} >',
                                //         style:
                                //             const TextStyle(color: Colors.grey),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(height: 8.0),
                                // const SizedBox(height: 8.0),
                                // Row(
                                //   children: [
                                //     Text(
                                //      context.t.comment,
                                //       style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 18.0,
                                //       ),
                                //     ),
                                //     const Spacer(),
                                //     TextButton(
                                //       onPressed: () {},
                                //       child: Text(
                                //         '${t.more} >',
                                //         style:
                                //             const TextStyle(color: Colors.grey),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                );
              }),
        ),
      );
    });
  }
}
