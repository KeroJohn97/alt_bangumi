import 'package:flutter_bangumi/constants/static_http_constant.dart';
import 'package:flutter_bangumi/helpers/http_helper.dart';
import 'package:flutter_bangumi/models/home_discovery_model/home_discovery_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/static_anime_model/static_anime_model.dart';
import '../models/static_hentai_model/static_hentai_model.dart';
import '../models/static_manga_model/static_manga_model.dart';
import '../models/static_wenku_model/static_wenku_model.dart';

final globalRepositoryProvider = Provider<GlobalRepository>((ref) {
  return GlobalRepository();
});

class GlobalRepository {
  static Future<Map<String, dynamic>> getOTA() async {
    final json = await HttpHelper.get(StaticHttpConstant.otaEndpoint);
    return json;
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
