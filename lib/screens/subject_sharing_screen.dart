import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/helpers/file_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class SubjectSharingScreen extends StatefulWidget {
  final String id;
  final String name;
  final String summary;
  final String shortTag;
  final ImageProvider imageProvider;
  const SubjectSharingScreen({
    super.key,
    required this.id,
    required this.name,
    required this.summary,
    required this.shortTag,
    required this.imageProvider,
  });

  static const route = '/screenshot';
  static const idKey = 'id_key';
  static const nameKey = 'name_key';
  static const summaryKey = 'summary_key';
  static const shortTagKey = 'short_tag_key';
  static const imageProviderKey = 'image_provider_key';

  @override
  State<SubjectSharingScreen> createState() => _SubjectSharingScreenState();
}

class _SubjectSharingScreenState extends State<SubjectSharingScreen> {
  late final GlobalKey _globalKey;
  late final ValueNotifier<bool> _disabledValue;
  late final ValueNotifier<bool> _darkThemeValue;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
    _disabledValue = ValueNotifier(false);
    _darkThemeValue = ValueNotifier(false);
  }

  _enable() => _disabledValue.value = false;

  _screenShot() async {
    _disabledValue.value = true;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final storagePermission = await CommonHelper.getStoragePermission(context);
    if (storagePermission == false) {
      if (!mounted) return _enable();
      CommonHelper.showSnackBar(
        context: context,
        text: TextConstant.pleaseGrantStoragePermission.getString(context),
      );
      return _enable();
    }
    if (!mounted) return _enable();
    CommonHelper.showSnackBar(
      context: context,
      text: TextConstant.fileIsBeingSaved.getString(context),
    );
    RenderObject? boundary = _globalKey.currentContext?.findRenderObject();
    if (boundary == null || boundary is! RenderRepaintBoundary) {
      return _enable();
    }
    ui.Image image = await boundary.toImage(pixelRatio: devicePixelRatio);
    final directory = await FileHelper.getDefaultDestinationDirectory();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return _enable();
    Uint8List pngBytes = byteData.buffer.asUint8List();
    File imgFile = File(
        '${directory.path}/Screenshot_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.png');
    final result = await imgFile.writeAsBytes(pngBytes);

    await Share.shareXFiles([XFile(result.path)]);
    if (!mounted) return _enable();
    CommonHelper.showSnackBar(
      context: context,
      text: context.formatString(
          TextConstant.theFileSaved.getString(context), [result.path]),
    );
    return _enable();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustomed(
        leading: const BackButton(color: Colors.black),
        titleWidget: Text(
          TextConstant.subjectSharing.getString(context),
          style: const TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        trailing: Row(
          children: [
            ValueListenableBuilder(
                valueListenable: _darkThemeValue,
                builder: (context, darkTheme, child) {
                  return IconButton(
                    onPressed: () => _darkThemeValue.value = !darkTheme,
                    icon: Icon(
                      darkTheme ? Icons.light_mode : Icons.dark_mode,
                      color: Colors.black,
                    ),
                  );
                }),
            ValueListenableBuilder(
                valueListenable: _disabledValue,
                builder: (context, disabled, child) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: disabled ? null : _screenShot,
                        icon: const Icon(
                          Icons.screenshot,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
        body: RepaintBoundary(
          key: _globalKey,
          child: ValueListenableBuilder(
              valueListenable: _darkThemeValue,
              builder: (context, darkTheme, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: darkTheme
                          ? [
                              Colors.black45,
                              Colors.black,
                            ]
                          : [
                              Colors.grey[500]!,
                              Colors.grey[200]!,
                            ],
                      begin:
                          darkTheme ? Alignment.topCenter : Alignment.topLeft,
                      end:
                          darkTheme ? Alignment.bottomCenter : Alignment.center,
                    ),
                  ),
                  child: SizedBox(
                    height: 100.h -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        CustomNetworkImageWidget(
                          height: 255.0,
                          width: 180.0,
                          radius: 12.0,
                          imageProvider: widget.imageProvider,
                          onTap: () {},
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: darkTheme ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            widget.summary,
                            style: TextStyle(
                              color: darkTheme ? Colors.white : Colors.black,
                            ),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: 100.w,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            widget.shortTag,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: darkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        const Spacer(),
                        AppBarCustomed(
                          backgroundColor:
                              darkTheme ? Colors.grey[850]! : Colors.white,
                          showDrawer: false,
                          title: 'bgm.tv',
                          textStyle: TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            color: darkTheme ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: QrImageView(
                              data: '${HttpConstant.host}/subject/${widget.id}',
                              backgroundColor: Colors.white,
                              errorCorrectionLevel: QrErrorCorrectLevel.H,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
