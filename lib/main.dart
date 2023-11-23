import 'dart:io';

import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/helpers/router_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';

import 'helpers/sizing_helper.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    localization.init(
      mapLocales: [
        const MapLocale('en', TextConstant.EN),
        const MapLocale('zh-cn', TextConstant.ZH_CN),
        const MapLocale('zh-tw', TextConstant.ZH_TW),
        // TODO locale ja
        // const MapLocale('ja', TextConstant.JA),
      ],
      initLanguageCode: 'zh-cn',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  // the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {
      // whenever your initialization is completed, remove the splash screen
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      maximumSize: const Size.fromWidth(600),
      backgroundColor: Colors.grey[200],
      enabled: kIsWeb || !Platform.isAndroid && !Platform.isIOS,
      builder: (context) {
        return MaterialApp.router(
          title: 'Alt Bangumi',
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.pink,
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(fontSize: 12.0, color: Colors.black),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedItemColor: ColorConstant.themeColor,
            ),
            iconButtonTheme: IconButtonThemeData(
              style: IconButton.styleFrom(
                iconSize: 20.0,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            textSelectionTheme: const TextSelectionThemeData(
                cursorColor: ColorConstant.themeColor),
            inputDecorationTheme: const InputDecorationTheme(
              focusColor: ColorConstant.themeColor,
            ),
            indicatorColor: ColorConstant.themeColor,
            primaryColor: ColorConstant.themeColor,
            textTheme: const TextTheme(),
            progressIndicatorTheme: const ProgressIndicatorThemeData(
                color: ColorConstant.themeColor),
          ),
          builder: (context, child) {
            SizingHelper.getSize(context);
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (currentFocus.hasPrimaryFocus) return;
                currentFocus.unfocus();
                currentFocus.focusedChild?.unfocus();
              },
              child: child!,
            );
          },
          routerConfig: routerHelper,
          supportedLocales: localization.supportedLocales,
          localizationsDelegates: localization.localizationsDelegates,
        );
      },
    );
  }
}
