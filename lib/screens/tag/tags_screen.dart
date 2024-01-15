import 'dart:async';
import 'dart:developer';

import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:alt_bangumi/providers/tag_screen_provider.dart';
import 'package:alt_bangumi/screens/tag/widgets/custom_tag_grid.dart';
import 'package:alt_bangumi/screens/tag/widgets/tag_loading_widget.dart';
import 'package:alt_bangumi/widgets/custom_error_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagsScreen extends ConsumerStatefulWidget {
  const TagsScreen({super.key});

  static const route = '/tag';

  @override
  ConsumerState<TagsScreen> createState() => _TagScreenState();
}

class _TagScreenState extends ConsumerState<TagsScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  late final TabController _tabController;
  late final TextEditingController _textEditingController;
  late final ScrollController _animeController;
  late final ScrollController _bookController;
  late final ScrollController _musicController;
  late final ScrollController _realController;
  late final ScrollController _gameController;

  final list = ScreenSubjectOption.values
      .where(
        (element) => [
          ScreenSubjectOption.anime,
          ScreenSubjectOption.book,
          ScreenSubjectOption.game,
          ScreenSubjectOption.music,
          ScreenSubjectOption.film,
        ].contains(element),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _tabController = TabController(length: list.length, vsync: this)
      ..addListener(_tabListener);
    _animeController = ScrollController()..addListener(_scrollListener);
    _bookController = ScrollController()..addListener(_scrollListener);
    _gameController = ScrollController()..addListener(_scrollListener);
    _musicController = ScrollController()..addListener(_scrollListener);
    _realController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(tagScreenProvider.notifier)
          .initTags(subjectOption: ScreenSubjectOption.anime);
      ref
          .read(tagScreenProvider.notifier)
          .initTags(subjectOption: ScreenSubjectOption.book);
      ref
          .read(tagScreenProvider.notifier)
          .initTags(subjectOption: ScreenSubjectOption.music);
      ref
          .read(tagScreenProvider.notifier)
          .initTags(subjectOption: ScreenSubjectOption.film);
      ref
          .read(tagScreenProvider.notifier)
          .initTags(subjectOption: ScreenSubjectOption.game);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tabController
      ..removeListener(_tabListener)
      ..dispose();
    _animeController
      ..removeListener(_scrollListener)
      ..dispose();
    _bookController
      ..removeListener(_scrollListener)
      ..dispose();
    _musicController
      ..removeListener(_scrollListener)
      ..dispose();
    _realController
      ..removeListener(_scrollListener)
      ..dispose();
    _gameController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  void _tabListener() async {
    FocusScope.of(context).unfocus();
    final subjectOption = list[_tabController.index];
    ref.read(tagScreenProvider.notifier).initTags(
          subjectOption: subjectOption,
          filter: _textEditingController.text,
        );
  }

  void _scrollListener() async {
    final notifier = ref.read(tagScreenProvider.notifier);
    final subjectOption = list.elementAt(_tabController.index);
    switch (subjectOption) {
      case ScreenSubjectOption.anime:
        if (_animeController.position.atEdge &&
            _animeController.position.pixels > 0) {
          notifier.loadTags(subjectOption: subjectOption);
        }
        break;
      case ScreenSubjectOption.book:
        if (_bookController.position.atEdge &&
            _bookController.position.pixels > 0) {
          notifier.loadTags(subjectOption: subjectOption);
        }
        break;
      case ScreenSubjectOption.music:
        if (_musicController.position.atEdge &&
            _musicController.position.pixels > 0) {
          notifier.loadTags(subjectOption: subjectOption);
        }
        break;
      case ScreenSubjectOption.game:
        if (_gameController.position.atEdge &&
            _gameController.position.pixels > 0) {
          notifier.loadTags(subjectOption: subjectOption);
        }
        break;
      case ScreenSubjectOption.film:
        if (_realController.position.atEdge &&
            _realController.position.pixels > 0) {
          notifier.loadTags(subjectOption: subjectOption);
        }
        break;
      default:
        break;
    }
  }

  void _searchTags(String value) {
    log('timer: ${_timer?.isActive}');
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }
    final notifier = ref.read(tagScreenProvider.notifier);
    final subjectOption = list[_tabController.index];
    _timer = Timer(const Duration(milliseconds: 1000), () async {
      notifier.searchTags(
          subjectOption: subjectOption, filter: _textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tagScreenProvider);
    return ScaffoldCustomed(
      showAppBar: false,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            centerTitle: true,
            surfaceTintColor: Colors.white,
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                ...list.map((e) => Tab(text: e.getString(context))),
              ],
            ),
            title: Text(
              context.t.tag,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: PopupMenuButton(
                  child: const Icon(Icons.more_horiz_outlined),
                  itemBuilder: (context) {
                    String filter = '';
                    final isFiltered = filter.isNotEmpty;
                    final url = '${HttpConstant.host}/'
                        '${isFiltered ? 'search' : list[_tabController.index].name}'
                        '/tag'
                        '${isFiltered ? '/${list[_tabController.index].name}/$filter' : ''}'
                        '?page=${state.page}';
                    return [
                      PopupMenuItem(
                        child: Text(t.viewInBrowser),
                        onTap: () => CommonHelper.showInBrowser(
                            context: context, url: url),
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstant.themeColor, width: 2.0),
                  ),
                  hintText: context.t.search,
                  isDense: true,
                ),
                onChanged: _searchTags,
                onSubmitted: _searchTags,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Builder(
              builder: (context) {
                switch (state.stateEnum) {
                  case TagScreenStateEnum.initial:
                    return const TagLoadingWidget();
                  case TagScreenStateEnum.loading:
                    return const TagLoadingWidget();
                  case TagScreenStateEnum.failure:
                    return const CustomErrorWidget();
                  case TagScreenStateEnum.success:
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        ...list.map((e) {
                          switch (e) {
                            case ScreenSubjectOption.anime:
                              return CustomTagGrid(
                                tags: state.animeTags,
                                scrollController: _animeController,
                                subjectOption: list[_tabController.index],
                              );
                            case ScreenSubjectOption.book:
                              return CustomTagGrid(
                                tags: state.bookTags,
                                scrollController: _bookController,
                                subjectOption: list[_tabController.index],
                              );
                            case ScreenSubjectOption.music:
                              return CustomTagGrid(
                                tags: state.musicTags,
                                scrollController: _musicController,
                                subjectOption: list[_tabController.index],
                              );
                            case ScreenSubjectOption.game:
                              return CustomTagGrid(
                                tags: state.gameTags,
                                scrollController: _gameController,
                                subjectOption: list[_tabController.index],
                              );
                            case ScreenSubjectOption.film:
                              return CustomTagGrid(
                                tags: state.filmTags,
                                scrollController: _realController,
                                subjectOption: list[_tabController.index],
                              );
                            default:
                              return Text('$e');
                          }
                        }),
                      ],
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
