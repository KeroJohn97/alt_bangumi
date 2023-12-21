// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alt_bangumi/models/character_model/character_model.dart';
import 'package:alt_bangumi/models/character_person_model.dart';
import 'package:alt_bangumi/models/related_subject_model.dart';
import 'package:alt_bangumi/repositories/character_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CharacterDetailScreenStateEnum { initial, loading, success, failure }

class CharacterDetailScreenState {
  final CharacterDetailScreenStateEnum stateEnum;
  final CharacterModel? character;
  final List<RelatedSubjectModel>? characterSubjects;
  final List<CharacterPersonModel>? characterPersons;

  CharacterDetailScreenState({
    required this.stateEnum,
    required this.character,
    required this.characterSubjects,
    required this.characterPersons,
  });

  CharacterDetailScreenState copyWith({
    CharacterDetailScreenStateEnum? stateEnum,
    CharacterModel? character,
    List<RelatedSubjectModel>? characterSubjects,
    List<CharacterPersonModel>? characterPersons,
  }) {
    return CharacterDetailScreenState(
      stateEnum: stateEnum ?? this.stateEnum,
      character: character ?? this.character,
      characterSubjects: characterSubjects ?? this.characterSubjects,
      characterPersons: characterPersons ?? this.characterPersons,
    );
  }
}

class CharacterDetailScreenNotifier
    extends StateNotifier<CharacterDetailScreenState> {
  CharacterDetailScreenNotifier()
      : super(
          CharacterDetailScreenState(
            stateEnum: CharacterDetailScreenStateEnum.initial,
            character: null,
            characterSubjects: null,
            characterPersons: null,
          ),
        );

  Future<void> loadCharacter(CharacterModel character) async {
    state = state.copyWith(
        character: character,
        stateEnum: CharacterDetailScreenStateEnum.loading);
    final characterSubjects =
        await CharacterRepository.getCharacterSubjects('${character.id}');
    final characterPersons =
        await CharacterRepository.getCharacterPersons('${character.id}');
    state = state.copyWith(
      stateEnum: CharacterDetailScreenStateEnum.success,
      characterSubjects: characterSubjects,
      characterPersons: characterPersons,
    );
  }
}
