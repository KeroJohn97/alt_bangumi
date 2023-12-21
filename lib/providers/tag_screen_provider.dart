// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/models/subject_model/tag_model.dart';
import 'package:alt_bangumi/repositories/bad_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TagScreenStateEnum { initial, loading, success, failure }

class TagScreenState {
  final TagScreenStateEnum stateEnum;
  final List<TagModel>? animeTags;
  final List<TagModel>? bookTags;
  final List<TagModel>? musicTags;
  final List<TagModel>? filmTags;
  final List<TagModel>? gameTags;
  final int page;

  TagScreenState({
    required this.stateEnum,
    required this.animeTags,
    required this.bookTags,
    required this.musicTags,
    required this.filmTags,
    required this.gameTags,
    required this.page,
  });

  TagScreenState copyWith({
    TagScreenStateEnum? stateEnum,
    List<TagModel>? animeTags,
    List<TagModel>? bookTags,
    List<TagModel>? musicTags,
    List<TagModel>? filmTags,
    List<TagModel>? gameTags,
    int? page,
  }) {
    return TagScreenState(
      stateEnum: stateEnum ?? this.stateEnum,
      animeTags: animeTags ?? this.animeTags,
      bookTags: bookTags ?? this.bookTags,
      musicTags: musicTags ?? this.musicTags,
      filmTags: filmTags ?? this.filmTags,
      gameTags: gameTags ?? this.gameTags,
      page: page ?? this.page,
    );
  }
}

class TagScreenNotifier extends StateNotifier<TagScreenState> {
  TagScreenNotifier()
      : super(
          TagScreenState(
            stateEnum: TagScreenStateEnum.initial,
            animeTags: null,
            bookTags: null,
            gameTags: null,
            musicTags: null,
            filmTags: null,
            page: 1,
          ),
        );

  void searchTags({
    required String filter,
    required ScreenSubjectOption subjectOption,
  }) async {
    state = state.copyWith(stateEnum: TagScreenStateEnum.loading);
    final result = await BadRepository.fetchTags(
      subjectOption: subjectOption,
      filter: filter,
      page: 1,
    );
    state = state.copyWith(
      stateEnum: TagScreenStateEnum.success,
      animeTags:
          subjectOption == ScreenSubjectOption.anime ? result : state.animeTags,
      bookTags:
          subjectOption == ScreenSubjectOption.book ? result : state.bookTags,
      musicTags:
          subjectOption == ScreenSubjectOption.music ? result : state.musicTags,
      filmTags:
          subjectOption == ScreenSubjectOption.film ? result : state.filmTags,
      gameTags:
          subjectOption == ScreenSubjectOption.game ? result : state.gameTags,
      page: 1,
    );
  }

  void initTags({
    required ScreenSubjectOption subjectOption,
    String? filter,
  }) async {
    state = state.copyWith(stateEnum: TagScreenStateEnum.loading);
    final result = await BadRepository.fetchTags(
      subjectOption: subjectOption,
      page: state.page,
      filter: filter,
    );
    state = state.copyWith(
      stateEnum: TagScreenStateEnum.success,
      animeTags:
          subjectOption == ScreenSubjectOption.anime ? result : state.animeTags,
      bookTags:
          subjectOption == ScreenSubjectOption.book ? result : state.bookTags,
      musicTags:
          subjectOption == ScreenSubjectOption.music ? result : state.musicTags,
      filmTags:
          subjectOption == ScreenSubjectOption.film ? result : state.filmTags,
      gameTags:
          subjectOption == ScreenSubjectOption.game ? result : state.gameTags,
    );
  }

  void loadTags({
    required ScreenSubjectOption subjectOption,
  }) async {
    final result = await BadRepository.fetchTags(
      subjectOption: subjectOption,
      page: state.page + 1,
      filter: null,
    );
    if (result == null) return;
    state = state.copyWith(
      stateEnum: TagScreenStateEnum.success,
      animeTags: subjectOption == ScreenSubjectOption.anime
          ? (state.animeTags?..addAll(result))
          : state.animeTags,
      bookTags: subjectOption == ScreenSubjectOption.book
          ? (state.bookTags?..addAll(result))
          : state.bookTags,
      musicTags: subjectOption == ScreenSubjectOption.music
          ? (state.musicTags?..addAll(result))
          : state.musicTags,
      filmTags: subjectOption == ScreenSubjectOption.film
          ? (state.filmTags?..addAll(result))
          : state.filmTags,
      gameTags: subjectOption == ScreenSubjectOption.game
          ? (state.gameTags?..addAll(result))
          : state.gameTags,
      page: state.page + 1,
    );
  }
}

final tagScreenProvider =
    AutoDisposeStateNotifierProvider<TagScreenNotifier, TagScreenState>((ref) {
  return TagScreenNotifier();
});
