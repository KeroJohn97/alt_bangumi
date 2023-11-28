import 'package:alt_bangumi/models/related_subject_model.dart';

import '../constants/http_constant.dart';
import '../helpers/http_helper.dart';
import '../models/character_model/character_model.dart';
import '../models/character_person_model.dart';

class CharacterRepository {
  static Future<CharacterModel> getCharacter(String characterId) async {
    final json =
        await HttpHelper.get('${HttpConstant.apiV0}/characters/$characterId');
    return CharacterModel.fromMap(json);
  }

  static Future<List<RelatedSubjectModel>> getCharacterSubjects(
      String characterId) async {
    final List<dynamic> json = await HttpHelper.get(
        '${HttpConstant.apiV0}/characters/$characterId/subjects');
    return json.map((e) => RelatedSubjectModel.fromMap(e)).toList();
  }

  static Future<List<CharacterPersonModel>> getCharacterPersons(
      String characterId) async {
    final List<dynamic> json = await HttpHelper.get(
        '${HttpConstant.apiV0}/characters/$characterId/persons');
    return json.map((e) => CharacterPersonModel.fromMap(e)).toList();
  }
}
