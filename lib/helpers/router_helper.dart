import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/screens/calendar/calendar_screen.dart';
import 'package:alt_bangumi/screens/character_detail_screen.dart';
import 'package:alt_bangumi/screens/home/home_screen.dart';
import 'package:alt_bangumi/screens/person_detail_screen.dart';
import 'package:alt_bangumi/screens/search/search_screen.dart';
import 'package:alt_bangumi/screens/settings/settings_screen.dart';
import 'package:alt_bangumi/screens/subject_characters_screen.dart';
import 'package:alt_bangumi/screens/subject_detail_screen.dart';
import 'package:alt_bangumi/screens/subject_sharing_screen.dart';
import 'package:alt_bangumi/screens/tag/single_tag_screen.dart';
import 'package:alt_bangumi/screens/tag/tags_screen.dart';
import 'package:go_router/go_router.dart';

import '../screens/ranking/ranking_screen.dart';
import '../screens/subject_persons_screen.dart';

final routerHelper = GoRouter(
  initialLocation: HomeScreen.route,
  routes: [
    GoRoute(
      path: HomeScreen.route,
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: CalendarScreen.route,
      builder: (_, __) => const CalendarScreen(),
    ),
    GoRoute(
      path: SearchScreen.route,
      builder: (_, __) => const SearchScreen(),
    ),
    GoRoute(
        path: SubjectDetailScreen.route,
        builder: (context, state) {
          final stateExtra = state.extra;
          final Map<String, dynamic> extra = {};
          if (stateExtra is Map<String, dynamic>) {
            extra.addAll(stateExtra);
          }
          return SubjectDetailScreen(
            subjectId: extra[SubjectDetailScreen.subjectIdKey],
          );
        }),
    GoRoute(
        path: CharacterDetailScreen.route,
        builder: (context, state) {
          final stateExtra = state.extra;
          final Map<String, dynamic> extra = {};
          if (stateExtra is Map<String, dynamic>) {
            extra.addAll(stateExtra);
          }
          return CharacterDetailScreen(
            character: extra[CharacterDetailScreen.characterKey],
          );
        }),
    GoRoute(
        path: PersonDetailScreen.route,
        builder: (context, state) {
          final stateExtra = state.extra;
          final Map<String, dynamic> extra = {};
          if (stateExtra is Map<String, dynamic>) {
            extra.addAll(stateExtra);
          }
          return PersonDetailScreen(
            person: extra[PersonDetailScreen.personKey],
          );
        }),
    GoRoute(
        path: SubjectSharingScreen.route,
        builder: (context, state) {
          final stateExtra = state.extra;
          final Map<String, dynamic> extra = {};
          if (stateExtra is Map<String, dynamic>) {
            extra.addAll(stateExtra);
          }
          return SubjectSharingScreen(
            shortTag: extra[SubjectSharingScreen.shortTagKey],
            id: extra[SubjectSharingScreen.idKey],
            imageProvider: extra[SubjectSharingScreen.imageProviderKey],
            name: extra[SubjectSharingScreen.nameKey],
            summary: extra[SubjectSharingScreen.summaryKey],
          );
        }),
    GoRoute(
      path: RankingScreen.route,
      builder: (context, state) {
        final stateExtra = state.extra;
        final Map<String, dynamic> extra = {};
        if (stateExtra is Map<String, dynamic>) {
          extra.addAll(stateExtra);
        }
        return RankingScreen(url: extra[RankingScreen.urlKey]);
      },
    ),
    GoRoute(
      path: TagsScreen.route,
      builder: (_, __) {
        return const TagsScreen();
      },
    ),
    GoRoute(
      path: SingleTagScreen.route,
      builder: (context, state) {
        final stateExtra = state.extra;
        final Map<String, dynamic> extra = {};
        if (stateExtra is Map<String, dynamic>) {
          extra.addAll(stateExtra);
        }
        return SingleTagScreen(
          tag: extra[SingleTagScreen.tagKey],
          subjectOption: ScreenSubjectOption.values.firstWhere((element) =>
              element.toJson() == extra[SingleTagScreen.subjectKey]),
        );
      },
    ),
    GoRoute(
      path: SubjectCharactersScreen.route,
      builder: (context, state) {
        final stateExtra = state.extra;
        final Map<String, dynamic> extra = {};
        if (stateExtra is Map<String, dynamic>) {
          extra.addAll(stateExtra);
        }
        return SubjectCharactersScreen(
          relations: extra[SubjectCharactersScreen.relationsKey],
          subject: extra[SubjectCharactersScreen.subjectKey],
        );
      },
    ),
    GoRoute(
      path: SubjectPersonsScreen.route,
      builder: (context, state) {
        final stateExtra = state.extra;
        final Map<String, dynamic> extra = {};
        if (stateExtra is Map<String, dynamic>) {
          extra.addAll(stateExtra);
        }
        return SubjectPersonsScreen(
          relations: extra[SubjectPersonsScreen.relationsKey],
          subject: extra[SubjectPersonsScreen.subjectKey],
        );
      },
    ),
    GoRoute(
      path: SettingsScreen.route,
      builder: (context, state) {
        return const SettingsScreen();
      },
    )
  ],
);
