// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/models/search_model/search_model.dart';
import 'package:alt_bangumi/repositories/global_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SearchScreenStateEnum { initial, possible, loading, success, failure }

class SearchScreenState {
  final SearchScreenStateEnum stateEnum;
  final SearchScreenSubjectOption subjectOption;
  final SearchScreenFilterOption filterOption;
  final SearchModel? searchResult;
  final List<String>? possibleMatch;

  SearchScreenState({
    required this.stateEnum,
    required this.subjectOption,
    required this.filterOption,
    required this.searchResult,
    required this.possibleMatch,
  });

  SearchScreenState copyWith({
    SearchScreenStateEnum? stateEnum,
    SearchScreenSubjectOption? subjectOption,
    SearchScreenFilterOption? filterOption,
    List<String>? possibleMatch,
    required SearchModel? searchResult,
  }) {
    return SearchScreenState(
      stateEnum: stateEnum ?? this.stateEnum,
      subjectOption: subjectOption ?? this.subjectOption,
      filterOption: filterOption ?? this.filterOption,
      possibleMatch: possibleMatch,
      searchResult: searchResult,
    );
  }
}

class SearchScreenNotifier extends StateNotifier<SearchScreenState> {
  SearchScreenNotifier()
      : super(
          SearchScreenState(
            stateEnum: SearchScreenStateEnum.initial,
            subjectOption: SearchScreenSubjectOption.values.first,
            filterOption: SearchScreenFilterOption.values.first,
            possibleMatch: null,
            searchResult: null,
          ),
        );

  void clear() {
    state = state.copyWith(
      searchResult: null,
      stateEnum: SearchScreenStateEnum.initial,
    );
  }

  void selectCategory(SearchScreenSubjectOption subjectOption) {
    state = state.copyWith(
      subjectOption: subjectOption,
      searchResult: state.searchResult,
    );
  }

  void selectFilter(SearchScreenFilterOption filterOption) {
    state = state.copyWith(
      filterOption: filterOption,
      searchResult: state.searchResult,
    );
  }

  void searchStorage({
    required SearchModel searchResult,
  }) {
    state = state.copyWith(
      searchResult: searchResult,
      stateEnum: SearchScreenStateEnum.success,
    );
  }

  Future<SearchModel?> searchKeyword(String keyword, {int start = 0}) async {
    if (keyword.isEmpty) return null;
    state = state.copyWith(
      searchResult: null,
      stateEnum: SearchScreenStateEnum.loading,
    );
    try {
      final result = await GlobalRepository.searchKeyword(
        keyword: keyword,
        subjectOption: state.subjectOption,
        filterOption: state.filterOption,
        start: start,
      );
      state = state.copyWith(
        searchResult: result,
        stateEnum: SearchScreenStateEnum.success,
      );
      return result;
    } catch (e) {
      state = state.copyWith(
        searchResult: state.searchResult,
        stateEnum: SearchScreenStateEnum.failure,
      );
    }
    return null;
  }

  void scrollMore(String keyword) async {
    final current = state.searchResult?.searchInfoList?.length ?? 0;
    try {
      final result = await GlobalRepository.searchKeyword(
        keyword: keyword,
        subjectOption: state.subjectOption,
        filterOption: state.filterOption,
        start: current,
      );
      if (result.searchInfoList == null) return;
      final combinedResult = state.searchResult?.searchInfoList
        ?..addAll(result.searchInfoList!);
      state = state.copyWith(
        searchResult:
            state.searchResult?.copyWith(searchInfoList: combinedResult),
      );
    } finally {}
  }

  void possibleMatch(List<String> possibleMatch) {
    state = state.copyWith(
      searchResult: state.searchResult,
      possibleMatch: possibleMatch,
      stateEnum: SearchScreenStateEnum.possible,
    );
  }
}

final searchScreenProvider =
    AutoDisposeStateNotifierProvider<SearchScreenNotifier, SearchScreenState>(
        (ref) {
  return SearchScreenNotifier();
});
