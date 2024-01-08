// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:alt_bangumi/helpers/router_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/providers/discover_view_provider.dart';
import 'package:alt_bangumi/screens/home/widgets/connectivity_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alt_bangumi/main.dart';
import 'package:mockito/mockito.dart';
import 'package:patrol_finders/patrol_finders.dart';

class MockDiscoverViewStateNotifier extends Notifier<DiscoverViewState>
    with Mock
    implements DiscoverViewStateNotifier {}

void main() {
  late StateNotifierProvider<DiscoverViewStateNotifier, DiscoverViewState>
      mockDiscoverViewProvider;

  setUpAll(() {
    mockDiscoverViewProvider =
        StateNotifierProvider<DiscoverViewStateNotifier, DiscoverViewState>(
            (ref) {
      return DiscoverViewStateNotifier();
    });
  });

  patrolWidgetTest('Widget Testing...', ($) async {
    final app = ProviderScope(
      observers: const [],
      overrides: [
        discoverViewProvider.overrideWithProvider(mockDiscoverViewProvider),
        // )
        // .overrideWith((ref) => mockDiscoverViewStateNotifier),
      ],
      child: MaterialApp.router(
        routerConfig: routerHelper,
        // supportedLocales: mockFlutterLocalization.supportedLocales,
        // localizationsDelegates: mockFlutterLocalization.localizationsDelegates,
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
    );

    await $.pumpWidget(app);
    await $.pumpAndSettle();
  });
}
