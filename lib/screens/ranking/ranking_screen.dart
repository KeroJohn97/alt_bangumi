import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/images_model.dart';
import 'package:alt_bangumi/models/rating_model.dart';
import 'package:alt_bangumi/models/search_model/search_info_model.dart';
import 'package:alt_bangumi/providers/ranking_screen_provider.dart';
import 'package:alt_bangumi/screens/ranking/widgets/page_row_widget.dart';
import 'package:alt_bangumi/screens/ranking/widgets/ranking_loading_widget.dart';
import 'package:alt_bangumi/widgets/custom_empty_widget.dart';
import 'package:alt_bangumi/widgets/discover/search/search_grid_card.dart';
import 'package:alt_bangumi/widgets/discover/search/search_list_card.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../constants/http_constant.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/custom_popup_menu_button.dart';

class RankingScreen extends ConsumerStatefulWidget {
  final String url;
  const RankingScreen({super.key, required this.url});

  static const route = '/ranking';
  static const urlKey = 'url_key';

  @override
  ConsumerState<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends ConsumerState<RankingScreen>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<ScreenLayoutOption> _layoutOption;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _layoutOption = ValueNotifier(ScreenLayoutOption.list);
    _animationController = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 50),
      reverseDuration: const Duration(milliseconds: 50),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rankingScreenProvider.notifier).search();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _search() {
    ref.read(rankingScreenProvider.notifier).search();
  }

  void _viewInBrowser() {
    final state = ref.read(rankingScreenProvider);
    final type = state.subjectOption.filterUrl(
      animeTypeOption: state.animeTypeOption,
      bookTypeOption: state.bookTypeOption,
      gameTypeOption: state.gameTypeOption,
      realTypeOption: state.filmTypeOption,
    );
    final url = '${HttpConstant.host}/${state.subjectOption.name}/browser'
        '${type ?? ''}'
        '${_airtimeString(state.year, state.month)}'
        '?sort=${state.sortOption.name}&page=${state.page}';
    CommonHelper.showInBrowser(context: context, url: url);
  }

  String _airtimeString(
    int? year,
    int? month,
  ) {
    if (year == null) return '';
    return '/airtime/$year' '${month == null ? '' : '-$month'}';
  }

  void _selectTypeOption({required String selectedType}) {
    final state = ref.read(rankingScreenProvider);
    final notifier = ref.read(rankingScreenProvider.notifier);
    switch (state.subjectOption) {
      case ScreenSubjectOption.anime:
        notifier.selectAnimeTypeOption(
          AnimeTypeOption.values.firstWhere(
            (element) => element.getString(context) == selectedType,
          ),
        );
        break;
      case ScreenSubjectOption.book:
        notifier.selectBookTypeOption(
          BookTypeOption.values.firstWhere(
            (element) => element.getString(context) == selectedType,
          ),
        );
        break;
      case ScreenSubjectOption.film:
        notifier.selectRealTypeOption(
          RealTypeOption.values.firstWhere(
            (element) => element.getString(context) == selectedType,
          ),
        );
        break;
      case ScreenSubjectOption.game:
        notifier.selectGameTypeOption(
          GameTypeOption.values.firstWhere(
            (element) => element.getString(context) == selectedType,
          ),
        );
        break;
      default:
        break;
    }
    _search();
  }

  void _selectPage(int page) {
    ref.read(rankingScreenProvider.notifier).selectPage(page);
    _search();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rankingScreenProvider);
    return ScaffoldCustomed(
      leading: const BackButton(color: Colors.black),
      trailing: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: _viewInBrowser,
                child: Text(TextConstant.viewInBrowser.getString(context)),
              ),
            ];
          },
          child: const Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
        ),
      ),
      title: TextConstant.ranking.getString(context),
      body: CustomScrollView(
        slivers: [
          SliverPinnedHeader(
            child: Container(
              height: 40.0,
              width: 100.w,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPopupMenuButton(
                    tag: state.subjectOption.getString(context),
                    iconWidget: const Icon(
                      Icons.filter_list_outlined,
                      size: 16.0,
                    ),
                    menuItem: [
                      ...ScreenSubjectOption.values
                          .whereNot(
                            (element) =>
                                element == ScreenSubjectOption.entry ||
                                element == ScreenSubjectOption.character ||
                                element == ScreenSubjectOption.user,
                          )
                          .map(
                            (e) => PopupMenuItem(
                              child: Text(e.getString(context)),
                              onTap: () {
                                ref
                                    .read(rankingScreenProvider.notifier)
                                    .selectSubject(e);
                                _search();
                              },
                            ),
                          )
                          .toList(),
                    ],
                  ),
                  Builder(builder: (context) {
                    final currentYear = DateTime.now().year;
                    return CustomPopupMenuButton(
                      tag:
                          '${state.year ?? TextConstant.year.getString(context)}',
                      menuItem: [
                        ...[
                          null,
                          ...List.generate(
                            currentYear - 1980 + 1,
                            (index) => currentYear - index,
                          )
                        ]
                            .map(
                              (e) => PopupMenuItem(
                                child: Text(
                                  '${e ?? TextConstant.entire.getString(context)}',
                                ),
                                onTap: () {
                                  ref
                                      .read(rankingScreenProvider.notifier)
                                      .selectYear(e);
                                  _search();
                                },
                              ),
                            )
                            .toList(),
                      ],
                    );
                  }),
                  CustomPopupMenuButton(
                    tag:
                        '${state.month ?? TextConstant.month.getString(context)}',
                    menuItem: [
                      ...[
                        null,
                        ...List.generate(
                          12,
                          (index) => index + 1,
                        )
                      ]
                          .map(
                            (e) => PopupMenuItem(
                              child: Text(
                                  '${e ?? TextConstant.entire.getString(context)}'),
                              onTap: () {
                                ref
                                    .read(rankingScreenProvider.notifier)
                                    .selectMonth(e);
                                _search();
                              },
                            ),
                          )
                          .toList(),
                    ],
                  ),
                  if (state.subjectOption != ScreenSubjectOption.music)
                    CustomPopupMenuButton(
                      tag: state.subjectOption.filterString(
                            context: context,
                            animeTypeOption: state.animeTypeOption,
                            bookTypeOption: state.bookTypeOption,
                            gameTypeOption: state.gameTypeOption,
                            realTypeOption: state.filmTypeOption,
                          ) ??
                          TextConstant.type.getString(context),
                      menuItem: [
                        ...[
                          if (state.subjectOption == ScreenSubjectOption.anime)
                            ...AnimeTypeOption.values
                                .map((e) => e.getString(context)),
                          if (state.subjectOption == ScreenSubjectOption.book)
                            ...BookTypeOption.values
                                .map((e) => e.getString(context)),
                          if (state.subjectOption == ScreenSubjectOption.film)
                            ...RealTypeOption.values
                                .map((e) => e.getString(context)),
                          if (state.subjectOption == ScreenSubjectOption.game)
                            ...GameTypeOption.values
                                .map((e) => e.getString(context)),
                        ]
                            .map(
                              (e) => PopupMenuItem(
                                child: Text(e),
                                onTap: () => _selectTypeOption(selectedType: e),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ValueListenableBuilder(
                      valueListenable: _layoutOption,
                      builder: (context, layoutOption, child) {
                        switch (layoutOption) {
                          case ScreenLayoutOption.grid:
                            return IconButton(
                              onPressed: () {
                                _animationController.reverse().then((value) {
                                  _layoutOption.value = ScreenLayoutOption.list;
                                  _animationController.forward();
                                });
                              },
                              icon: const Icon(Icons.grid_view,
                                  color: Colors.black),
                            );
                          case ScreenLayoutOption.list:
                            return IconButton(
                              onPressed: () {
                                _animationController.reverse().then((value) {
                                  _layoutOption.value = ScreenLayoutOption.grid;
                                  _animationController.forward();
                                });
                              },
                              icon: const Icon(Icons.list, color: Colors.black),
                            );
                        }
                      }),
                ],
              ),
            ),
          ),
          Builder(
            builder: (context) {
              switch (state.stateEnum) {
                case RankingScreenStateEnum.initial:
                  return const SliverToBoxAdapter(
                      child: RankingLoadingWidget());
                case RankingScreenStateEnum.loading:
                  return const SliverToBoxAdapter(
                      child: RankingLoadingWidget());
                case RankingScreenStateEnum.failure:
                  return const SliverToBoxAdapter(child: CustomErrorWidget());
                case RankingScreenStateEnum.success:
                  final result = state.results;
                  final list = result?.map(
                    (e) {
                      final id = int.tryParse('${e.id?.split('/').last}');
                      final cover = '${e.cover.ensureUrlScheme()}';
                      final rank = int.tryParse('${e.rank.getNumber()}');
                      final score = double.tryParse('${e.score.getNumber()}');
                      final total = int.tryParse('${e.total.getNumber()}');
                      return SearchInfoModel(
                        id: id,
                        airDate: e.tip.decode() ?? '',
                        name: e.name.decode() ?? '',
                        nameCn: e.nameCn.decode() ?? '',
                        rank: rank,
                        rating: RatingModel(
                          rank: rank,
                          score: (score ?? 0) / 10,
                          total: total,
                        ),
                        images: ImagesModel(
                          small: cover,
                          common: cover,
                          grid: cover,
                          large: cover,
                          medium: cover,
                        ),
                      );
                    },
                  ).toList();
                  if (list?.isEmpty ?? true) {
                    return const SliverToBoxAdapter(child: CustomEmptyWidget());
                  }
                  return SliverFadeTransition(
                    opacity: _animationController,
                    sliver: ValueListenableBuilder(
                        valueListenable: _layoutOption,
                        builder: (context, layoutOption, child) {
                          switch (layoutOption) {
                            case ScreenLayoutOption.grid:
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    if (index == 1) {
                                      return PageRowWidget(
                                        previousCallback: () =>
                                            _selectPage(state.page - 1),
                                        nextCallback: () =>
                                            _selectPage(state.page + 1),
                                      );
                                    }
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 0.5,
                                        crossAxisSpacing: 6.0,
                                      ),
                                      itemBuilder: (context, index) {
                                        return SearchGridCard(
                                          info: list[index],
                                          disable: true,
                                        );
                                      },
                                      itemCount: list!.length,
                                    );
                                  },
                                  childCount: 2,
                                ),
                              );
                            case ScreenLayoutOption.list:
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    if (index == list.length) {
                                      return PageRowWidget(
                                        previousCallback: () =>
                                            _selectPage(state.page - 1),
                                        nextCallback: () =>
                                            _selectPage(state.page + 1),
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: SearchListCard(
                                          info: list[index], disable: true),
                                    );
                                  },
                                  childCount: list!.length + 1,
                                ),
                              );
                          }
                        }),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
