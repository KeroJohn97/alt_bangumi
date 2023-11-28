import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/providers/subject_detail_screen_provider.dart';
import 'package:alt_bangumi/widgets/custom_star_rating_widget.dart';
import 'package:alt_bangumi/widgets/custom_tag_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:alt_bangumi/widgets/subject/character_card.dart';
import 'package:alt_bangumi/widgets/subject/custom_rating_chart_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../models/count_model.dart';
import '../widgets/custom_network_image_widget.dart';

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

  String _getStandardDeviation(CountModel count) {
    return '${CommonHelper.standardDeviation(
      [
        count.rate1!,
        count.rate2!,
        count.rate3!,
        count.rate4!,
        count.rate5!,
        count.rate6!,
        count.rate7!,
        count.rate8!,
        count.rate9!,
        count.rate10!,
      ],
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subjectDetailScreenProvider);
    final stateEnum = state.stateEnum;
    return Builder(
      builder: (context) {
        switch (stateEnum) {
          case SubjectDetailScreenStateEnum.initial:
            // TODO: Handle this case.
            return const Scaffold();
          case SubjectDetailScreenStateEnum.loading:
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          case SubjectDetailScreenStateEnum.failure:
            return const Scaffold();
          case SubjectDetailScreenStateEnum.success:
            final subject = state.subject;
            final episode = state.episode;
            final characters = state.characters;
            final relations = state.relations;
            final persons = state.persons;
            final subjectOption = SearchScreenSubjectOption.values
                .firstWhere((element) => element.value == subject?.type);

            if (subject == null) return const Scaffold();

            final pageCount = ((episode?.total ?? 0) / 32).ceil();
            final total = (int.tryParse('${subject.collection?.wish}') ?? 0) +
                (int.tryParse('${subject.collection?.collect}') ?? 0) +
                (int.tryParse('${subject.collection?.doing}') ?? 0) +
                (int.tryParse('${subject.collection?.onHold}') ?? 0) +
                (int.tryParse('${subject.collection?.dropped}') ?? 0);

            // use for app bar image
            Future.delayed(Duration.zero).then((value) => _imageProvider.value =
                CachedNetworkImageProvider('${subject.images?.small}'));

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
                                SliverAppBar(
                                  pinned: true,
                                  stretch: true,
                                  expandedHeight: 200.0,
                                  backgroundColor: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  foregroundColor: Colors.white,
                                  leading:
                                      const BackButton(color: Colors.black),
                                  titleSpacing: 0.0,
                                  title: Builder(builder: (context) {
                                    if (!isCollapsed) {
                                      return const SizedBox.shrink();
                                    }
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ValueListenableBuilder(
                                            valueListenable: _imageProvider,
                                            builder: (context, value, child) {
                                              if (value == null) {
                                                return const SizedBox.shrink();
                                              }
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
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
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${subject.nameCn}',
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
                                                    rating: subject
                                                            .rating?.score
                                                            ?.toInt() ??
                                                        0,
                                                  ),
                                                  const SizedBox(width: 4.0),
                                                  Text(
                                                      '${subject.rating?.score}'),
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
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.ios_share_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.more_horiz_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                  flexibleSpace: LayoutBuilder(
                                      builder: (context, constraints) {
                                    _constraintsController.add(constraints);
                                    return FlexibleSpaceBar(
                                      background: ValueListenableBuilder(
                                          valueListenable: _imageProvider,
                                          builder: (context, value, child) {
                                            return Stack(
                                              children: [
                                                CustomNetworkImageWidget(
                                                  height: 250.0,
                                                  width: 100.w,
                                                  imageUrl:
                                                      subject.images?.small,
                                                  radius: 0.0,
                                                  heroTag:
                                                      '$value (SliverAppBar)',
                                                  boxFit: BoxFit.cover,
                                                  onTap: () {},
                                                ),
                                                BackdropFilter(
                                                  filter: ImageFilter.blur(),
                                                  child: Container(
                                                      color: Colors.white54),
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
                                ),
                                // SliverPositioned.fill(
                                //   top: 200.0,
                                //   child: Container(),
                                // ),
                              ],
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 12.0),
                                    _SubjectImage(
                                        imageUrl: subject.images?.medium),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: SizedBox(
                                        height: 175.0 - _extraHeight,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 4.0),
                                            Text.rich(
                                              TextSpan(
                                                text: '${subject.nameCn}',
                                                children: [
                                                  TextSpan(
                                                      text: '(${subject.date})',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16.0,
                                                      )),
                                                ],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                            Text('${subject.name}'),
                                            const Spacer(),
                                            Text(
                                              '${subject.rating?.score}',
                                              style: const TextStyle(
                                                color: ColorConstant.themeColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: ListView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                '${subject.collection?.wish}${TextConstant.wished.getString(context)} / '
                                                '${subject.collection?.collect}${TextConstant.watched.getString(context)} / '
                                                '${subject.collection?.doing}${TextConstant.watching.getString(context)} / '
                                                '${subject.collection?.onHold}${TextConstant.onHold.getString(context)} / '
                                                '${subject.collection?.dropped}${TextConstant.dropped.getString(context)} / '
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
                                        if (episode?.total != null &&
                                            episode!.total! > 0) ...[
                                          Row(
                                            children: [
                                              Text(
                                                TextConstant.chapter
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
                                                  Icons.tv_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.list_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.sort_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Container(
                                            transform:
                                                Matrix4.translationValues(
                                                    -12.0, 0, 0.0),
                                            height: 220.0,
                                            child: PageView.builder(
                                              controller: _pageController,
                                              itemCount: pageCount,
                                              itemBuilder:
                                                  (context, pageIndex) {
                                                int itemCount;
                                                if (pageCount == 1) {
                                                  itemCount = episode.total!;
                                                } else if (pageCount ==
                                                    pageIndex + 1) {
                                                  itemCount = episode.total! %
                                                      (32 * pageIndex);
                                                } else {
                                                  itemCount = 32;
                                                }
                                                return GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 8,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10,
                                                    childAspectRatio: 0.8,
                                                  ),
                                                  itemCount: itemCount,
                                                  itemBuilder:
                                                      (context, gridIndex) {
                                                    final index =
                                                        (pageIndex * 32) +
                                                            gridIndex;
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            width: 20.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[200],
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8.0),
                                                              ),
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              '${episode.data?[index].ep}',
                                                              // '${(pageIndex * 32) + (gridIndex + 1)}',
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 4.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                            color: ColorConstant
                                                                .starColor,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          ValueListenableBuilder(
                                              valueListenable: _pageIndex,
                                              builder: (context, value, child) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children:
                                                      List<Widget>.generate(
                                                          pageCount,
                                                          (int index) {
                                                    return Container(
                                                      width: 10.0,
                                                      height: 10.0,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 2.0),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            _pageIndex.value ==
                                                                    index
                                                                ? Colors.black
                                                                : Colors.white,
                                                        border: Border.all(),
                                                      ),
                                                    );
                                                  }),
                                                );
                                              }),
                                        ],
                                        const SizedBox(height: 8.0),
                                        Text(
                                          TextConstant.tag.getString(context),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        if (subject.tags != null) ...[
                                          const SizedBox(height: 8.0),
                                          Wrap(
                                            children: [
                                              ...subject.tags!
                                                  .map(
                                                    (e) => CustomTagWidget(
                                                      onPressed: () {
                                                        // TODO tag search
                                                      },
                                                      tag: '${e.name}',
                                                      count: e.count,
                                                    ),
                                                  )
                                                  .toList(),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              Text(
                                                TextConstant.summary
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
                                                  Icons.translate_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text('${subject.summary}'),
                                          const SizedBox(height: 16.0),
                                          Row(
                                            children: [
                                              Text(
                                                TextConstant.preview
                                                    .getString(context),
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
                                          Row(
                                            children: [
                                              Text(
                                                TextConstant.details
                                                    .getString(context),
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
                                          if (subject.infobox != null)
                                            ...subject.infobox!
                                                .map((e) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Text(
                                                          '${e.key}: ${e.value}'),
                                                    ))
                                                .toList(),
                                          if (subject.rating != null) ...[
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text: TextConstant.rating
                                                        .getString(context),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            ' ${subject.rating?.score}',
                                                        style: const TextStyle(
                                                            color: ColorConstant
                                                                .starColor),
                                                      ),
                                                    ],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 4.0),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    color:
                                                        ColorConstant.starColor,
                                                  ),
                                                  child: Text(
                                                    '${subject.rating?.rank}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      shadows: [
                                                        Shadow(
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                          blurRadius: 5.0,
                                                          color: Colors.black45,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                TextButton(
                                                  onPressed: () {},
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        TextConstant.trend
                                                            .getString(context),
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      const Icon(
                                                        Icons
                                                            .open_in_new_outlined,
                                                        color: Colors.grey,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {},
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        TextConstant.perspective
                                                            .getString(context),
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      const Icon(
                                                        Icons
                                                            .open_in_new_outlined,
                                                        color: Colors.grey,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                '${subject.rating?.total} ${TextConstant.rating.getString(context)}',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12.0),
                                              ),
                                            ),
                                            CustomRatingChartWidget(
                                                rating: subject.rating!),
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    '${TextConstant.userRating.getString(context)} >',
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                GestureDetector(
                                                  child: Row(
                                                    children: [
                                                      Text.rich(
                                                        TextSpan(
                                                          text: TextConstant
                                                              .standardDeviation
                                                              .getString(
                                                                  context),
                                                          children: [
                                                            TextSpan(
                                                              text: _getStandardDeviation(
                                                                  subject
                                                                      .rating!
                                                                      .count!),
                                                              style: const TextStyle(
                                                                  color: ColorConstant
                                                                      .themeColor),
                                                            ),
                                                            const TextSpan(
                                                              text: '基本一致',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                          if (characters != null) ...[
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                Text(
                                                  TextConstant.role
                                                      .getString(context),
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
                                            SingleChildScrollView(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ...characters
                                                      .map(
                                                        (e) => RelationCard(
                                                          relation: e,
                                                          height: 60.0,
                                                          width: 60.0,
                                                          scale: 1.5,
                                                          group:
                                                              SubjectRelationGroup
                                                                  .character,
                                                          option: subjectOption,
                                                          sizeGroup:
                                                              ImageSizeGroup
                                                                  .small,
                                                        ),
                                                      )
                                                      .toList(),
                                                ],
                                              ),
                                            ),
                                          ],
                                          if (persons != null) ...[
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                Text(
                                                  TextConstant.productionStaff
                                                      .getString(context),
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
                                            SingleChildScrollView(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              child:
                                                  Builder(builder: (context) {
                                                final set = <String>{};
                                                return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ...persons
                                                        .where((element) =>
                                                            set.add(
                                                                '${element.id}'))
                                                        .toList()
                                                        .map(
                                                          (e) => RelationCard(
                                                            relation: e,
                                                            height: 60,
                                                            width: 60,
                                                            group: SubjectRelationGroup
                                                                .productionStaff,
                                                            option:
                                                                subjectOption,
                                                            sizeGroup:
                                                                ImageSizeGroup
                                                                    .small,
                                                          ),
                                                        )
                                                        .toList(),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ],
                                          if (relations != null) ...[
                                            const SizedBox(height: 8.0),
                                            Text(
                                              TextConstant.associate
                                                  .getString(context),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            SingleChildScrollView(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ...relations
                                                      .map(
                                                        (e) => RelationCard(
                                                          relation: e,
                                                          height: 120.0,
                                                          width: 80.0,
                                                          group:
                                                              SubjectRelationGroup
                                                                  .relation,
                                                          option: subjectOption,
                                                          sizeGroup:
                                                              ImageSizeGroup
                                                                  .medium,
                                                        ),
                                                      )
                                                      .toList(),
                                                ],
                                              ),
                                            ),
                                          ],
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              Text(
                                                TextConstant.catalog
                                                    .getString(context),
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
                                                TextConstant.log
                                                    .getString(context),
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
                                                TextConstant.post
                                                    .getString(context),
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
                                                TextConstant.comment
                                                    .getString(context),
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
        }
      },
    );
  }
}

class _SubjectImage extends StatelessWidget {
  final String? imageUrl;
  const _SubjectImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: CustomNetworkImageWidget(
        height: 160.0,
        width: 125.0,
        imageUrl: imageUrl,
        radius: 16.0,
      ),
    );
  }
}
