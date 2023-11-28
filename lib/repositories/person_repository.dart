import 'package:alt_bangumi/models/related_subject_model.dart';

import '../constants/http_constant.dart';
import '../helpers/http_helper.dart';
import '../models/character_person_model.dart';
import '../models/person_model/person_model.dart';

class PersonRepository {
  static Future<PersonModel> getPerson(String characterId) async {
    final json =
        await HttpHelper.get('${HttpConstant.apiV0}/persons/$characterId');
    return PersonModel.fromMap(json);
  }

  static Future<List<RelatedSubjectModel>> getPersonSubjects(
      String characterId) async {
    final List<dynamic> json = await HttpHelper.get(
        '${HttpConstant.apiV0}/persons/$characterId/subjects');
    return json.map((e) => RelatedSubjectModel.fromMap(e)).toList();
  }

  static Future<List<CharacterPersonModel>> getPersonCharacters(
      String characterId) async {
    final List<dynamic> json = await HttpHelper.get(
        '${HttpConstant.apiV0}/persons/$characterId/characters');
    return json.map((e) => CharacterPersonModel.fromMap(e)).toList();
  }
}
