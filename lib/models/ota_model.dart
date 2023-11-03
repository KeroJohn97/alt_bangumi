import 'dart:convert';

import 'package:equatable/equatable.dart';

class OtaModel extends Equatable {
  final String? online;
  final String? versionMono;
  final String? versionSubject;
  final String? versionOss;
  final String? versionAvatar;
  final String? versionStatic;
  final String? versionRakuen;
  final String? versionAnime;
  final String? versionWenku;
  final String? versionManga;
  final String? versionHentai;
  final String? versionGame;
  final String? versionTinygrail;
  final String? siteAgefans;
  final String? siteXunbo;
  final String? siteRrys;
  final String? siteWk8;
  final String? site77Mh;
  final String? siteComic123;
  final String? siteManhuadb;
  final String? siteMangabz;
  final String? siteManhua1234;
  final String? siteWnacg;
  final String? siteHd;
  final List<int>? hd;
  final List<int>? hdFull;
  final bool? googleAuth;
  final bool? x18;
  final bool? hentai;
  final bool? poweredbyCloud;

  const OtaModel({
    this.online,
    this.versionMono,
    this.versionSubject,
    this.versionOss,
    this.versionAvatar,
    this.versionStatic,
    this.versionRakuen,
    this.versionAnime,
    this.versionWenku,
    this.versionManga,
    this.versionHentai,
    this.versionGame,
    this.versionTinygrail,
    this.siteAgefans,
    this.siteXunbo,
    this.siteRrys,
    this.siteWk8,
    this.site77Mh,
    this.siteComic123,
    this.siteManhuadb,
    this.siteMangabz,
    this.siteManhua1234,
    this.siteWnacg,
    this.siteHd,
    this.hd,
    this.hdFull,
    this.googleAuth,
    this.x18,
    this.hentai,
    this.poweredbyCloud,
  });

  factory OtaModel.fromMap(Map<String, dynamic> data) => OtaModel(
        online: data['online'] as String?,
        versionMono: data['VERSION_MONO'] as String?,
        versionSubject: data['VERSION_SUBJECT'] as String?,
        versionOss: data['VERSION_OSS'] as String?,
        versionAvatar: data['VERSION_AVATAR'] as String?,
        versionStatic: data['VERSION_STATIC'] as String?,
        versionRakuen: data['VERSION_RAKUEN'] as String?,
        versionAnime: data['VERSION_ANIME'] as String?,
        versionWenku: data['VERSION_WENKU'] as String?,
        versionManga: data['VERSION_MANGA'] as String?,
        versionHentai: data['VERSION_HENTAI'] as String?,
        versionGame: data['VERSION_GAME'] as String?,
        versionTinygrail: data['VERSION_TINYGRAIL'] as String?,
        siteAgefans: data['SITE_AGEFANS'] as String?,
        siteXunbo: data['SITE_XUNBO'] as String?,
        siteRrys: data['SITE_RRYS'] as String?,
        siteWk8: data['SITE_WK8'] as String?,
        site77Mh: data['SITE_77MH'] as String?,
        siteComic123: data['SITE_COMIC123'] as String?,
        siteManhuadb: data['SITE_MANHUADB'] as String?,
        siteMangabz: data['SITE_MANGABZ'] as String?,
        siteManhua1234: data['SITE_MANHUA1234'] as String?,
        siteWnacg: data['SITE_WNACG'] as String?,
        siteHd: data['SITE_HD'] as String?,
        hd: data['HD'] as List<int>?,
        hdFull: data['HD_FULL'] as List<int>?,
        googleAuth: data['GOOGLE_AUTH'] as bool?,
        x18: data['X18'] as bool?,
        hentai: data['HENTAI'] as bool?,
        poweredbyCloud: data['POWEREDBY_CLOUD'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'online': online,
        'VERSION_MONO': versionMono,
        'VERSION_SUBJECT': versionSubject,
        'VERSION_OSS': versionOss,
        'VERSION_AVATAR': versionAvatar,
        'VERSION_STATIC': versionStatic,
        'VERSION_RAKUEN': versionRakuen,
        'VERSION_ANIME': versionAnime,
        'VERSION_WENKU': versionWenku,
        'VERSION_MANGA': versionManga,
        'VERSION_HENTAI': versionHentai,
        'VERSION_GAME': versionGame,
        'VERSION_TINYGRAIL': versionTinygrail,
        'SITE_AGEFANS': siteAgefans,
        'SITE_XUNBO': siteXunbo,
        'SITE_RRYS': siteRrys,
        'SITE_WK8': siteWk8,
        'SITE_77MH': site77Mh,
        'SITE_COMIC123': siteComic123,
        'SITE_MANHUADB': siteManhuadb,
        'SITE_MANGABZ': siteMangabz,
        'SITE_MANHUA1234': siteManhua1234,
        'SITE_WNACG': siteWnacg,
        'SITE_HD': siteHd,
        'HD': hd,
        'HD_FULL': hdFull,
        'GOOGLE_AUTH': googleAuth,
        'X18': x18,
        'HENTAI': hentai,
        'POWEREDBY_CLOUD': poweredbyCloud,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OtaModel].
  factory OtaModel.fromJson(String data) {
    return OtaModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OtaModel] to a JSON string.
  String toJson() => json.encode(toMap());

  OtaModel copyWith({
    String? online,
    String? versionMono,
    String? versionSubject,
    String? versionOss,
    String? versionAvatar,
    String? versionStatic,
    String? versionRakuen,
    String? versionAnime,
    String? versionWenku,
    String? versionManga,
    String? versionHentai,
    String? versionGame,
    String? versionTinygrail,
    String? siteAgefans,
    String? siteXunbo,
    String? siteRrys,
    String? siteWk8,
    String? site77Mh,
    String? siteComic123,
    String? siteManhuadb,
    String? siteMangabz,
    String? siteManhua1234,
    String? siteWnacg,
    String? siteHd,
    List<int>? hd,
    List<int>? hdFull,
    bool? googleAuth,
    bool? x18,
    bool? hentai,
    bool? poweredbyCloud,
  }) {
    return OtaModel(
      online: online ?? this.online,
      versionMono: versionMono ?? this.versionMono,
      versionSubject: versionSubject ?? this.versionSubject,
      versionOss: versionOss ?? this.versionOss,
      versionAvatar: versionAvatar ?? this.versionAvatar,
      versionStatic: versionStatic ?? this.versionStatic,
      versionRakuen: versionRakuen ?? this.versionRakuen,
      versionAnime: versionAnime ?? this.versionAnime,
      versionWenku: versionWenku ?? this.versionWenku,
      versionManga: versionManga ?? this.versionManga,
      versionHentai: versionHentai ?? this.versionHentai,
      versionGame: versionGame ?? this.versionGame,
      versionTinygrail: versionTinygrail ?? this.versionTinygrail,
      siteAgefans: siteAgefans ?? this.siteAgefans,
      siteXunbo: siteXunbo ?? this.siteXunbo,
      siteRrys: siteRrys ?? this.siteRrys,
      siteWk8: siteWk8 ?? this.siteWk8,
      site77Mh: site77Mh ?? this.site77Mh,
      siteComic123: siteComic123 ?? this.siteComic123,
      siteManhuadb: siteManhuadb ?? this.siteManhuadb,
      siteMangabz: siteMangabz ?? this.siteMangabz,
      siteManhua1234: siteManhua1234 ?? this.siteManhua1234,
      siteWnacg: siteWnacg ?? this.siteWnacg,
      siteHd: siteHd ?? this.siteHd,
      hd: hd ?? this.hd,
      hdFull: hdFull ?? this.hdFull,
      googleAuth: googleAuth ?? this.googleAuth,
      x18: x18 ?? this.x18,
      hentai: hentai ?? this.hentai,
      poweredbyCloud: poweredbyCloud ?? this.poweredbyCloud,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      online,
      versionMono,
      versionSubject,
      versionOss,
      versionAvatar,
      versionStatic,
      versionRakuen,
      versionAnime,
      versionWenku,
      versionManga,
      versionHentai,
      versionGame,
      versionTinygrail,
      siteAgefans,
      siteXunbo,
      siteRrys,
      siteWk8,
      site77Mh,
      siteComic123,
      siteManhuadb,
      siteMangabz,
      siteManhua1234,
      siteWnacg,
      siteHd,
      hd,
      hdFull,
      googleAuth,
      x18,
      hentai,
      poweredbyCloud,
    ];
  }
}
