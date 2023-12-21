// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alt_bangumi/models/related_subject_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/character_person_model.dart';
import '../models/person_model/person_model.dart';
import '../repositories/person_repository.dart';

enum PersonDetailScreenStateEnum { initial, loading, success, failure }

class PersonDetailScreenState {
  final PersonDetailScreenStateEnum stateEnum;
  final PersonModel? person;
  final List<RelatedSubjectModel>? personSubjects;
  final List<CharacterPersonModel>? personCharacters;

  PersonDetailScreenState({
    required this.stateEnum,
    required this.person,
    required this.personSubjects,
    required this.personCharacters,
  });

  PersonDetailScreenState copyWith({
    PersonDetailScreenStateEnum? stateEnum,
    PersonModel? person,
    List<RelatedSubjectModel>? personSubjects,
    List<CharacterPersonModel>? personPersons,
  }) {
    return PersonDetailScreenState(
      stateEnum: stateEnum ?? this.stateEnum,
      person: person ?? this.person,
      personSubjects: personSubjects ?? this.personSubjects,
      personCharacters: personPersons ?? personCharacters,
    );
  }
}

class PersonDetailScreenNotifier
    extends StateNotifier<PersonDetailScreenState> {
  PersonDetailScreenNotifier()
      : super(
          PersonDetailScreenState(
            stateEnum: PersonDetailScreenStateEnum.initial,
            person: null,
            personSubjects: null,
            personCharacters: null,
          ),
        );

  void loadPerson(PersonModel person) async {
    state = state.copyWith(
        person: person, stateEnum: PersonDetailScreenStateEnum.loading);
    final personSubjects =
        await PersonRepository.getPersonSubjects('${person.id}');
    final personPersons =
        await PersonRepository.getPersonCharacters('${person.id}');
    state = state.copyWith(
      stateEnum: PersonDetailScreenStateEnum.success,
      personSubjects: personSubjects,
      personPersons: personPersons,
    );
  }
}
