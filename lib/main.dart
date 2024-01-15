import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:alt_bangumi/screens/home/widgets/connectivity_builder.dart';
import 'package:flutter/material.dart';
import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/helpers/router_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'helpers/sizing_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(TranslationProvider(child: const ProviderScope(child: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int languageIndex = LanguageEnum.english.index;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Alt Bangumi',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.pink,
        primaryColorLight: ColorConstant.themeColor,
        primaryColorDark: ColorConstant.themeColor,
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
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: ColorConstant.themeColor),
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: ColorConstant.themeColor,
        ),
        indicatorColor: ColorConstant.themeColor,
        primaryColor: ColorConstant.themeColor,
        textTheme: const TextTheme(),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: ColorConstant.themeColor),
      ),
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
      routerConfig: routerHelper,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
