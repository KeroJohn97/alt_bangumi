import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'http_helper.dart';

class FileHelper {
  FileHelper._();

  static Future<Directory> getDefaultDestinationDirectory() async {
    final preferredDirectory = Directory('/storage/emulated/0/Pictures');

    return Platform.isAndroid
        ? preferredDirectory.existsSync()
            ? preferredDirectory
            : await getApplicationDocumentsDirectory()
        : await getApplicationSupportDirectory();
  }

  static Future<File?> saveImageProvider(ImageProvider imageProvider) async {
    const timeoutInMilliseconds = 10000;
    const loopDelay = Duration(milliseconds: 1000);

    File? savedFile;
    int attemptCount = 0;
    final maxAttempts = timeoutInMilliseconds ~/ loopDelay.inMilliseconds;
    final appStorage = await getDefaultDestinationDirectory();

    imageProvider.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) async {
          ByteData? byteData =
              await image.image.toByteData(format: ImageByteFormat.png);
          if (byteData == null) return;
          savedFile = File('${appStorage.path}/${imageProvider.hashCode}.png');
          savedFile?.writeAsBytes(byteData.buffer.asUint8List());
        },
      ),
    );

    await Future.doWhile(() async {
      await Future.delayed(loopDelay);
      attemptCount++;

      if (attemptCount >= maxAttempts) return false;
      return savedFile == null;
    });

    return savedFile;
  }

  static Future<File?> downloadFile(
      {required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await _createFile(url, name);
    return file;
  }

  static Future<File?> _createFile(String url, String name) async {
    final appStorage = await getDefaultDestinationDirectory();
    try {
      final file = File('${appStorage.path}/$name');
      final response =
          await HttpHelper.get(url).timeout(const Duration(seconds: 30));
      if (response.statusCode != 200) return null;
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.bodyBytes);
      await raf.close();
      return file;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
