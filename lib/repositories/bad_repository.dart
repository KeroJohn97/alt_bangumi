import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/helpers/http_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;

import '../models/channel_model/channel_model.dart';

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

  static Future<ChannelModel> fetchChannel(
      SearchScreenSubjectOption subjectOption) async {
    final html = await HttpHelper.getHtmlFromUrl(
        '${HttpConstant.host}/${subjectOption.name}');
    final htmlDocument = html_parser.parse(html);

    Map<String, dynamic> safeObject(Map<String, dynamic>? obj) {
      return obj ?? {};
    }

    List<Map<String, dynamic>> mapTableRows(
        html_dom.Element table,
        String selector,
        Map<String, dynamic> Function(int, html_dom.Element) mapFunction) {
      return table
          .querySelectorAll(selector)
          .map((element) => mapFunction(
              table.querySelectorAll(selector).indexOf(element), element))
          .toList();
    }

    String getCoverMedium(String? src) {
      // Implement your logic to get the medium cover
      // This is a placeholder, you need to replace it with your actual logic
      return src ?? "";
    }

    String htmlDecode(String input) {
      // Implement your HTML decoding logic
      // This is a placeholder, you need to replace it with your actual logic
      return input;
    }

    List<Map<String, dynamic>> rankTopList = mapTableRows(
        htmlDocument.body!.querySelector('table.mediumImageChart')!, 'tr',
        (index, element) {
      final a = element.querySelector('span.subject a')!;
      return safeObject({
        'id': a.attributes['href']!.replaceFirst('/subject/', ''),
        'name': a.text.trim(),
        'cover':
            getCoverMedium(element.querySelector('img')!.attributes['src']),
        'follow': element.querySelector('div.chartbar')!.text.trim(),
      });
    });

    List<Map<String, dynamic>> rankList =
        mapTableRows(htmlDocument.body!.querySelector('div#chl_subitem')!, 'li',
            (index, element) {
      final a = element.querySelector('strong a')!;
      return safeObject({
        'id': a.attributes['href']!.replaceFirst('/subject/', ''),
        'name': a.text.trim(),
        'cover':
            getCoverMedium(element.querySelector('img')!.attributes['src']),
        'follow': element.querySelector('small.feed')!.text.trim(),
      });
    });

    final friendsListTable = htmlDocument.body!.querySelector('ul.coversSmall');
    List<Map<String, dynamic>>? friendsList = friendsListTable == null
        ? null
        : mapTableRows(friendsListTable, '> li', (index, element) {
            final subject = element.querySelector('> a')!;
            final user = element.querySelector('a.l')!;
            return safeObject({
              'id': subject.attributes['href']!.replaceFirst('/subject/', ''),
              'name': subject.attributes['title'],
              'cover': subject.querySelector('img')!.attributes['src'],
              'userId': user.attributes['href']!.replaceFirst('/user/', ''),
              'userName': user.text.trim(),
              'action':
                  element.querySelector('p.info')!.text.trim().split(' ')[1],
            });
          });

    List<String> tagsList = htmlDocument.body!
        .querySelectorAll('a.level8')
        .map((element) => element.text.trim())
        .toList();

    List<Map<String, dynamic>> discussList = mapTableRows(
        htmlDocument.body!.querySelector('table.topic_list')!, 'tr',
        (index, element) {
      if (index == 0) return {};
      final a = element.querySelector('> td > a.l')!;
      final subject = element.querySelector('> td > small.feed > a')!;
      final user = element.querySelector('> td[align=right] > a')!;
      return safeObject({
        'id': a.attributes['href']!.replaceFirst('/subject/topic', 'subject'),
        'title': htmlDecode(a.text.trim()),
        'replies': element
            .querySelector('> td > a.l + small.grey')!
            .text
            .trim()
            .replaceAll(RegExp(r'\(|\)'), ''),
        'subjectId': subject.attributes['href']!.replaceFirst('/subject/', ''),
        'subjectName': subject.text.trim().replaceAll(RegExp(r'"'), ''),
        'userId': user.attributes['href']!.replaceFirst('/user/', ''),
        'userName': user.text.trim(),
        'time': element.querySelector('> td[align=right] > small')!.text.trim(),
      });
    }).where((item) => item['id'] != null).toList();

    List<Map<String, dynamic>> blogList = mapTableRows(
        htmlDocument.body!.querySelector('div#news_list')!, '> div.item',
        (index, element) {
      final a = element.querySelector('h2.title a')!;
      final times = element.querySelector('div.time')!.text.trim().split('/ ');
      return safeObject({
        'id': a.attributes['href']!.replaceFirst('/blog/', ''),
        'title': a.text.trim(),
        'cover': element
            .querySelector('span.pictureFrameGroup img')!
            .attributes['src'],
        'time': times[times.length - 1].replaceAll('\n', ''),
        'replies': element
            .querySelector('div.content .blue')!
            .text
            .trim()
            .replaceAll(RegExp(r'\(|\)'), ''),
        'content':
            '${element.querySelector('div.content')!.text.trim().split('...')[0]}...',
        'username': element.querySelector('div.time small.blue a')?.text.trim(),
        'subject': element.querySelector('div.time small.grey a')?.text.trim(),
        'tags': '',
      });
    });

    return ChannelModel.fromMap(
      {
        'rankTop': rankTopList,
        'rank': rankList,
        'friends': friendsList,
        'tags': tagsList,
        'discuss': discussList,
        'blog': blogList,
      },
    );
  }
}
