import 'dart:ui';

import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/router_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:alt_bangumi/providers/discover_view_provider.dart';
import 'package:alt_bangumi/screens/home/widgets/connectivity_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:ioc_container/ioc_container.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:patrol/patrol.dart';

// Your mock needs to subclass the Notifier base-class corresponding
// to whatever your notifier uses
class MockDiscoverViewStateNotifier extends Notifier<DiscoverViewState>
    with Mock
    implements DiscoverViewStateNotifier {}

// @GenerateMocks([FlutterLocalization, FlutterLocalizationDelegate])
// @GenerateNiceMocks([MockSpec<FlutterLocalization>()])
// @GenerateNiceMocks([MockSpec<HttpHelper>()])
// @GenerateNiceMocks([MockSpec<DiscoverViewStateNotifier>()])

// class MockFlutterLocalization extends Mock implements FlutterLocalization {}

// IocContainerBuilder compose() => IocContainerBuild

void main() {
  late StateNotifierProvider<DiscoverViewStateNotifier, DiscoverViewState>
      mockDiscoverViewProvider;
  // late MockFlutterLocalization mockFlutterLocalization;

  setUp(() {
    mockDiscoverViewProvider =
        StateNotifierProvider<DiscoverViewStateNotifier, DiscoverViewState>(
            (ref) {
      return DiscoverViewStateNotifier();
    });
  });

  group('Discover View Test', () {
    patrolWidgetTest('discover view ...', ($) async {
      // when(mockDiscoverViewProvider.initChannel())
      //     .thenAnswer((realInvocation) async {});
      // when(mockDiscoverViewProvider.loadChannel())
      //     .thenAnswer((realInvocation) async {});
      // final mockDiscoverViewProvider =
      //     StateNotifierProvider<MockDiscoverViewStateNotifier, DiscoverViewState>(
      //         (ref) {
      //   return MockDiscoverViewStateNotifier();
      // });

      final app = TranslationProvider(
        child: ProviderScope(
          observers: const [],
          overrides: [
            discoverViewProvider.overrideWithProvider(mockDiscoverViewProvider),
            // )
            // .overrideWith((ref) => mockDiscoverViewStateNotifier),
          ],
          child: MaterialApp.router(
            routerConfig: routerHelper,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            builder: (context, child) {
              SizingHelper.getSize(context);
              return ConnectivityBuilder(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (currentFocus.hasPrimaryFocus) return;
                    currentFocus.unfocus();
                    currentFocus.focusedChild?.unfocus();
                  },
                  child: child!,
                ),
              );
            },
          ),
        ),
      );

      await $.pumpWidget(app);
      await $.pumpAndTrySettle();
      await $(IconButton).first.waitUntilVisible().then((value) => value.tap());
    });
  });
}
