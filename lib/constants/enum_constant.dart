import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:flutter/material.dart';

enum HomeIndexEnum {
  discover,
  timeCapsules,
  favourite,
  superUnfolded,
  timeMachine,
}

extension HomeIndexEnumExtension on HomeIndexEnum {
  String display(BuildContext context) {
    switch (this) {
      case HomeIndexEnum.discover:
        return context.t.discover;
      case HomeIndexEnum.timeCapsules:
        return context.t.timeCapsules;
      case HomeIndexEnum.favourite:
        return context.t.favourite;
      case HomeIndexEnum.superUnfolded:
        return context.t.superUnfolded;
      case HomeIndexEnum.timeMachine:
        return context.t.timeMachine;
    }
  }
}

enum LanguageEnum { english, simplifiedChinese, traditionalChinese }

extension LanguageEnumExtension on LanguageEnum {
  String getString(BuildContext context) {
    switch (this) {
      case LanguageEnum.english:
        return context.t.english;
      case LanguageEnum.simplifiedChinese:
        return context.t.simplifiedChinese;
      case LanguageEnum.traditionalChinese:
        return context.t.traditionalChinese;
    }
  }

  String languageCode() {
    switch (this) {
      case LanguageEnum.english:
        return 'en';
      case LanguageEnum.simplifiedChinese:
        return 'zh';
      case LanguageEnum.traditionalChinese:
        return 'zh';
    }
  }

  String countryCode() {
    switch (this) {
      case LanguageEnum.english:
        return '';
      case LanguageEnum.simplifiedChinese:
        return 'CN';
      case LanguageEnum.traditionalChinese:
        return 'TW';
    }
  }
}

enum NavigationEnum {
  ranking,
  searchEntry,
  indexing,
  catalog,
  today,
  journal,
  tag,
  ongoing,
  info,
  search,
  stock,
  wiki,
  almanac,
  timeline,
  netabare,
  localSMB,
  bilibiliSync,
  doubanSync,
  associate,
  backupCSV,
  myCharacter,
  myCatalogue,
  clipboard,
  settings,
}

extension NavigationEnumExtension on NavigationEnum {
  String getString(BuildContext context) {
    switch (this) {
      case NavigationEnum.ranking:
        return context.t.ranking;
      case NavigationEnum.searchEntry:
        return context.t.searchEntry;
      case NavigationEnum.indexing:
        return context.t.indexing;
      case NavigationEnum.catalog:
        return context.t.catalog;
      case NavigationEnum.today:
        return context.t.today;
      case NavigationEnum.journal:
        return context.t.journal;
      case NavigationEnum.tag:
        return context.t.tag;
      case NavigationEnum.ongoing:
        return context.t.ongoing;
      case NavigationEnum.info:
        return context.t.info;
      case NavigationEnum.search:
        return context.t.search;
      case NavigationEnum.stock:
        return context.t.stock;
      case NavigationEnum.wiki:
        return context.t.wiki;
      case NavigationEnum.almanac:
        return context.t.almanac;
      case NavigationEnum.timeline:
        return context.t.timeline;
      case NavigationEnum.netabare:
        return context.t.netabare;
      case NavigationEnum.localSMB:
        return context.t.localSMB;
      case NavigationEnum.bilibiliSync:
        return context.t.bilibiliSync;
      case NavigationEnum.doubanSync:
        return context.t.doubanSync;
      case NavigationEnum.associate:
        return context.t.associate;
      case NavigationEnum.backupCSV:
        return context.t.backupCSV;
      case NavigationEnum.myCharacter:
        return context.t.myCharacter;
      case NavigationEnum.myCatalogue:
        return context.t.myCatalogue;
      case NavigationEnum.clipboard:
        return context.t.clipboard;
      case NavigationEnum.settings:
        return context.t.settings;
    }
  }
}

enum CalendarScreenFilterOption {
  all,
  collection,
}

extension CalendarScreenOptionExtension on CalendarScreenFilterOption {
  String getString(BuildContext context) {
    switch (this) {
      case CalendarScreenFilterOption.all:
        return context.t.entire;
      case CalendarScreenFilterOption.collection:
        return context.t.favourite;
    }
  }
}

enum ScreenLayoutOption {
  grid,
  list,
}

enum ScreenSubjectOption {
  entry(value: 5, api: 'entry'),
  anime(value: 2, api: 'anime'),
  book(value: 1, api: 'book'),
  music(value: 3, api: 'music'),
  game(value: 4, api: 'game'),
  film(value: 6, api: 'real'),
  character(value: 7, api: 'character'),
  user(value: 8, api: 'user');

  final int value;
  final String api;
  const ScreenSubjectOption({required this.value, required this.api});
}

extension SubjectOptionExtension on ScreenSubjectOption {
  String toJson() {
    return name;
  }

  String getString(BuildContext context) {
    switch (this) {
      case ScreenSubjectOption.entry:
        return context.t.entry;
      case ScreenSubjectOption.anime:
        return context.t.anime;
      case ScreenSubjectOption.book:
        return context.t.book;
      case ScreenSubjectOption.music:
        return context.t.music;
      case ScreenSubjectOption.game:
        return context.t.game;
      case ScreenSubjectOption.film:
        return context.t.film;
      case ScreenSubjectOption.character:
        return context.t.character;
      case ScreenSubjectOption.user:
        return context.t.user;
    }
  }

  String? filterUrl({
    required AnimeTypeOption? animeTypeOption,
    required BookTypeOption? bookTypeOption,
    required RealTypeOption? realTypeOption,
    required GameTypeOption? gameTypeOption,
  }) {
    switch (this) {
      case ScreenSubjectOption.anime:
        if (animeTypeOption == null) return null;
        return '/${animeTypeOption.getUrl()}';
      case ScreenSubjectOption.book:
        if (bookTypeOption == null) return null;
        return '/${bookTypeOption.getUrl()}';
      case ScreenSubjectOption.film:
        if (realTypeOption == null) return null;
        return '/${realTypeOption.getUrl()}';
      case ScreenSubjectOption.game:
        if (gameTypeOption == null) return null;
        return '/${gameTypeOption.getUrl()}';
      default:
        return '';
    }
  }

  String? filterString({
    required BuildContext context,
    required AnimeTypeOption? animeTypeOption,
    required BookTypeOption? bookTypeOption,
    required RealTypeOption? realTypeOption,
    required GameTypeOption? gameTypeOption,
  }) {
    switch (this) {
      case ScreenSubjectOption.anime:
        if (animeTypeOption == null) return null;
        return animeTypeOption.getString(context);
      case ScreenSubjectOption.book:
        if (bookTypeOption == null) return null;
        return bookTypeOption.getString(context);
      case ScreenSubjectOption.film:
        if (realTypeOption == null) return null;
        return realTypeOption.getString(context);
      case ScreenSubjectOption.game:
        if (gameTypeOption == null) return null;
        return gameTypeOption.getString(context);
      default:
        return '';
    }
  }
}

enum SearchScreenFilterOption {
  // accurate(1),
  vague(0);

  final int value;
  const SearchScreenFilterOption(this.value);
}

enum SearchScreenResponseGroup { small, medium, large }

enum SubjectRelationGroup {
  character,
  productionStaff,
  relation,
}

enum CareerGroup {
  producer,
  mangaka,
  artist,
  seiyu,
  writer,
  illustrator,
  actor,
}

extension CareerGroupExtension on CareerGroup {
  String getString(BuildContext context) {
    switch (this) {
      case CareerGroup.producer:
        return context.t.producer;
      case CareerGroup.mangaka:
        return context.t.mangaka;
      case CareerGroup.artist:
        return context.t.artist;
      case CareerGroup.seiyu:
        return context.t.seiyu;
      case CareerGroup.writer:
        return context.t.writer;
      case CareerGroup.illustrator:
        return context.t.illustrator;
      case CareerGroup.actor:
        return context.t.actor;
    }
  }
}

enum ImageSizeGroup { small, common, medium, large, grid }

enum SortOption { collects, title, date, rank }

extension SortOptionExtension on SortOption {
  String getString(BuildContext context) {
    switch (this) {
      case SortOption.collects:
        return context.t.numberOfAnnotations;
      case SortOption.title:
        return context.t.name;
      case SortOption.date:
        return context.t.date;
      case SortOption.rank:
        return context.t.ranking;
    }
  }
}

enum AnimeTypeOption { all, tv, web, ova, movie, others }

extension AnimeTypeOptionExtension on AnimeTypeOption {
  String getString(BuildContext context) {
    switch (this) {
      case AnimeTypeOption.all:
        return context.t.entire;
      case AnimeTypeOption.tv:
        return context.t.tv;
      case AnimeTypeOption.web:
        return context.t.web;
      case AnimeTypeOption.ova:
        return context.t.ova;
      case AnimeTypeOption.movie:
        return context.t.movie;
      case AnimeTypeOption.others:
        return context.t.others;
    }
  }

  String getUrl() {
    switch (this) {
      case AnimeTypeOption.all:
        return '';
      case AnimeTypeOption.tv:
        return 'tv';
      case AnimeTypeOption.web:
        return 'web';
      case AnimeTypeOption.ova:
        return 'ova';
      case AnimeTypeOption.movie:
        return 'movie';
      case AnimeTypeOption.others:
        return 'misc';
    }
  }
}

enum BookTypeOption { all, comic, novel, illustration, others }

extension BookTypeOptionExtension on BookTypeOption {
  String getString(BuildContext context) {
    switch (this) {
      case BookTypeOption.all:
        return context.t.entire;
      case BookTypeOption.comic:
        return context.t.comic;
      case BookTypeOption.novel:
        return context.t.novel;
      case BookTypeOption.illustration:
        return context.t.illustration;
      case BookTypeOption.others:
        return context.t.others;
    }
  }

  String getUrl() {
    switch (this) {
      case BookTypeOption.all:
        return '';
      case BookTypeOption.comic:
        return 'comic';
      case BookTypeOption.novel:
        return 'novel';
      case BookTypeOption.illustration:
        return 'illustration';
      case BookTypeOption.others:
        return 'misc';
    }
  }
}

enum RealTypeOption { all, japan, europe, china, others }

extension RealTypeOptionExtension on RealTypeOption {
  String getString(BuildContext context) {
    switch (this) {
      case RealTypeOption.all:
        return context.t.entire;
      case RealTypeOption.japan:
        return context.t.japaneseDrama;
      case RealTypeOption.europe:
        return context.t.europeanNAmericanDramas;
      case RealTypeOption.china:
        return context.t.chineseDrama;
      case RealTypeOption.others:
        return context.t.others;
    }
  }

  String getUrl() {
    switch (this) {
      case RealTypeOption.all:
        return '';
      case RealTypeOption.japan:
        return 'jp';
      case RealTypeOption.europe:
        return 'en';
      case RealTypeOption.china:
        return 'cn';
      case RealTypeOption.others:
        return 'misc';
    }
  }
}

enum GameTypeOption {
  all,
  pc,
  ns,
  ps5,
  ps4,
  psv,
  xboxSeries,
  xboxOne,
  wiiU,
  ps3,
  xbox360,
  threeDS,
  psp,
  wii,
  nds,
  ps2,
  xbox,
  mac,
  ps,
  gba,
  gb,
  fc
}

extension GameTypeOptionExtension on GameTypeOption {
  String getString(BuildContext context) {
    switch (this) {
      case GameTypeOption.all:
        return context.t.entire;
      case GameTypeOption.pc:
        return context.t.pc;
      case GameTypeOption.ns:
        return context.t.ns;
      case GameTypeOption.ps5:
        return context.t.ps5;
      case GameTypeOption.ps4:
        return context.t.ps4;
      case GameTypeOption.psv:
        return context.t.psv;
      case GameTypeOption.xboxSeries:
        return context.t.xboxSeries;
      case GameTypeOption.xboxOne:
        return context.t.xboxOne;
      case GameTypeOption.wiiU:
        return context.t.wiiU;
      case GameTypeOption.ps3:
        return context.t.ps3;
      case GameTypeOption.xbox360:
        return context.t.xbox360;
      case GameTypeOption.threeDS:
        return context.t.threeDS;
      case GameTypeOption.psp:
        return context.t.psp;
      case GameTypeOption.wii:
        return context.t.wii;
      case GameTypeOption.nds:
        return context.t.nds;
      case GameTypeOption.ps2:
        return context.t.ps2;
      case GameTypeOption.xbox:
        return context.t.xbox;
      case GameTypeOption.mac:
        return context.t.mac;
      case GameTypeOption.ps:
        return context.t.ps;
      case GameTypeOption.gba:
        return context.t.gba;
      case GameTypeOption.gb:
        return context.t.gb;
      case GameTypeOption.fc:
        return context.t.fc;
    }
  }

  String getUrl() {
    switch (this) {
      case GameTypeOption.all:
        return '';
      case GameTypeOption.pc:
        return 'pc';
      case GameTypeOption.ns:
        return 'ns';
      case GameTypeOption.ps5:
        return 'ps5';
      case GameTypeOption.ps4:
        return 'ps4';
      case GameTypeOption.psv:
        return 'psv';
      case GameTypeOption.xboxSeries:
        return 'xbox_series_xs';
      case GameTypeOption.xboxOne:
        return 'xbox_one';
      case GameTypeOption.wiiU:
        return 'will_u';
      case GameTypeOption.ps3:
        return 'ps3';
      case GameTypeOption.xbox360:
        return 'xbox360';
      case GameTypeOption.threeDS:
        return '3ds';
      case GameTypeOption.psp:
        return 'psp';
      case GameTypeOption.wii:
        return 'wii';
      case GameTypeOption.nds:
        return 'nds';
      case GameTypeOption.ps2:
        return 'ps2';
      case GameTypeOption.xbox:
        return 'xbox';
      case GameTypeOption.mac:
        return 'mac';
      case GameTypeOption.ps:
        return 'ps';
      case GameTypeOption.gba:
        return 'gba';
      case GameTypeOption.gb:
        return 'gb';
      case GameTypeOption.fc:
        return 'fc';
    }
  }
}
