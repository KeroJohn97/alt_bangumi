import 'package:alt_bangumi/screens/calendar/calendar_screen.dart';
import 'package:alt_bangumi/screens/character_detail_screen.dart';
import 'package:alt_bangumi/screens/home/home_screen.dart';
import 'package:alt_bangumi/screens/person_detail_screen.dart';
import 'package:alt_bangumi/screens/search/search_screen.dart';
import 'package:alt_bangumi/screens/subject_detail_screen.dart';
import 'package:alt_bangumi/screens/subject_sharing_screen.dart';
import 'package:go_router/go_router.dart';

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
  ],
);
