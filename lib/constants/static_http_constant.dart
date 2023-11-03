import 'package:flutter_bangumi/constants/http_constant.dart';
import 'package:flutter_bangumi/repositories/global_repository.dart';

class StaticHttpConstant {
  static String hostStatic =
      '${HttpConstant.hostCDN}/gh/czy0729/Bangumi-Static';

  static String otaEndpoint =
      'https://gitee.com/a296377710/bangumi/raw/master/data.json?t=${DateTime.now().millisecondsSinceEpoch}';

  static Future<int> getVersion(String key, dynamic version) async {
    final ota = await getOTA();
    return int.parse(ota[key]) > int.parse(version)
        ? int.parse(ota[key])
        : version;
  }

  static Future<Map<String, dynamic>> getOTA() async {
    return await GlobalRepository.getOTA();
  }

  /// 发现首页
  static Future<String> cdnDiscoveryHome() async {
    final v = getVersion('VERSION_STATIC', versionStatic);
    return '$hostStatic@$v/data/discovery/home.json';
  }

  /// 找番剧数据
  static String cdnStaticAnime() {
    final v = getVersion('VERSION_ANIME', versionAnime);
    return '$hostStatic@$v/data/agefans/anime.min.json';
  }

  /// 找文库数据
  static String cdnStaticWenku() {
    final v = getVersion('VERSION_WENKU', versionWenku);
    return '$hostStatic@$v/data/wenku8/wenku.min.json';
  }

  /// 找漫画数据
  static String cdnStaticManga() {
    final v = getVersion('VERSION_MANGA', versionManga);
    return '$hostStatic@$v/data/manhuadb/manga.min.json';
  }

  /// 找 Hentai 数据
  static String cdnStaticHentai() {
    final v = getVersion('VERSION_HENTAI', versionHentai);
    return '$hostStatic@$v/data/h/hentai.min.json';
  }

  /// 年鉴
  static String cdnAward(String year) {
    final v = getVersion('VERSION_STATIC', versionStatic);
    return '$hostStatic@$v/data/award/$year.expo.json';
  }

  // https://github.com/czy0729/Bangumi-Static
  static String versionStatic = '20220306';

  // https://github.com/czy0729/Bangumi-Rakuen
  static String versionRakuen = '20220223';

  /// https://github.com/czy0729/Bangumi-OSS/tree/master/data/avatar/m
  static String versionAvatar = '20220102';

  /// https://github.com/czy0729/Bangumi-OSS/tree/master/data/subject/c
  static String versionOSS = '20220103';

  /// https://github.com/czy0729/Bangumi-Subject
  static String versionSubject = '20220102';

  /// https://github.com/czy0729/Bangumi-Mono
  static String versionMono = '20201216';

  /// https://github.com/czy0729/Bangumi-Static/tree/master/data/agefans
  static String versionAnime = '20220223';

  /// https://github.com/czy0729/Bangumi-Static/tree/master/data/wenku8
  static String versionWenku = '20210627';

  /// https://github.com/czy0729/Bangumi-Static/tree/master/data/manhuadb
  static String versionManga = '20210628';

  /// https://github.com/czy0729/Bangumi-Static/tree/master/data/h
  static String versionHentai = '20210630';

  /// https://github.com/czy0729/Bangumi-Static/tree/master/data/tinygrail
  static String versionTinyGrail = '20210720';

  /// https://github.com/czy0729/Bangumi-Game
  static String versionGame = '20220327';
}
