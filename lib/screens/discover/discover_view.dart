import 'package:flutter/material.dart';
import 'package:flutter_bangumi/constants/enum_constant.dart';
import 'package:flutter_bangumi/constants/text_constant.dart';
import 'package:flutter_bangumi/helpers/sizing_helper.dart';
import 'package:flutter_bangumi/widgets/discover/anime_card.dart';
import 'package:flutter_bangumi/widgets/discover/banner_widget.dart';
import 'package:flutter_bangumi/widgets/discover/icon_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/bad_repository.dart';

class DiscoverView extends ConsumerStatefulWidget {
  const DiscoverView({super.key});

  @override
  ConsumerState<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends ConsumerState<DiscoverView> {
  void _navigationCallback() {}

  IconData _setIconData(NavigationEnum navigationEnum) {
    switch (navigationEnum) {
      case NavigationEnum.ranking:
        return Icons.bar_chart_outlined;
      case NavigationEnum.entry:
        return Icons.smart_display_outlined;
      case NavigationEnum.indexing:
        return Icons.list_outlined;
      case NavigationEnum.catalogue:
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            BannerWidget(height: 10.h, width: 100.w, imageUrl: ''),
            SizedBox(height: 2.h),
            Wrap(
              children: [
                ...NavigationEnum.values
                    .where((element) => element.name.contains('l'))
                    .map(
                      (e) => CustomIconButton(
                        callback: _navigationCallback,
                        labelText: e.name,
                        iconData: _setIconData(e),
                      ),
                    )
                    .toList()
              ],
            ),
            Row(
              children: [
                FutureBuilder<String?>(
                    future: _getOnlineUser(),
                    builder: (context, snapshot) {
                      return Text(
                        '${TextConstant.online.toLowerCase()} ${snapshot.data ?? ''}',
                        textAlign: TextAlign.start,
                      );
                    }),
              ],
            ),
            Row(
              children: const [
                Text(TextConstant.anime),
                Spacer(),
                Text('${TextConstant.channel} >'),
              ],
            ),
            const SizedBox(height: 10.0),
            const AnimeCard(
              imageUrl:
                  'http://lain.bgm.tv/r/400/pic/cover/l/a7/73/413741_dVC7f.jpg',
            ),
            const SizedBox(height: 10.0),
            const AnimeCard(
              imageUrl:
                  'http://lain.bgm.tv/r/400/pic/cover/l/13/c5/400602_ZI8Y9.jpg',
            ),
            const SizedBox(height: 10.0),
          ]),
        ),
      ),
    );
  }
}
