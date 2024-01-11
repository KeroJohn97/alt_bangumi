import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/models/images_model.dart';
import 'package:alt_bangumi/models/rating_model.dart';
import 'package:alt_bangumi/models/search_model/search_info_model.dart';
import 'package:alt_bangumi/screens/tag/widgets/single_tag_loading_widget.dart';
import 'package:alt_bangumi/screens/tag/widgets/single_tag_page_row_widget.dart';
import 'package:alt_bangumi/widgets/custom_empty_widget.dart';
import 'package:alt_bangumi/widgets/discover/search/search_grid_card.dart';
import 'package:alt_bangumi/widgets/discover/search/search_list_card.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../constants/http_constant.dart';
import '../../providers/single_tag_screen_provider.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/custom_popup_menu_button.dart';

class SingleTagScreen extends ConsumerStatefulWidget {
  final String tag;
  final ScreenSubjectOption subjectOption;
  const SingleTagScreen({
    super.key,
    required this.tag,
    required this.subjectOption,
  });

  static const route = '/single_tag';
  static const tagKey = 'tag_key';
  static const subjectKey = 'subject_key';

  @override
  ConsumerState<SingleTagScreen> createState() => _SingleTagScreenState();
}

class _SingleTagScreenState extends ConsumerState<SingleTagScreen>
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
      final notifier = ref.read(singleTagScreenProvider.notifier);
      notifier.selectSubject(widget.subjectOption);
      _search();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _search() {
    ref.read(singleTagScreenProvider.notifier).search(widget.tag);
  }

  void _viewInBrowser() {
    final state = ref.read(singleTagScreenProvider);
    final url =
        '${HttpConstant.host}/${state.subjectOption.name}/tag/${widget.tag}'
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

  void _selectPage(int page) {
    ref.read(singleTagScreenProvider.notifier).selectPage(page);
    _search();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(singleTagScreenProvider);
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
      title: widget.tag,
      body: CustomScrollView(
        slivers: [
          SliverPinnedHeader(
            child: Container(
              height: 40.0,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPopupMenuButton(
                    tag: state.sortOption.getString(context),
                    iconWidget: const Icon(
                      Icons.filter_list_outlined,
                      size: 16.0,
                    ),
                    menuItem: [
                      ...SortOption.values.map(
                        (e) => PopupMenuItem(
                          child: Text(e.getString(context)),
                          onTap: () {
                            ref
                                .read(singleTagScreenProvider.notifier)
                                .selectSort(e);
                            _search();
                          },
                        ),
                      ),
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
                        ].map(
                          (e) => PopupMenuItem(
                            child: Text(
                              '${e ?? TextConstant.entire.getString(context)}',
                            ),
                            onTap: () {
                              ref
                                  .read(singleTagScreenProvider.notifier)
                                  .selectYear(e);
                              _search();
                            },
                          ),
                        ),
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
                      ].map(
                        (e) => PopupMenuItem(
                          child: Text(
                              '${e ?? TextConstant.entire.getString(context)}'),
                          onTap: () {
                            ref
                                .read(singleTagScreenProvider.notifier)
                                .selectMonth(e);
                            _search();
                          },
                        ),
                      ),
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
                case SingleTagScreenStateEnum.initial:
                  return const SliverToBoxAdapter(
                      child: SingleTagLoadingWidget());
                case SingleTagScreenStateEnum.loading:
                  return const SliverToBoxAdapter(
                      child: SingleTagLoadingWidget());
                case SingleTagScreenStateEnum.failure:
                  return const SliverToBoxAdapter(child: CustomErrorWidget());
                case SingleTagScreenStateEnum.success:
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
                                      return SingleTagPageRowWidget(
                                        previousCallback: () =>
                                            _selectPage(state.page - 1),
                                        nextCallback: () =>
                                            _selectPage(state.page + 1),
                                      );
                                    }
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
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
                                      return SingleTagPageRowWidget(
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
