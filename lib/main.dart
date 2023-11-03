import 'package:flutter/material.dart';
import 'package:flutter_bangumi/constants/color_constant.dart';
import 'package:flutter_bangumi/screens/home/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'helpers/sizing_helper.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bangumi',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedItemColor: ColorConstant.themeColor,
          )),
      home: Builder(builder: (context) {
        SizingHelper.getSize(context);
        return const HomeScreen();
      }),
    );
  }
}
