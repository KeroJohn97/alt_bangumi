import 'dart:convert';

import 'package:alt_bangumi/screens/search/search_screen.dart';
import 'package:alt_bangumi/widgets/custom_gif_widget.dart';
import 'package:alt_bangumi/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/screens/calendar/calendar_screen.dart';
import 'package:alt_bangumi/widgets/discover/anime_card.dart';
import 'package:alt_bangumi/widgets/discover/banner_widget.dart';
import 'package:alt_bangumi/widgets/discover/icon_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../repositories/bad_repository.dart';

class DiscoverView extends ConsumerStatefulWidget {
  const DiscoverView({super.key});

  @override
  ConsumerState<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends ConsumerState<DiscoverView> {
  void _navigationCallback(NavigationEnum navigationEnum) {
    context.push(_getScreenRoute(navigationEnum));
  }

  String _getScreenRoute(NavigationEnum navigationEnum) {
    switch (navigationEnum) {
      case NavigationEnum.ranking:
        // TODO: Handle this case.
        break;
      case NavigationEnum.searchEntry:
        // TODO: Handle this case.
        break;
      case NavigationEnum.indexing:
        // TODO: Handle this case.
        break;
      case NavigationEnum.catalog:
        // TODO: Handle this case.
        break;
      case NavigationEnum.today:
        return CalendarScreen.route;
      case NavigationEnum.journal:
        // TODO: Handle this case.
        break;
      case NavigationEnum.tag:
        // TODO: Handle this case.
        break;
      case NavigationEnum.ongoing:
        // TODO: Handle this case.
        break;
      case NavigationEnum.info:
        // TODO: Handle this case.
        break;
      case NavigationEnum.search:
        return SearchScreen.route;
      case NavigationEnum.stock:
        // TODO: Handle this case.
        break;
      case NavigationEnum.wiki:
        // TODO: Handle this case.
        break;
      case NavigationEnum.almanac:
        // TODO: Handle this case.
        break;
      case NavigationEnum.timeline:
        // TODO: Handle this case.
        break;
      case NavigationEnum.netabare:
        // TODO: Handle this case.
        break;
      case NavigationEnum.localSMB:
        // TODO: Handle this case.
        break;
      case NavigationEnum.bilibiliSync:
        // TODO: Handle this case.
        break;
      case NavigationEnum.doubanSync:
        // TODO: Handle this case.
        break;
      case NavigationEnum.associate:
        // TODO: Handle this case.
        break;
      case NavigationEnum.backupCSV:
        // TODO: Handle this case.
        break;
      case NavigationEnum.myCharacter:
        // TODO: Handle this case.
        break;
      case NavigationEnum.myCatalogue:
        // TODO: Handle this case.
        break;
      case NavigationEnum.clipboard:
        // TODO: Handle this case.
        break;
      default:
        return '';
    }
    return '';
  }

  IconData _setIconData(NavigationEnum navigationEnum) {
    switch (navigationEnum) {
      case NavigationEnum.ranking:
        return Icons.bar_chart_outlined;
      case NavigationEnum.searchEntry:
        return Icons.smart_display_outlined;
      case NavigationEnum.indexing:
        return Icons.list_outlined;
      case NavigationEnum.catalog:
        return Icons.folder_outlined;
      case NavigationEnum.today:
        return Icons.calendar_today_outlined;
      case NavigationEnum.journal:
        return Icons.edit_outlined;
      case NavigationEnum.tag:
        return Icons.tag_outlined;
      case NavigationEnum.ongoing:
        return Icons.local_activity_outlined;
      case NavigationEnum.info:
        return Icons.info_outlined;
      case NavigationEnum.search:
        return Icons.search_outlined;
      case NavigationEnum.stock:
        return Icons.monitor_outlined;
      case NavigationEnum.wiki:
        return Icons.public_outlined;
      case NavigationEnum.almanac:
        return Icons.bookmark_outlined;
      case NavigationEnum.timeline:
        return Icons.timeline_outlined;
      case NavigationEnum.netabare:
        return Icons.reviews_outlined;
      case NavigationEnum.localSMB:
        return Icons.cloud_sync_outlined;
      case NavigationEnum.bilibiliSync:
        return Icons.baby_changing_station_outlined;
      case NavigationEnum.doubanSync:
        return Icons.dangerous_outlined;
      case NavigationEnum.associate:
        return Icons.r_mobiledata_outlined;
      case NavigationEnum.backupCSV:
        return Icons.backup_outlined;
      case NavigationEnum.myCharacter:
        return Icons.person_4_outlined;
      case NavigationEnum.myCatalogue:
        return Icons.macro_off_outlined;
      case NavigationEnum.clipboard:
        return Icons.circle_sharp;
    }
  }

  Future<String?> _getOnlineUser() async {
    final result = BadRepository.onlineUsers();
    return result;
  }

  void _pushChannelScreen() {
    // context.push(CalendarScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    final list = NavigationEnum.values
        .where((element) =>
            element.name.contains('t') || element.name.contains('search'))
        .toList();
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            BannerWidget(
              height: 20.h,
              width: 100.w,
              imageUrl:
                  'https://www.wikihow.com/images/thumb/7/72/Right-Click-on-a-MacBook-Step-6.jpg/aid551538-v4-728px-Right-Click-on-a-MacBook-Step-6.jpg.webp',
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: 100.w,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 0.8,
                ),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomIconButton(
                    callback: () => _navigationCallback(list[index]),
                    labelText: list[index].displayName(context),
                    iconData: _setIconData(list[index]),
                  );
                },
              ),
              // Wrap(
              //   children: [
              //     ...NavigationEnum.values
              //         .where((element) =>
              //             element.name.contains('t') ||
              //             element.name.contains('search'))
              //         .map(
              //           (e) => CustomIconButton(
              //             callback: () => _navigationCallback(e),
              //             labelText: e.name,
              //             iconData: _setIconData(e),
              //           ),
              //         )
              //         .toList()
              //   ],
              // ),
            ),
            Row(
              children: [
                FutureBuilder<String?>(
                    future: _getOnlineUser(),
                    builder: (context, snapshot) {
                      return Text(
                        '${TextConstant.online.toLowerCase().getString(context)} ${snapshot.data ?? ''}',
                        textAlign: TextAlign.start,
                      );
                    }),
              ],
            ),
            Row(
              children: [
                Text(TextConstant.anime.getString(context)),
                const Spacer(),
                TextButton(
                  onPressed: _pushChannelScreen,
                  child: Text('${TextConstant.channel.getString(context)} >'),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const CustomLoadingWidget(),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () async {
                const directoryPath = 'assets/images/bgm';
                const filePrefix = 'gif_';
                var assets = await rootBundle.loadString('AssetManifest.json');
                Map json = jsonDecode(assets);
                List<dynamic> fileList = json.keys
                    .where((element) =>
                        '$element'.startsWith('$directoryPath/$filePrefix'))
                    .toList();
                if (!mounted || fileList.isEmpty) return;
                showDialog(
                  context: context,
                  builder: (context) => Dialog.fullscreen(
                    child: CustomGifWidget(
                      directoryPath: directoryPath,
                      fileCount: fileList.length,
                      filePrefix: filePrefix,
                    ),
                  ),
                );
              },
              child: const AnimeCard(
                imageUrl:
                    'http://lain.bgm.tv/r/400/pic/cover/l/a7/73/413741_dVC7f.jpg',
                followers: '13989',
                title: '陰陽師の異世界転生記',
              ),
            ),
            const SizedBox(height: 10.0),
            const AnimeCard(
              imageUrl:
                  'http://lain.bgm.tv/r/400/pic/cover/l/13/c5/400602_ZI8Y9.jpg',
              followers: '23432',
              title: '葬送のフリーレン',
            ),
            const SizedBox(height: 10.0),
          ]),
        ),
      ),
    );
  }
}
