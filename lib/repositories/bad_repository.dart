import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/helpers/http_helper.dart';
import 'package:alt_bangumi/models/browser_rank_model.dart';
import 'package:alt_bangumi/models/subject_model/tag_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;
import 'package:intl/intl.dart';

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
      ScreenSubjectOption subjectOption) async {
    final html = await HttpHelper.getHtmlFromUrl(
        '${HttpConstant.host}/${subjectOption.api}');
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

  static Future<dynamic> fetchList({
    required ScreenSubjectOption subjectOption,
    required int page,
    Map<String, dynamic> pagination = const {'pageTotal': 0}, // page total?
  }) async {
    final currentDate = DateFormat('yyyy-MM').format(DateTime.now());
    final raw = await HttpHelper.getHtmlFromUrl(
        'https://bgm.tv/${subjectOption.name}/browser/airtime/$currentDate?sort=rank&page=$page');
    final result = _analyseList(raw, page, pagination);

    // final stateKey = '$type|$airtime|$sort';
    final data = {
      'list': result?['tag'],
      'pagination': {
        'page': page,
        'pageTotal': int.tryParse('${result?['pageTotal']}'),
      },
      '_loaded': DateTime.now().millisecondsSinceEpoch,
    };
    return data;
  }

  static Future<List<BrowserRankModel>?> fetchRank({
    required ScreenSubjectOption subjectOption,
    required SortOption sortOption,
    required int page,
    required AnimeTypeOption? animeTypeOption,
    required BookTypeOption? bookTypeOption,
    required RealTypeOption? realTypeOption,
    required GameTypeOption? gameTypeOption,
    required int? year,
    required int? month,
  }) async {
    final type = subjectOption.filterUrl(
      animeTypeOption: animeTypeOption,
      bookTypeOption: bookTypeOption,
      gameTypeOption: gameTypeOption,
      realTypeOption: realTypeOption,
    );
    final url = '${HttpConstant.host}/${subjectOption.name}/browser'
        '${type ?? ''}'
        '${_airtimeString(year, month)}'
        '?sort=${sortOption.name}&page=$page';
    final html = await HttpHelper.getHtmlFromUrl(url);
    return _analyseSubject(html);
  }

  static Future<List<TagModel>?> fetchTags({
    required ScreenSubjectOption subjectOption,
    required String? filter,
    required int page,
  }) async {
    final isFiltered = filter != null && filter.isNotEmpty;
    final url = '${HttpConstant.host}/'
        '${isFiltered ? 'search' : subjectOption.name}'
        '/tag'
        '${isFiltered ? '/${subjectOption.name}/$filter' : ''}'
        '?page=$page';
    final html = await HttpHelper.getHtmlFromUrl(url);
    return _analyseTag(html);
  }

  static Future<List<BrowserRankModel>?> fetchSubjectsByTag({
    required ScreenSubjectOption subjectOption,
    required SortOption sortOption,
    required String text,
    required int? page,
    required int? year,
    required int? month,
  }) async {
    final url = '${HttpConstant.host}/${subjectOption.name}/tag/$text'
        '${_airtimeString(year, month)}'
        '?sort=${sortOption.name}&page=$page';
    final html = await HttpHelper.getHtmlFromUrl(url);
    return _analyseSubject(html);
    // return _analyseSubjectByTag(html);
  }

  static String _airtimeString(
    int? year,
    int? month,
  ) {
    if (year == null) return '';
    return '/airtime/$year' '${month == null ? '' : '-$month'}';
  }

  static List<BrowserRankModel>? _analyseSubject(String html) {
    // Define a regular expression pattern to match content within <li> tags under the specified <ul> tag
    final ulPattern = RegExp(
        r'<ul\s+id="browserItemList"\s+class="browserFull">(.*?)<\/ul>',
        dotAll: true);
    final liPattern = RegExp(r'<li(?:\s+.*?)*?>(.*?)<\/li>', dotAll: true);

    // Find the <ul> match in the input string
    final ulMatch = ulPattern.firstMatch(html);

    if (ulMatch == null) return null;

    // Extract content within <ul> tag
    String? ulContent = ulMatch.group(1);

    // Find all matches of <li> tags within the <ul> content
    Iterable<Match>? liMatches =
        ulContent == null ? null : liPattern.allMatches(ulContent);

    // Extract and print the matched content
    List<String> extractedValues = [];
    if (liMatches?.isEmpty ?? true) return [];
    for (Match liMatch in liMatches!) {
      String? liContent =
          liMatch.group(1); // Group 1 contains the content within <li> tags
      if (liContent != null) {
        extractedValues.add(liContent);
      }
    }

    final htmlDocument =
        extractedValues.map((e) => html_parser.parse(e)).toList();

    final list = <BrowserRankModel>[];

    for (final each in htmlDocument) {
      final idClass =
          each.body?.getElementsByClassName('subjectCover cover ll');
      final id = (idClass?.isNotEmpty ?? false)
          ? idClass?.first.attributes['href']
          : null;
      final imgTag = each.body?.getElementsByTagName('img');
      final cover = (imgTag?.isNotEmpty ?? false)
          ? imgTag?.first.attributes['src']
          : null;
      final nameCnClass = each.body
          ?.getElementsByTagName('a')
          .firstWhereOrNull((element) => element.className == 'l');
      final nameCn = nameCnClass?.text;
      final nameTag = each.body
          ?.getElementsByTagName('small')
          .firstWhereOrNull((element) => element.className == 'grey');
      final name = (nameTag == null) ? null : nameTag.text;
      final tipClass = each.body?.getElementsByClassName('info tip');
      final tip =
          (tipClass?.isNotEmpty ?? false) ? tipClass?.first.text.trim() : null;
      final scoreClass = each.body?.getElementsByClassName('fade');
      final score =
          (scoreClass?.isNotEmpty ?? false) ? scoreClass?.first.text : null;
      final totalClass = each.body?.getElementsByClassName('tip_j');
      final total =
          (totalClass?.isNotEmpty ?? false) ? totalClass?.first.text : null;
      final rankClass = each.body?.getElementsByClassName('rank');
      final rank =
          (rankClass?.isNotEmpty ?? false) ? rankClass?.first.text : null;
      final hyperlinkList = each.body?.getElementsByTagName('a');
      final collected = hyperlinkList
          ?.any((element) => element.attributes['title'] == '修改收藏');

      final data = BrowserRankModel(
        id: id,
        cover: cover,
        name: name,
        nameCn: nameCn,
        tip: tip,
        score: score,
        total: total,
        rank: rank,
        collected: collected,
      );

      list.add(data);
    }
    return list;
  }

  static List<TagModel>? _analyseTag(String html) {
    // Define a regular expression pattern to match content within <li> tags under the specified <ul> tag
    final ulPattern =
        RegExp(r'<div id="tagList">(.*?)<hr class="board"', dotAll: true);

    // Find the <ul> match in the input string
    final ulMatch = ulPattern.firstMatch(html);

    if (ulMatch == null) return null;

    // Extract content within <ul> tag
    String? ulContent = ulMatch.group(1);

    final htmlDocument = html_parser.parse(ulContent);
    final anchorElements = htmlDocument.querySelectorAll('a');
    final smallElements = htmlDocument.querySelectorAll('small');

    if (anchorElements.length != smallElements.length) return null;

    final List<TagModel> tagList = [];
    RegExp regexForBrackets = RegExp(r'\((.*?)\)');
    for (var i = 0; i < anchorElements.length; i++) {
      final href = anchorElements[i].attributes['href'];
      final countInBrackets = smallElements[i].text;
      final splittedHref = href?.split('/');
      final name =
          splittedHref?.isNotEmpty ?? false ? splittedHref?.last : null;
      final count =
          regexForBrackets.firstMatch(countInBrackets)?.group(1) ?? '';
      tagList.add(TagModel(
          name: Uri.decodeFull(name ?? ''), count: int.tryParse(count)));
    }
    return tagList;
  }
}

Map<String, dynamic>? _analyseList(
    String raw, int page, Map<String, dynamic> pagination) {
  final html = _getHTMLTrim(raw);

  // -------------------- 分析HTML --------------------
  List? node;
  final tag = <Map<String, dynamic>>[];
  // var pageTotal = pagination['pageTotal'] ?? 0;

  // 条目
  final matchHTML = RegExp(
    r'<ul id="browserItemList" class="browserFull"><\/ul>\s*<div class="clearit">',
  ).firstMatch(html);

  if (matchHTML != null) {
    // 总页数
    if (page == 1) {
      // final pageHTML = RegExp(
      //   r'<span class="p_edge">\(&nbsp;\d+&nbsp;/&nbsp;(\d+)&nbsp;\)<\/span>'
      //   r'|<a href="\?.*page=\d+" class="p">(\d+)<\/a><a href="\?.*page=2" class="p">&rsaquo;&rsaquo;<\/a>',
      // ).firstMatch(html);

      // pageTotal = pageHTML != null
      // ? int.parse(pageHTML.group(1) ?? pageHTML.group(2)!)
      // : 1;
    }

    final tree = _convertHTMLToTree(matchHTML.group(1)!);

    for (var item in tree!.children) {
      final children = item.children;

      // 条目Id
      node = _findTreeNode(children, 'a|href');
      final id = node != null ? node[0].attrs['href'] : '';

      // 封面
      node = _findTreeNode(children, 'a > span > img') ??
          _findTreeNode(children, 'a > noscript > img');
      var cover = node != null ? node[0].attrs['src'] : '';
      if (cover == '/img/info_only.png') {
        cover = '';
      }

      // 标题
      node = _findTreeNode(children, 'div > h3 > small');
      final name = node != null ? node[0].text[0] : '';

      node = _findTreeNode(children, 'div > h3 > a');
      final nameCn = node != null ? node[0].text[0] : '';

      // 描述
      node = _findTreeNode(children, 'div > p|class=info tip');
      final tip = node != null ? node[0].text[0] : '';

      // 分数
      node = _findTreeNode(children, 'div > p > small|class=fade');
      final score = node != null ? node[0].text[0] : '';

      node = _findTreeNode(children, 'div > p > span|class=tip_j');
      final total = node != null ? node[0].text[0] : '';

      // 排名
      node = _findTreeNode(children, 'div > span|class=rank');
      final rank = node != null ? node[0].text[0] : '';

      // 收藏状态
      node = _findTreeNode(children, 'div > div > p > a|title=修改收藏');
      final collected = node != null;

      final data = {
        'id': id,
        'cover': cover,
        'name': name,
        'nameCn': nameCn,
        'tip': tip,
        'score': score,
        'total': total,
        'rank': rank,
        'collected': collected,
      };

      tag.add(Map<String, dynamic>.from(data));
    }
  }
  return null;
}

// HTMLTrim function
String _getHTMLTrim(String str, [bool deep = false]) {
  String removeCF(String input) {
    return input
        .replaceAllMapped(
          RegExp(
              r'<script[^>]*>[\s\S](?!<script>)*?</script>|<noscript[^>]*>[\s\S](?!<script>)*?</noscript>|style="display:none;visibility:hidden;"/'),
          (match) => '',
        )
        .replaceAll(RegExp(r'data-cfsrc'), 'src');
  }

  return deep
      ? removeCF(str)
          .replaceAll(RegExp(r'<!--.*?-->', multiLine: true), '')
          .replaceAll(RegExp(r'/\*.*?\*/', multiLine: true), '')
          .replaceAll(RegExp(r'[ ]+<', multiLine: true), '<')
          .replaceAll(RegExp(r'\n+|\s\s\s*|\t', multiLine: true), '')
          .replaceAll(RegExp(r'"class="', multiLine: true), '" class="')
          .replaceAll(RegExp(r'> <', multiLine: true), '><')
      : removeCF(str)
          .replaceAll(RegExp(r'\n+|\s\s\s*|\t', multiLine: true), '')
          .replaceAll(RegExp(r'"class="', multiLine: true), '" class="')
          .replaceAll(RegExp(r'> <', multiLine: true), '><');
}

// HTMLToTree function
class TreeNode {
  String tag;
  Map<String, dynamic> attrs;
  List<dynamic> text;
  List<TreeNode> children;
  String? cmd;
  TreeNode? parent;

  TreeNode(this.tag, this.attrs, this.text, this.children,
      {this.cmd, this.parent});
}

TreeNode? _convertHTMLToTree(String html, {bool cmd = true}) {
  final tree = TreeNode('root', {}, [], []);
  if (cmd) tree.cmd = 'root';

  // TreeNode ref = tree;
  final element = html_parser.parse(html).body;
  if (element == null) return null;
  final attrs = element.attributes;
  final text =
      element.nodes.whereType<Text>().map((node) => node.text).toList();
  final children = element.nodes
      .whereType<Element>()
      .map((child) => _createTreeNode(child))
      .toList();

  Map<String, dynamic> attrMap = {};
  attrs.forEach((key, value) {
    attrMap.addAll({'$key', value} as Map<String, dynamic>);
  });
  return TreeNode(
    element.localName ?? '',
    attrMap,
    text,
    children,
  );
}

TreeNode _createTreeNode(Element element) {
  final attrs = element.attributes;
  final text =
      element.nodes.whereType<Text>().map((node) => node.text).toList();
  final children = element.nodes
      .whereType<Element>()
      .map((child) => _createTreeNode(child))
      .toList();

  final Map<String, dynamic> attrMap = {};
  attrs.forEach((key, value) {
    attrMap.addAll({'$key', value} as Map<String, dynamic>);
  });

  return TreeNode(
    '${element.localName}',
    attrMap,
    text,
    children,
  );
}

// findTreeNode function
List<dynamic>? _findTreeNode(List<dynamic> children,
    [String cmd = '', defaultValue]) {
  if (cmd.isEmpty) return children;

  const split = ' > ';
  final tags = cmd.split(split);
  final tag = tags.removeAt(0);
  final find = children.where((item) {
    final temp = tag.split('|');
    final tag0 = temp[0];
    final attr = temp.length > 1 ? temp[1] : '';

    if (attr.isNotEmpty) {
      final attrs = attr.split('&');
      var match = true;
      for (var attrTemp in attrs) {
        if (attrTemp.contains('~')) {
          final temp = attrTemp.split('~');
          final attr = temp[0];
          final value = temp[1];
          if (value.isNotEmpty) {
            match = match &&
                item.tag == tag0 &&
                item.attrs[attr]?.contains(value) == true;
          } else if (attr.isNotEmpty) {
            match = match && item.tag == tag0 && item.attrs[attr] != null;
          }
        } else {
          final temp = attrTemp.split('=');
          final attr = temp[0];
          final value = temp[1];
          if (value.isNotEmpty) {
            match = match && item.tag == tag0 && item.attrs[attr] == value;
          } else if (attr.isNotEmpty) {
            if (attr == 'text') {
              match = match && item.tag == tag0 && item.text.isNotEmpty;
            } else {
              match = match && item.tag == tag0 && item.attrs[attr] != null;
            }
          }
        }
      }
      return match;
    }
    return item.tag == tag0;
  }).toList();

  if (find.isEmpty) {
    return defaultValue;
  }

  if (tags.isEmpty) {
    return find;
  }

  final find0 = <dynamic>[];
  for (var item in find) {
    find0.addAll(_findTreeNode(item.children, tags.join(split)) ?? []);
  }

  if (find0.isEmpty) {
    return defaultValue;
  }

  return find0;
}
