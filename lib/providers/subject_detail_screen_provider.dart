// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alt_bangumi/models/relation_model/relation_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alt_bangumi/models/subject_model/subject_model.dart';

import '../repositories/global_repository.dart';

enum SubjectDetailScreenStateEnum { initial, loading, success, failure }

class SubjectDetailScreenState {
  final SubjectDetailScreenStateEnum stateEnum;
  final SubjectModel? subject;
  final List<RelationModel>? characters;
  final List<RelationModel>? relations;
  final List<RelationModel>? persons;

  SubjectDetailScreenState({
    required this.stateEnum,
    required this.subject,
    required this.characters,
    required this.relations,
    required this.persons,
  });

  SubjectDetailScreenState copyWith({
    SubjectDetailScreenStateEnum? stateEnum,
    SubjectModel? subject,
    List<RelationModel>? characters,
    List<RelationModel>? relations,
    List<RelationModel>? persons,
  }) {
    return SubjectDetailScreenState(
      stateEnum: stateEnum ?? this.stateEnum,
      subject: subject ?? this.subject,
      characters: characters ?? this.characters,
      relations: relations ?? this.relations,
      persons: persons ?? this.persons,
    );
  }
}

class SubjectDetailScreenNotifier
    extends StateNotifier<SubjectDetailScreenState> {
  SubjectDetailScreenNotifier()
      : super(
          SubjectDetailScreenState(
            stateEnum: SubjectDetailScreenStateEnum.initial,
            subject: null,
            characters: null,
            relations: null,
            persons: null,
          ),
        );

  void loadSubject(String subjectId) async {
    state = state.copyWith(stateEnum: SubjectDetailScreenStateEnum.loading);
    final result = await GlobalRepository.getSubject(subjectId);
    final characters = await GlobalRepository.getCharacters(subjectId);
    final relations = await GlobalRepository.getRelations(subjectId);
    final persons = await GlobalRepository.getPersons(subjectId);
    state = state.copyWith(
      stateEnum: SubjectDetailScreenStateEnum.success,
      subject: result,
      characters: characters,
      relations: relations,
      persons: persons,
    );
  }
}

final subjectDetailScreenProvider = AutoDisposeStateNotifierProvider<
    SubjectDetailScreenNotifier, SubjectDetailScreenState>((ref) {
  return SubjectDetailScreenNotifier();
});
