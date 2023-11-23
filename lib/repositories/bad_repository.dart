import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/helpers/http_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final badRepositoryProvider = Provider<BadRepository>((ref) {
  return BadRepository();
});

class BadRepository {
  static Future<String?> onlineUsers() async {
    final html = await HttpHelper.getHtmlFromUrl(HttpConstant.host);
    // Use the RegExp constructor to create a regular expression object
    // Use the raw string literal syntax to avoid escaping special characters
    final regex = RegExp(r'<small class="grey rr">online: (\d+)</small>');

    // Use the firstMatch method to find the first match of the regex in the html string
    // Use the group method to access the captured group by index (1 in this case)
    final result = regex.firstMatch(html)?.groupCount;
    // log('Html: $html');
    // log('Result: $result');
    return result.toString();
  }
}
