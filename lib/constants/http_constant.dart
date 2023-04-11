class HttpConstant {
  static const host = '';

  // bgm api 域名
  static const String apiHost = 'https://api.bgm.tv';
  // bgm 新 api 域名
  static const String apiV0 = '$apiHost/v0';
  // 瓷砖进度接口
  static String apiMosaicTile(String username, [String type = 'progress']) {
    return 'https://bangumi-mosaic-tile.aho.im/users/$username/timelines/$type.json';
  }

  // oauth 获取 access_token
  String apiAccessToken() => '$host/oauth/access_token';

  // 用户信息
  String apiUserInfo(String userId) => '$apiHost/user/$userId';

  // [POST] 用户收藏
  //
  // @query *cat 收藏类型: watching = 在看的动画与三次元条目 all_watching = 在看的动画三次元与书籍条目
  // @query ids 收藏条目ID: 批量查询收藏状态，将条目 ID 以半角逗号分隔，如 1,2,4,6
  // @query responseGroup 'medium' | 'small'
  String apiUserCollection(String userId) => '$apiHost/user/$userId/collection';

  // 用户收藏概览
  //
  // @query  max_results 显示条数最多25
  String apiUserCollections(String subjectType, String userId) =>
      '$apiHost/user/$userId/collections/$subjectType';

  // 用户收藏统计
  String apiUserCollectionsStatus(String userId) =>
      '$apiHost/user/$userId/collections/status';

  // 用户收视进度
  //
  // @query subject_id 条目ID 获取指定条目收视进度
  String apiUserProgress(String userId) => '$apiHost/user/$userId/progress';

  // 条目信息
  //
  // @query responseGroup 返回数据大小: small, medium, large
  String apiSubject(String subjectId) => '$apiHost/subject/$subjectId';

  // 章节数据
  String apiSubjectEp(String subjectId) => '$apiHost/subject/$subjectId/ep';

  // 每日放送
  String apiCalendar() => '$apiHost/calendar';

  // 条目搜索
  //
  // @query type 条目类型: 1 = book, 2 = anime, 3 = music, 4 = game, 6 = real
  // @query start 开始条数
  // @query max_results 每页条数, 最多25
  String apiSearch(String keywords) => '$apiHost/search/subject/$keywords';

  // [GET, POST] 更新收视进度
  // @param {*} id 章节ID
  // @param {*} status 收视类型
  //
  // @query ep_id 使用 POST 批量更新 将章节以半角逗号分隔, 如 3697,3698,3699
  //         请求时 URL 中的 ep_id 为最后一个章节ID
  static String apiEpStatus(String id, String status) =>
      "$apiHost/ep/$id/status/$status";

  // [POST] 批量更新收视进度
  // @param {*} subjectId
  //
  // @query watched_eps 如看到 123 话则 POST 123; 书籍条目传 watched_eps 与 watched_vols 至少其一
  // @query watched_vols 如看到第 3 卷则 POST 3, 仅对书籍条目有效
  String apiSubjectUpdateWatched(String subjectId) =>
      "$apiHost/subject/$subjectId/update/watched_eps";

  // 获取指定条目收藏信息
  String apiCollection(String subjectId) => "$apiHost/collection/$subjectId";

  // 管理收藏
  // @param {*} subjectId
  // @param {*} action  收藏动作: create = 添加收藏, update = 更新收藏; 可以统一使用 update, 系统会自动判断需要新建还是更新收藏
  //
  // @query *status 章节状态: watched, queue, drop, remove
  // @query tags    标签 以半角空格分割
  // @query comment 简评
  // @query rating  评分 1-10
  // @query privacy 收藏隐私: 0 = 公开, 1 = 私密
  static String apiCollectionAction(String subjectId, String action) =>
      "$apiHost/collection/$subjectId/$action";

  // v0 api: 条目封面
  static String apiCover(String subjectId, {String type = 'common'}) =>
      "$apiHost/v0/subjects/$subjectId/image?type=$type";

  // v0 api: 用户头像
  static String apiAvatar(String username) =>
      "$apiHost/v0/users/$username/avatar?type=large";

  // v0 api: 角色图
  static String apiMonoCover(String monoId,
          {String type = 'medium', String monoType = 'characters'}) =>
      "$apiHost/v0/$monoType/$monoId/image?type=$type";

  // v0 api: 获取对应用户的收藏
  static String apiUsersSubjectCollection(String username, String subjectId) =>
      "$apiHost/v0/users/$username/collections/$subjectId";

  // 随机 pixiv
  String apiSetu({int num = 20}) =>
      "https://api.lolicon.app/setu/v2?r18=0&num=$num&size=small&dateAfter=1609459200000";

  // 随机二次元头像
  String apiRandomAvatar = "https://api.yimian.xyz/img?type=head";

  // 圣地巡游
  String apiAnitabi(String subjectId) =>
      "https://api.anitabi.cn/bangumi/$subjectId/lite";

  // 帖子楼层表情
  String apiTopicCommentLike(
          int type, int mainId, int id, String value, String gh) =>
      "$host/like?type=$type&main_id=$mainId&id=$id&value=$value&gh=$gh&ajax=1";

  // 每日放送
  // ${HOST_DOGE}/bangumi-onair/calendar.json
  static String cdnOnair =
      'https://cdn.jsdelivr.net/gh/ekibot/bangumi-onair/calendar.json?ts=${DateTime.now().millisecondsSinceEpoch}';

  // 单集数据源, https://github.com/ekibot/bangumi-onair
  static String cdnEps(String subjectId) {
    // Repo 的目录显示文件数量有限, 所以根据 subjectId 每 100 划分为一个目录
    // The directory of the 'Repo' shows a limited number of files, so it is divided into directories based on 'subjectId' every 100
    return 'https://cdn.jsdelivr.net/gh/ekibot/bangumi-onair/onair/${(int.parse(subjectId) / 100).floor()}/$subjectId.json';
  }
}
