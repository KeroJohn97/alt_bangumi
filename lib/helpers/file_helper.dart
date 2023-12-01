import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  FileHelper._();

  static Future<Directory> getDefaultDestinationDirectory() async {
    final preferredDirectory =
        Directory('/storage/emulated/0/Pictures/Screenshots');

    return Platform.isAndroid
        ? preferredDirectory.existsSync()
            ? preferredDirectory
            : await getApplicationDocumentsDirectory()
        : await getApplicationSupportDirectory();
  }
}
