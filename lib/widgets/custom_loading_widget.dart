import 'dart:convert';

import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_gif_widget.dart';

class CustomLoadingWidget extends StatefulWidget {
  const CustomLoadingWidget({super.key});

  static const directoryPath = 'assets/images/bgm';
  static const filePrefix = 'gif_';

  @override
  State<CustomLoadingWidget> createState() => _CustomLoadingWidgetState();
}

class _CustomLoadingWidgetState extends State<CustomLoadingWidget> {
  List<dynamic> fileList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var assets = await rootBundle.loadString('AssetManifest.json');
      Map json = jsonDecode(assets);
      fileList = json.keys
          .where((element) => '$element'.startsWith(
              '${CustomLoadingWidget.directoryPath}/${CustomLoadingWidget.filePrefix}'))
          .toList();
      if (!mounted || fileList.isEmpty) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fileList.isEmpty) {
      return Container(
        color: Colors.black,
        height: 100.h,
        width: 100.w,
      );
    }
    return CustomGifWidget(
      directoryPath: CustomLoadingWidget.directoryPath,
      fileCount: fileList.length,
      filePrefix: CustomLoadingWidget.filePrefix,
    );
  }
}
