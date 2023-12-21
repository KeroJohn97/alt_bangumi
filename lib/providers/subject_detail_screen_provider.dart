// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alt_bangumi/helpers/storage_helper.dart';
import 'package:alt_bangumi/models/episode_model/episode_model.dart';
import 'package:alt_bangumi/models/relation_model/relation_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alt_bangumi/models/subject_model/subject_model.dart';

import '../repositories/global_repository.dart';

enum SubjectDetailScreenStateEnum { initial, loading, success, failure }

class SubjectDetailScreenState {
  final SubjectDetailScreenStateEnum stateEnum;
  final SubjectModel? subject;
  final EpisodeModel? episode;
  final List<RelationModel>? characters;
  final List<RelationModel>? relations;
  final List<RelationModel>? persons;

  SubjectDetailScreenState({
    required this.stateEnum,
    required this.subject,
    required this.episode,
    required this.characters,
    required this.relations,
    required this.persons,
  });

  SubjectDetailScreenState copyWith({
    SubjectDetailScreenStateEnum? stateEnum,
    SubjectModel? subject,
    EpisodeModel? episode,
    List<RelationModel>? characters,
    List<RelationModel>? relations,
    List<RelationModel>? persons,
  }) {
    return SubjectDetailScreenState(
      stateEnum: stateEnum ?? this.stateEnum,
      subject: subject ?? this.subject,
      episode: episode ?? this.episode,
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
            episode: null,
            characters: null,
            relations: null,
            persons: null,
          ),
        );

  void loadSubject(String subjectId, {isRefresh = false}) async {
    state = state.copyWith(
      stateEnum: SubjectDetailScreenStateEnum.loading,
      subject: null,
    );

    late SubjectModel subject;
    late EpisodeModel episode;
    late List<RelationModel> characters;
    late List<RelationModel> relations;
    late List<RelationModel> persons;

    final storage =
        await StorageHelper.read(StorageHelperOption.subjectDetailList);
    final Map<String, dynamic> map = jsonDecode(storage ?? '{}');
    Map<String, dynamic>? subjectMap = map[subjectId];
    if (subjectMap != null && !isRefresh) {
      subject = SubjectModel.fromJson(subjectMap['subject']);
      episode = EpisodeModel.fromJson(subjectMap['episode']);
      characters = (subjectMap['characters'] as List<dynamic>)
          .skipWhile((value) => value == null)
          .map((e) => RelationModel.fromMap(e))
          .toList();
      relations = (subjectMap['relations'] as List<dynamic>)
          .skipWhile((value) => value == null)
          .map((e) => RelationModel.fromMap(e))
          .toList();
      persons = (subjectMap['persons'] as List<dynamic>)
          .skipWhile((value) => value == null)
          .map((e) => RelationModel.fromMap(e))
          .toList();
    } else {
      subject = await GlobalRepository.getSubject(subjectId);
      episode =
          await GlobalRepository.getEpisode(subjectId: subjectId, offset: 0);
      characters = await GlobalRepository.getCharacters(subjectId);
      relations = await GlobalRepository.getRelations(subjectId);
      persons = await GlobalRepository.getPersons(subjectId);
      subjectMap?.addAll({
        'subject': subject.toMap(),
        'episode': episode.toMap(),
        'characters': characters.map((e) => e.toMap()).toList(),
        'relations': relations.map((e) => e.toMap()).toList(),
        'persons': persons.map((e) => e.toMap()).toList(),
      });
      subjectMap ??= {
        subjectId: {
          'subject': subject.toJson(),
          'episode': episode.toJson(),
          'characters': characters.map((e) => e.toMap()).toList(),
          'relations': relations.map((e) => e.toMap()).toList(),
          'persons': persons.map((e) => e.toMap()).toList(),
        },
      };
      StorageHelper.write(
        option: StorageHelperOption.subjectDetailList,
        value: jsonEncode(subjectMap),
      );
    }

    state = state.copyWith(
      stateEnum: SubjectDetailScreenStateEnum.success,
      subject: subject,
      episode: episode,
      characters: characters,
      relations: relations,
      persons: persons,
    );
  }

  Future<void> loadEpisodes() async {
    if (state.episode?.data == null) return;
    if (state.episode!.data!.length % 100 != 0) return;
    final temp = state.episode!;
    final count = state.episode!.total! ~/ 100 + 1;
    for (var i = 2; i <= count; i++) {
      EpisodeModel episodes = await GlobalRepository.getEpisode(
          subjectId: '${state.subject?.id}', offset: (i - 1) * 100);
      temp.data?.addAll(episodes.data ?? []);
    }
    state = state.copyWith(episode: temp);
  }

  void sortEpisodes() {
    state = state.copyWith(
      episode: state.episode?.copyWith(
        data: state.episode?.data?.reversed.toList(),
      ),
    );
  }
}
