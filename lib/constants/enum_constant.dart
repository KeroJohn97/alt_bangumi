import 'package:flutter_bangumi/constants/text_constant.dart';

enum HomeIndexEnum {
  discover,
  timeCapsules,
  favourite,
  superUnfolded,
  timeMachine,
}

extension HomeIndexEnumExtension on HomeIndexEnum {
  String display() {
    switch (this) {
      case HomeIndexEnum.discover:
        return TextConstant.discover;
      case HomeIndexEnum.timeCapsules:
        return TextConstant.timeCapsules;
      case HomeIndexEnum.favourite:
        return TextConstant.favourite;
      case HomeIndexEnum.superUnfolded:
        return TextConstant.superUnfolded;
      case HomeIndexEnum.timeMachine:
        return TextConstant.timeMachine;
    }
  }
}

enum NavigationEnum {
  ranking,
  entry,
  indexing,
  catalogue,
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
