import 'dart:async';
import 'dart:convert';

import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/debouncer_helper.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/helpers/storage_helper.dart';
import 'package:alt_bangumi/helpers/substring_helper.dart';
import 'package:alt_bangumi/models/search_model/search_model.dart';
import 'package:alt_bangumi/providers/search_screen_provider.dart';
import 'package:alt_bangumi/widgets/discover/search/search_list_card.dart';
import 'package:alt_bangumi/widgets/custom_empty_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/discover/search/possible_match_list.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static const route = '/search';
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final FocusNode _searchFocusNode;
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _searchController = TextEditingController()..addListener(_searchListener);
    _scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await _getStorageSubjectOption();
      if (result != null) {
        ref.read(searchScreenProvider.notifier).selectCategory(result);
      }
    });
    _getSearchHistory();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_searchListener)
      ..dispose();
    super.dispose();
  }

  Future<void> _getSearchHistory() async {
    final result = await StorageHelper.read(StorageHelperOption.searchHistory);
    if (result == null) return;
    final List<dynamic> searchHistory = jsonDecode(result);
    StorageHelper.searchHistoryStream.add(searchHistory);
  }

  void _searchListener() async {
    // _search();
    if (_searchController.text.trim().isEmpty) {
      ref.read(searchScreenProvider.notifier).clear();
      await _getSearchHistory();
    }
  }

  void _scrollListener() {
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    if (_scrollController.offset >= maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ref
          .read(searchScreenProvider.notifier)
          .scrollMore(_searchController.text.trim());
    }
  }

  void _search({bool onSubmitted = false}) async {
    globalDebouncerHelper.run(() async {
      final keyword = _searchController.text.trim();
      if (keyword.isEmpty) return;
      final notifier = ref.read(searchScreenProvider.notifier);
      if (onSubmitted) {
        _saveStorageHistory(keyword);
        final apiResult = await notifier.searchKeyword(keyword);
        if (apiResult == null) return;
        _saveStorageResult(searchModel: apiResult, keyword: keyword);
      } else {
        final searchResult = await _getStorageResult(keyword);
        if (searchResult != null) {
          notifier.searchStorage(searchResult: searchResult);
        } else {
          final List<String> possibleList = [];
          switch (ref.read(searchScreenProvider).subjectOption) {
            case SearchScreenSubjectOption.anime:
              possibleList
                  .addAll(await SubstringHelper.instance().getAnimeList());
              break;
            case SearchScreenSubjectOption.book:
              possibleList
                  .addAll(await SubstringHelper.instance().getBookList());
              break;
            case SearchScreenSubjectOption.game:
              possibleList
                  .addAll(await SubstringHelper.instance().getGameList());
              break;
            case SearchScreenSubjectOption.user:
              break;
            default:
              possibleList
                  .addAll(await SubstringHelper.instance().getAnimeList());
              break;
          }
          final possibleMatch = possibleList
              .where((element) =>
                  element.toLowerCase().contains(keyword.toLowerCase()))
              .toList();
          notifier.possibleMatch(possibleMatch);
          // TODO show possible matched results
        }
      }
    });
  }

  Future<SearchScreenSubjectOption?> _getStorageSubjectOption() async {
    final result = await StorageHelper.read(StorageHelperOption.subjectOption);
    if (result == null) return null;
    final subjectOption = jsonDecode(result);
    return SearchScreenSubjectOption.values
        .firstWhereOrNull((element) => element.toJson() == subjectOption);
  }

  void _saveStorageSubjectOption(SearchScreenSubjectOption subjectOption) {
    StorageHelper.write(
      option: StorageHelperOption.subjectOption,
      value: jsonEncode(subjectOption.toJson()),
    );
  }

  void _saveStorageHistory(String keyword) async {
    final result = await StorageHelper.read(StorageHelperOption.searchHistory);
    List<dynamic> searchHistory = [];
    if (result != null) {
      searchHistory = jsonDecode(result);
      searchHistory.remove(keyword);
    }
    searchHistory.add(keyword);
    StorageHelper.searchHistoryStream.add(searchHistory);
    StorageHelper.write(
      option: StorageHelperOption.searchHistory,
      value: jsonEncode(searchHistory),
    );
  }

  // TODO search screen: save with category option
  void _saveStorageResult({
    required SearchModel searchModel,
    required String keyword,
  }) async {
    final keywordSearchModel = searchModel.copyWith(keyword: keyword);
    final result = await StorageHelper.read(StorageHelperOption.searchResult);
    final List<dynamic> list = result == null ? [] : jsonDecode(result);
    list
      ..remove(keywordSearchModel.toMap())
      ..add(keywordSearchModel.toMap());
    StorageHelper.write(
      option: StorageHelperOption.searchResult,
      value: jsonEncode(list),
    );
  }

  // TODO search screen: save with category option
  Future<SearchModel?> _getStorageResult(String keyword) async {
    final result = await StorageHelper.read(StorageHelperOption.searchResult);
    final List<dynamic> list = result == null ? [] : jsonDecode(result);
    final storageResult = list.map((e) => SearchModel.fromMap(e)).toList();
    return storageResult.firstWhereOrNull((e) => e.keyword == keyword);
  }

  void _removeSearchHistory(int index) async {
    final result = await StorageHelper.read(StorageHelperOption.searchHistory);
    if (result == null) return;
    final List<dynamic> searchHistory = jsonDecode(result);
    searchHistory.removeAt(index);
    StorageHelper.searchHistoryStream
        .add(List.of(searchHistory.map((e) => '$e').toList()));
    StorageHelper.write(
      option: StorageHelperOption.searchHistory,
      value: jsonEncode(searchHistory),
    );
  }

  void _clearSearchHistory() async {
    StorageHelper.searchHistoryStream.add([]);
    await StorageHelper.delete(StorageHelperOption.searchHistory);
  }

  void _openInNew(int index) {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchScreenProvider);
    final notifier = ref.read(searchScreenProvider.notifier);
    return ScaffoldCustomed(
      leading: const BackButton(color: Colors.black),
      showDrawer: false,
      title: TextConstant.search.getString(context),
      trailing: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 0,
                child: Text(TextConstant.viewInBrowser.getString(context)),
                onTap: () {
                  // TODO launchUrl
                },
              ),
            ];
          },
          child: const Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: const SizedBox.shrink(),
                pinned: true,
                elevation: 0.0,
                surfaceTintColor: Colors.white,
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36.0,
                      width: 80.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.pink[50],
                        border: Border.all(
                            color: Colors.pinkAccent[100]!, width: 0.5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          alignment: Alignment.center,
                          icon: const SizedBox.shrink(),
                          value: state.subjectOption,
                          items: SearchScreenSubjectOption.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      e.name
                                          .capitalizeFirst()
                                          .getString(context),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            notifier.selectCategory(value);
                            _saveStorageSubjectOption(value);
                            _search(onSubmitted: true);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36.0,
                      width: 25.w,
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              bottom: 12.0, left: 8.0, right: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.2),
                              width: 0.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.2),
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide:
                                BorderSide(color: ColorConstant.themeColor),
                          ),
                          focusColor: ColorConstant.themeColor,
                          hoverColor: ColorConstant.themeColor,
                          hintText:
                              TextConstant.enterKeywords.getString(context),
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) => _search(),
                        onSubmitted: (value) => _search(onSubmitted: true),
                      ),
                    ),
                    Container(
                      height: 36.0,
                      width: 80.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border:
                            Border.all(color: Colors.grey[400]!, width: 0.5),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          alignment: Alignment.center,
                          icon: const SizedBox.shrink(),
                          value: state.filterOption,
                          items: SearchScreenFilterOption.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      e.name
                                          .capitalizeFirst()
                                          .getString(context),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            notifier.selectFilter(value);
                            _search(onSubmitted: true);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      height: 36.0,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey[400]!, width: 0.5),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      width: 70.0,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () => _search(onSubmitted: true),
                        child: Text(
                          TextConstant.enquiry.getString(context),
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              StreamBuilder<List<dynamic>>(
                  stream: StorageHelper.searchHistoryStream.stream
                      .asBroadcastStream(),
                  builder: (context, snapshot) {
                    switch (state.stateEnum) {
                      case SearchScreenStateEnum.initial:
                        return SliverToBoxAdapter(
                          child: Builder(
                            builder: (context) {
                              // TODO remove this
                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Text(
                                  TextConstant.noHistory.getString(context),
                                  textAlign: TextAlign.center,
                                );
                              }
                              final List<dynamic> searchHistory =
                                  snapshot.data!;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (index < searchHistory.length) {
                                    return ListTile(
                                      onTap: () {
                                        _searchController.text =
                                            searchHistory[index];
                                        _searchFocusNode.unfocus();
                                        _search();
                                      },
                                      title: Text(
                                        searchHistory[index],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.close_outlined),
                                        onPressed: () =>
                                            _removeSearchHistory(index),
                                      ),
                                    );
                                  }
                                  return ListTile(
                                    title: Text(
                                      TextConstant.clearHistory
                                          .getString(context),
                                    ),
                                    onTap: _clearSearchHistory,
                                  );
                                },
                                itemCount: searchHistory.length + 1,
                              );
                            },
                          ),
                        );
                      case SearchScreenStateEnum.possible:
                        if (state.possibleMatch?.isNotEmpty ?? false) {
                          return PossibleMatchList(
                            keyword: _searchController.text.trim(),
                            possibleMatch: state.possibleMatch!,
                            callback: (int index) {
                              _searchController.text =
                                  state.possibleMatch![index];
                              _searchFocusNode.unfocus();
                              _search(onSubmitted: true);
                            },
                            openInNew: _openInNew,
                          );
                        }
                        break;
                      case SearchScreenStateEnum.loading:
                        return SliverToBoxAdapter(
                          child: Container(
                            height: 50.h,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator.adaptive(),
                          ),
                        );
                      case SearchScreenStateEnum.success:
                        if (state.searchResult == null) {
                          return const SliverToBoxAdapter(
                              child: Text('Result is null'));
                        }
                        if (state.searchResult!.searchInfoList?.isEmpty ??
                            true) {
                          return const SliverToBoxAdapter(
                            child: CustomEmptyWidget(),
                          );
                        }
                        return SliverToBoxAdapter(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                state.searchResult!.searchInfoList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return SearchListCard(
                                info:
                                    state.searchResult!.searchInfoList![index],
                              );
                            },
                          ),
                        );
                      case SearchScreenStateEnum.failure:
                        // TODO: Handle this case.
                        break;
                    }
                    return const SliverToBoxAdapter();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
