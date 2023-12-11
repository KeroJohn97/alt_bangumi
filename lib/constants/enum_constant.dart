import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

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
        return TextConstant.discover.getString(context);
      case HomeIndexEnum.timeCapsules:
        return TextConstant.timeCapsules.getString(context);
      case HomeIndexEnum.favourite:
        return TextConstant.favourite.getString(context);
      case HomeIndexEnum.superUnfolded:
        return TextConstant.superUnfolded.getString(context);
      case HomeIndexEnum.timeMachine:
        return TextConstant.timeMachine.getString(context);
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
}

extension NavigationEnumExtension on NavigationEnum {
  String displayName(BuildContext context) {
    switch (this) {
      case NavigationEnum.ranking:
        return TextConstant.ranking.getString(context);
      case NavigationEnum.searchEntry:
        return TextConstant.searchEntry.getString(context);
      case NavigationEnum.indexing:
        return TextConstant.indexing.getString(context);
      case NavigationEnum.catalog:
        return TextConstant.catalog.getString(context);
      case NavigationEnum.today:
        return TextConstant.today.getString(context);
      case NavigationEnum.journal:
        return TextConstant.journal.getString(context);
      case NavigationEnum.tag:
        return TextConstant.tag.getString(context);
      case NavigationEnum.ongoing:
        return TextConstant.ongoing.getString(context);
      case NavigationEnum.info:
        return TextConstant.info.getString(context);
      case NavigationEnum.search:
        return TextConstant.search.getString(context);
      case NavigationEnum.stock:
        return TextConstant.stock.getString(context);
      case NavigationEnum.wiki:
        return TextConstant.wiki.getString(context);
      case NavigationEnum.almanac:
        return TextConstant.almanac.getString(context);
      case NavigationEnum.timeline:
        return TextConstant.timeline.getString(context);
      case NavigationEnum.netabare:
        return TextConstant.netabare.getString(context);
      case NavigationEnum.localSMB:
        return TextConstant.localSMB.getString(context);
      case NavigationEnum.bilibiliSync:
        return TextConstant.bilibiliSync.getString(context);
      case NavigationEnum.doubanSync:
        return TextConstant.doubanSync.getString(context);
      case NavigationEnum.associate:
        return TextConstant.associate.getString(context);
      case NavigationEnum.backupCSV:
        return TextConstant.backupCSV.getString(context);
      case NavigationEnum.myCharacter:
        return TextConstant.myCharacter.getString(context);
      case NavigationEnum.myCatalogue:
        return TextConstant.myCatalogue.getString(context);
      case NavigationEnum.clipboard:
        return TextConstant.clipboard.getString(context);
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
        return TextConstant.entire.getString(context);
      case CalendarScreenFilterOption.collection:
        return TextConstant.favourite.getString(context);
    }
  }
}

enum ScreenLayoutOption {
  grid,
  list,
}

enum ScreenSubjectOption {
  entry(5),
  anime(2),
  book(1),
  music(3),
  game(4),
  real(6),
  character(7),
  user(8);

  final int value;
  const ScreenSubjectOption(this.value);
}

extension SubjectOptionExtension on ScreenSubjectOption {
  String toJson() {
    return name;
  }

  String getString(BuildContext context) {
    switch (this) {
      case ScreenSubjectOption.entry:
        return TextConstant.entry.getString(context);
      case ScreenSubjectOption.anime:
        return TextConstant.anime.getString(context);
      case ScreenSubjectOption.book:
        return TextConstant.book.getString(context);
      case ScreenSubjectOption.music:
        return TextConstant.music.getString(context);
      case ScreenSubjectOption.game:
        return TextConstant.game.getString(context);
      case ScreenSubjectOption.real:
        return TextConstant.real.getString(context);
      case ScreenSubjectOption.character:
        return TextConstant.character.getString(context);
      case ScreenSubjectOption.user:
        return TextConstant.user.getString(context);
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
      case ScreenSubjectOption.real:
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
      case ScreenSubjectOption.real:
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
        return TextConstant.producer.getString(context);
      case CareerGroup.mangaka:
        return TextConstant.mangaka.getString(context);
      case CareerGroup.artist:
        return TextConstant.artist.getString(context);
      case CareerGroup.seiyu:
        return TextConstant.seiyu.getString(context);
      case CareerGroup.writer:
        return TextConstant.writer.getString(context);
      case CareerGroup.illustrator:
        return TextConstant.illustrator.getString(context);
      case CareerGroup.actor:
        return TextConstant.actor.getString(context);
    }
  }
}

enum ImageSizeGroup { small, common, medium, large, grid }

enum SortOption { collects, title, date, rank }

enum AnimeTypeOption { all, tv, web, ova, movie, others }

extension AnimeTypeOptionExtension on AnimeTypeOption {
  String getString(BuildContext context) {
    switch (this) {
      case AnimeTypeOption.all:
        return TextConstant.entire.getString(context);
      case AnimeTypeOption.tv:
        return TextConstant.tv.getString(context);
      case AnimeTypeOption.web:
        return TextConstant.web.getString(context);
      case AnimeTypeOption.ova:
        return TextConstant.ova.getString(context);
      case AnimeTypeOption.movie:
        return TextConstant.movie.getString(context);
      case AnimeTypeOption.others:
        return TextConstant.others.getString(context);
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
        return TextConstant.entire.getString(context);
      case BookTypeOption.comic:
        return TextConstant.comic.getString(context);
      case BookTypeOption.novel:
        return TextConstant.novel.getString(context);
      case BookTypeOption.illustration:
        return TextConstant.illustration.getString(context);
      case BookTypeOption.others:
        return TextConstant.others.getString(context);
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
        return TextConstant.entire.getString(context);
      case RealTypeOption.japan:
        return TextConstant.japaneseDrama.getString(context);
      case RealTypeOption.europe:
        return TextConstant.europeanNAmericanDramas.getString(context);
      case RealTypeOption.china:
        return TextConstant.chineseDrama.getString(context);
      case RealTypeOption.others:
        return TextConstant.others.getString(context);
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
        return TextConstant.entire.getString(context);
      case GameTypeOption.pc:
        return TextConstant.pc.getString(context);
      case GameTypeOption.ns:
        return TextConstant.ns.getString(context);
      case GameTypeOption.ps5:
        return TextConstant.ps5.getString(context);
      case GameTypeOption.ps4:
        return TextConstant.ps4.getString(context);
      case GameTypeOption.psv:
        return TextConstant.psv.getString(context);
      case GameTypeOption.xboxSeries:
        return TextConstant.xboxSeries.getString(context);
      case GameTypeOption.xboxOne:
        return TextConstant.xboxOne.getString(context);
      case GameTypeOption.wiiU:
        return TextConstant.wiiU.getString(context);
      case GameTypeOption.ps3:
        return TextConstant.ps3.getString(context);
      case GameTypeOption.xbox360:
        return TextConstant.xbox360.getString(context);
      case GameTypeOption.threeDS:
        return TextConstant.threeDS.getString(context);
      case GameTypeOption.psp:
        return TextConstant.psp.getString(context);
      case GameTypeOption.wii:
        return TextConstant.wii.getString(context);
      case GameTypeOption.nds:
        return TextConstant.nds.getString(context);
      case GameTypeOption.ps2:
        return TextConstant.ps2.getString(context);
      case GameTypeOption.xbox:
        return TextConstant.xbox.getString(context);
      case GameTypeOption.mac:
        return TextConstant.mac.getString(context);
      case GameTypeOption.ps:
        return TextConstant.ps.getString(context);
      case GameTypeOption.gba:
        return TextConstant.gba.getString(context);
      case GameTypeOption.gb:
        return TextConstant.gb.getString(context);
      case GameTypeOption.fc:
        return TextConstant.fc.getString(context);
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
