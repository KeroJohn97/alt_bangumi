import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/constants/static_http_constant.dart';
import 'package:alt_bangumi/helpers/http_helper.dart';
import 'package:alt_bangumi/models/episode_model/episode_model.dart';
import 'package:alt_bangumi/models/home_discovery_model/home_discovery_model.dart';
import 'package:alt_bangumi/models/search_model/search_model.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';

import '../models/calendar_model/calendar_model.dart';
import '../models/relation_model/relation_model.dart';
import '../models/static_anime_model/static_anime_model.dart';
import '../models/static_hentai_model/static_hentai_model.dart';
import '../models/static_manga_model/static_manga_model.dart';
import '../models/static_wenku_model/static_wenku_model.dart';

class GlobalRepository {
  static Future<Map<String, dynamic>> getOTA() async {
    final json = await HttpHelper.get(StaticHttpConstant.otaEndpoint);
    return json;
  }

  static Future<List<CalendarModel>> getCalendar() async {
    final List<dynamic> json = await HttpHelper.get(HttpConstant.apiCalendar());
    return List.of(json.map((e) => CalendarModel.fromMap(e)).toList()).toList();
  }

  static Future<SearchModel> searchKeyword({
    required String keyword,
    required SearchScreenSubjectOption subjectOption,
    required SearchScreenFilterOption filterOption,
    required int start,
  }) async {
    const maxResults = 25;
    const responseGroup = SearchScreenResponseGroup.large;
    final json = await HttpHelper.get(
      HttpConstant.apiSearch(
        '$keyword?type=${subjectOption.value}'
        '&legacy=${filterOption.value}'
        '&responseGroup=${responseGroup.name}'
        '&start=$start'
        '&max_results=$maxResults',
      ),
    );
    return SearchModel.fromMap(json);
  }

  static Future<SubjectModel> getSubject(String subjectId) async {
    final json = await HttpHelper.get(HttpConstant.apiSubject(subjectId));
    return SubjectModel.fromMap(json);
  }

  static Future<EpisodeModel> getEpisode(String subjectId) async {
    final json = await HttpHelper.get(
        '${HttpConstant.apiV0}/episodes?subject_id=$subjectId');
    return EpisodeModel.fromMap(json);
  }

  static Future<List<RelationModel>> getPersons(String subjectId) async {
    final List<dynamic> json = await HttpHelper.get(
        '${HttpConstant.apiV0}/subjects/$subjectId/persons');
    return List.of(json.map((e) => RelationModel.fromMap(e))).toList();
  }

  static Future<List<RelationModel>> getCharacters(String subjectId) async {
    final List<dynamic> json = await HttpHelper.get(
        '${HttpConstant.apiV0}/subjects/$subjectId/characters');
    return List.of(json.map((e) => RelationModel.fromMap(e))).toList();
  }

  static Future<List<RelationModel>> getRelations(String subjectId) async {
    final List<dynamic> json = await HttpHelper.get(
        '${HttpConstant.apiV0}/subjects/$subjectId/subjects');
    return List.of(json.map((e) => RelationModel.fromMap(e))).toList();
  }

  static Future<HomeDiscoveryModel> getHomeDiscovery() async {
    final endpoint = await StaticHttpConstant.cdnDiscoveryHome();
    final json = await HttpHelper.get(endpoint);
    return HomeDiscoveryModel.fromMap(json);
  }

  static Future<StaticAnimeModel> getStaticAnime() async {
    final endpoint = StaticHttpConstant.cdnStaticAnime();
    final json = await HttpHelper.get(endpoint);
    return StaticAnimeModel.fromMap(json);
  }

  static Future<StaticWenkuModel> getStaticWenku() async {
    final endpoint = StaticHttpConstant.cdnStaticWenku();
    final json = await HttpHelper.get(endpoint);
    return StaticWenkuModel.fromMap(json);
  }

  static Future<StaticMangaModel> getStaticManga() async {
    final endpoint = StaticHttpConstant.cdnStaticManga();
    final json = await HttpHelper.get(endpoint);
    return StaticMangaModel.fromMap(json);
  }

  static Future<StaticHentaiModel> getStaticHentai() async {
    final endpoint = StaticHttpConstant.cdnStaticHentai();
    final json = await HttpHelper.get(endpoint);
    return StaticHentaiModel.fromJson(json);
  }

  static Future<String> getAward({required String year}) async {
    final endpoint = StaticHttpConstant.cdnAward(year);
    final json = await HttpHelper.get(endpoint);
    return json['html'] ?? '';
  }
}
