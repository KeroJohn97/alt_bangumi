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
  String displayName() {
    switch (this) {
      case CalendarScreenFilterOption.all:
        return '全部';
      case CalendarScreenFilterOption.collection:
        return '收藏';
    }
  }
}

enum CalendarScreenViewOption {
  grid,
  list,
}

enum SearchScreenSubjectOption {
  entry(5),
  anime(2),
  book(1),
  music(3),
  game(4),
  real(6),
  character(7),
  user(8);

  final int value;
  const SearchScreenSubjectOption(this.value);
}

extension SubjectOptionExtension on SearchScreenSubjectOption {
  toJson() {
    return name;
  }

  displayName(BuildContext context) {
    switch (this) {
      case SearchScreenSubjectOption.entry:
        return TextConstant.entry.getString(context);
      case SearchScreenSubjectOption.anime:
        return TextConstant.anime.getString(context);
      case SearchScreenSubjectOption.book:
        return TextConstant.book.getString(context);
      case SearchScreenSubjectOption.music:
        return TextConstant.music.getString(context);
      case SearchScreenSubjectOption.game:
        return TextConstant.game.getString(context);
      case SearchScreenSubjectOption.real:
        return TextConstant.real.getString(context);
      case SearchScreenSubjectOption.character:
        return TextConstant.character.getString(context);
      case SearchScreenSubjectOption.user:
        return TextConstant.user.getString(context);
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
  String displayName(BuildContext context) {
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
