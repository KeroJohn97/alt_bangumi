/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 3
/// Strings: 516 (172 per locale)
///
/// Built on 2024-06-18 at 03:54 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	zhCn(languageCode: 'zh', countryCode: 'CN', build: _StringsZhCn.build),
	zhTw(languageCode: 'zh', countryCode: 'TW', build: _StringsZhTw.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	String get discover => 'Discover';
	String get timeCapsules => 'Time Capsules';
	String get favourite => 'Favourite';
	String get superUnfolded => 'Super Unfolded';
	String get timeMachine => 'Time Machine';
	String get ranking => 'Ranking';
	String get online => 'Online';
	String get anime => 'Anime';
	String get channel => 'Channel';
	String get entry => 'Entry';
	String get book => 'Book';
	String get music => 'Music';
	String get game => 'Game';
	String get film => 'Film';
	String get character => 'Character';
	String get user => 'User';
	String get accurate => 'Accurate';
	String get vague => 'Vague';
	String get search => 'Search';
	String get enquiry => 'Enquiry';
	String get viewInBrowser => 'View in Browser';
	String get clearHistory => 'Clear history';
	String get noHistory => 'No history';
	String get imageBroken => 'Image broken';
	String get enterKeywords => 'Enter keywords';
	String get nothingThere => 'It\'s like there\'s nothing there.';
	String get notAddedToFavourites => 'Not added to favourites';
	String get wished => 'Wished';
	String get watched => 'Watched';
	String get watching => 'Watching';
	String get onHold => 'On hold';
	String get dropped => 'Dropped';
	String get total => 'Total';
	String get chapter => 'Chapter';
	String get tag => 'Tag';
	String get summary => 'Summary';
	String get preview => 'Preview';
	String get more => 'More';
	String get details => 'Details';
	String get revise => 'Revise';
	String get rating => 'Rating';
	String get trend => 'Trend';
	String get perspective => 'Perspective';
	String get userRating => 'User rating';
	String get standardDeviation => 'Standard deviation';
	String get role => 'Role';
	String get productionStaff => 'Production Staff';
	String get associate => 'Associate';
	String get catalog => 'Catalog';
	String get log => 'Log';
	String get post => 'Post';
	String get dynamicString => 'Dynamic';
	String get comment => 'Comment';
	String get searchEntry => 'Search Entry';
	String get indexing => 'Indexing';
	String get today => 'Today';
	String get journal => 'Journal';
	String get ongoing => 'Ongoing';
	String get info => 'Info';
	String get stock => 'Stock';
	String get wiki => 'Wiki';
	String get almanac => 'Almanac';
	String get timeline => 'Timeline';
	String get netabare => 'netaba.re';
	String get localSMB => 'Local SMB';
	String get bilibiliSync => 'bilibili Sync';
	String get doubanSync => 'Douban Sync';
	String get backupCSV => 'Backup CSV';
	String get myCharacter => 'My Character';
	String get myCatalogue => 'My Catalogue';
	String get clipboard => 'Clipboard';
	String get loading => 'Loading';
	String get loadingWithDots => 'Loading ...';
	String get copyLink => 'Copy link';
	String get copyShare => 'Copy share';
	String get performance => 'Performance';
	String get whoHasCollectedIt => 'Who has collected it';
	String get recentlyParticipated => 'Recently participated';
	String get moreWorks => 'More works';
	String get producer => 'producer';
	String get mangaka => 'mangaka';
	String get artist => 'artist';
	String get seiyu => 'seiyu';
	String get writer => 'writer';
	String get illustrator => 'illustrator';
	String get actor => 'actor';
	String get pleaseGrantStoragePermission => 'Please grant storage permission to the app to save';
	String get fileIsBeingSaved => 'File is being saved';
	String get subjectSharing => 'Subject Sharing';
	String get invalidURL => 'Uh-oh! It looks like the URL is invalid';
	String get unknown => 'Unknown';
	String get unknownError => 'Oops! It seems like there might be a small hiccup';
	String get fileSaveTimeout => 'File save timeout';
	String get year => 'Year';
	String get month => 'Month';
	String get all => 'All';
	String get entire => 'Entire';
	String get type => 'Type';
	String get others => 'Others';
	String get tv => 'TV';
	String get web => 'WEB';
	String get ova => 'OVA';
	String get movie => 'Movie';
	String get comic => 'Comic';
	String get novel => 'Novel';
	String get illustration => 'Illustration';
	String get japaneseDrama => 'Japanese Drama';
	String get europeanNAmericanDramas => 'European & American Dramas';
	String get chineseDrama => 'Chinese Drama';
	String get pc => 'Personal Computer';
	String get ns => 'Nintendo Switch';
	String get ps5 => 'Play Station 5';
	String get ps4 => 'Play Station 4';
	String get psv => 'Play Station Vita';
	String get xboxSeries => 'Xbox Series X/S';
	String get xboxOne => 'Xbox One';
	String get wiiU => 'Wii U';
	String get ps3 => 'Play Station 3';
	String get xbox360 => 'Xbox 360';
	String get threeDS => 'Nintendo 3D Dual Screen';
	String get psp => 'Play Station Portable';
	String get wii => 'Wii';
	String get nds => 'Nintendo Dual Screen';
	String get ps2 => 'Play Station 2';
	String get xbox => 'Xbox';
	String get mac => 'Macbook';
	String get ps => 'Play Station 1';
	String get gba => 'Game Boy Advanced';
	String get gb => 'Game Boy';
	String get fc => 'Famicom';
	String get numberOfAnnotations => 'Number of Annotations';
	String get name => 'Name';
	String get date => 'Date';
	String get upcoming => 'Upcoming';
	String get premiere => 'Premiere';
	String get duration => 'Duration';
	String get trackList => 'TrackList';
	String get disc => 'Disc';
	String get sort => 'Sort';
	String get translation => 'Translation';
	String get chooseALanguage => 'Choose a language';
	String get settings => 'Settings';
	String get clearCache => 'Clear Cache';
	String get searchHistory => 'Search History';
	String get searchResultHistory => 'Search Result History';
	String get defaultSearchSubjectOption => 'Default Search Subject Option';
	String get homeAnimeList => 'Home Anime List';
	String get translationHistory => 'Translation History';
	String get subjectDetailList => 'Subject Detail List';
	String get areYouSureContinue => 'Are you sure you would like to continue?';
	String get no => 'No';
	String get yes => 'Yes';
	String get applicationLanguage => 'Application Language';
	String get english => 'English';
	String get simplifiedChinese => 'Simplified Chinese';
	String get traditionalChinese => 'Traditional Chinese';
	String get noInternetConnection => 'No Internet connection';
	String get copied => 'Copied';
	String get withoutAName => '(Name does not exist)';
	String get withoutADate => '(Date does not exist)';
	String inputLessThanRatings({required Object count}) => '(Less than ${count} ratings)';
	String inputPeopleRatings({required Object count}) => '(${count} ratings)';
	String inputDateString({required Object year, required Object month, required Object day}) => '${year}-${month}-${day}';
	String theFileSaved({required Object path}) => 'The file saved in directory (${path})';
	String charactersBelong({required Object subject}) => '${subject}\'s Characters';
	String productionStaffsBelong({required Object subject}) => '${subject}\'s Production Staffs';
	String somethingCleared({required Object something}) => '${something} Cleared';
	String somethingDoesNotExist({required Object something}) => '${something} Does not exist';
	String somethingUpdatedAt({required Object date}) => 'Updated at ${date}';
	Map<String, String> get locales => {
		'en': 'English',
		'zh-CN': 'Chinese Simplified',
		'zh-TW': 'Chinese Traditional',
	};
}

// Path: <root>
class _StringsZhCn implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZhCn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsZhCn _root = this; // ignore: unused_field

	// Translations
	@override String get discover => '发现';
	@override String get timeCapsules => '时间胶囊';
	@override String get favourite => '收藏';
	@override String get superUnfolded => '超展开';
	@override String get timeMachine => '时光机';
	@override String get ranking => '排行榜';
	@override String get online => '在线';
	@override String get anime => '动画';
	@override String get channel => '频道';
	@override String get entry => '条目';
	@override String get book => '书籍';
	@override String get music => '音乐';
	@override String get game => '游戏';
	@override String get film => '影视';
	@override String get character => '人物';
	@override String get user => '用户';
	@override String get accurate => '精确';
	@override String get vague => '模糊';
	@override String get search => '搜索';
	@override String get enquiry => '查询';
	@override String get viewInBrowser => '浏览器查看';
	@override String get clearHistory => '清除历史';
	@override String get noHistory => '无历史记录';
	@override String get imageBroken => '图像损坏';
	@override String get enterKeywords => '输入关键字';
	@override String get nothingThere => '好像什么都没有';
	@override String get notAddedToFavourites => '未加入收藏';
	@override String get wished => '想看';
	@override String get watched => '看过';
	@override String get watching => '在看';
	@override String get onHold => '搁置';
	@override String get dropped => '抛弃';
	@override String get total => '总';
	@override String get chapter => '章节';
	@override String get tag => '标签';
	@override String get summary => '简介';
	@override String get preview => '预览';
	@override String get more => '更多';
	@override String get details => '详情';
	@override String get revise => '修订';
	@override String get rating => '评分';
	@override String get trend => '趋势';
	@override String get perspective => '透视';
	@override String get userRating => '用户评分';
	@override String get standardDeviation => '标准差';
	@override String get role => '角色';
	@override String get productionStaff => '制作人员';
	@override String get associate => '关联';
	@override String get catalog => '目录';
	@override String get log => '日志';
	@override String get post => '帖子';
	@override String get dynamicString => '动态';
	@override String get comment => '评论';
	@override String get searchEntry => '找条目';
	@override String get indexing => '索引';
	@override String get today => '每日放送';
	@override String get journal => '日志';
	@override String get ongoing => '新番';
	@override String get info => '资讯';
	@override String get stock => '小圣杯';
	@override String get wiki => '维基人';
	@override String get almanac => '年鉴';
	@override String get timeline => '时间线';
	@override String get netabare => 'netaba.re';
	@override String get localSMB => '本地管理';
	@override String get bilibiliSync => 'bilibili 同步';
	@override String get doubanSync => '豆瓣同步';
	@override String get backupCSV => '本地备份';
	@override String get myCharacter => '我的人物';
	@override String get myCatalogue => '我的目录';
	@override String get clipboard => '剪贴板';
	@override String get loading => '载入中';
	@override String get loadingWithDots => '载入中 。。。';
	@override String get copyLink => '复制链接';
	@override String get copyShare => '复制分享';
	@override String get performance => '出演';
	@override String get whoHasCollectedIt => '谁收藏了';
	@override String get recentlyParticipated => '最近参与';
	@override String get moreWorks => '更多作品';
	@override String get producer => '制作人';
	@override String get mangaka => '漫画家';
	@override String get artist => '艺术家';
	@override String get seiyu => '声优';
	@override String get writer => '作家';
	@override String get illustrator => '插画家';
	@override String get actor => '演员';
	@override String get pleaseGrantStoragePermission => '请授予应用存储权限以保存';
	@override String get fileIsBeingSaved => '文件保存中';
	@override String get subjectSharing => '主题分享';
	@override String get invalidURL => '哎呀！看起来URL无效';
	@override String get unknown => '未知';
	@override String get unknownError => '糟糕！似乎出了点小问题';
	@override String get fileSaveTimeout => '文件保存超时';
	@override String get year => '年';
	@override String get month => '月';
	@override String get all => '全部';
	@override String get entire => '全部';
	@override String get type => '类型';
	@override String get others => '其他';
	@override String get tv => 'TV';
	@override String get web => 'WEB';
	@override String get ova => 'OVA';
	@override String get movie => '剧场版';
	@override String get comic => '漫画';
	@override String get novel => '小说';
	@override String get illustration => '画集';
	@override String get japaneseDrama => '日剧';
	@override String get europeanNAmericanDramas => '欧美剧';
	@override String get chineseDrama => '中剧';
	@override String get pc => 'PC';
	@override String get ns => 'NS';
	@override String get ps5 => 'PS5';
	@override String get ps4 => 'PS4';
	@override String get psv => 'PSV';
	@override String get xboxSeries => 'Xbox Series X/S';
	@override String get xboxOne => 'Xbox One';
	@override String get wiiU => 'Wii U';
	@override String get ps3 => 'PS3';
	@override String get xbox360 => 'Xbox 360';
	@override String get threeDS => '3DS';
	@override String get psp => 'PSP';
	@override String get wii => 'Wii';
	@override String get nds => 'NDS';
	@override String get ps2 => 'PS2';
	@override String get xbox => 'Xbox';
	@override String get mac => 'Mac';
	@override String get ps => 'PS';
	@override String get gba => 'GBA';
	@override String get gb => 'GB';
	@override String get fc => 'FC';
	@override String get numberOfAnnotations => '标注数';
	@override String get name => '名称';
	@override String get date => '日期';
	@override String get upcoming => '即将推出';
	@override String get premiere => '首播';
	@override String get duration => '时长';
	@override String get trackList => '曲目列表';
	@override String get disc => '光盘';
	@override String get sort => '排序';
	@override String get translation => '翻译';
	@override String get chooseALanguage => '选择语言';
	@override String get settings => '设置';
	@override String get clearCache => '清除缓存';
	@override String get searchHistory => '搜索历史记录';
	@override String get searchResultHistory => '搜索结果历史记录';
	@override String get defaultSearchSubjectOption => '默认搜索主题选项';
	@override String get homeAnimeList => '主页动漫列表';
	@override String get translationHistory => '翻译历史记录';
	@override String get subjectDetailList => '主题列表';
	@override String get areYouSureContinue => '你确定要继续吗？';
	@override String get no => '不是';
	@override String get yes => '是';
	@override String get applicationLanguage => '应用语言';
	@override String get english => '英文';
	@override String get simplifiedChinese => '简体中文';
	@override String get traditionalChinese => '繁体中文';
	@override String get noInternetConnection => '没有网络连接';
	@override String get copied => '已复制';
	@override String get withoutAName => '(名字不存在)';
	@override String get withoutADate => '(日期不存在)';
	@override String inputLessThanRatings({required Object count}) => '(少于${count}人评分)';
	@override String inputPeopleRatings({required Object count}) => '(${count}人评分)';
	@override String inputDateString({required Object year, required Object month, required Object day}) => '${year}年${month}月${day}日';
	@override String theFileSaved({required Object path}) => '文件已保存 (${path})';
	@override String charactersBelong({required Object subject}) => '${subject}的角色';
	@override String productionStaffsBelong({required Object subject}) => '${subject}的制作人员';
	@override String somethingCleared({required Object something}) => '${something}已清除';
	@override String somethingDoesNotExist({required Object something}) => '${something}不存在';
	@override String somethingUpdatedAt({required Object date}) => '更新于${date}';
	@override Map<String, String> get locales => {
		'en': '英文',
		'zh-CN': '简体中文',
		'zh-TW': '繁体中文',
	};
}

// Path: <root>
class _StringsZhTw implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZhTw.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhTw,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-TW>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsZhTw _root = this; // ignore: unused_field

	// Translations
	@override String get discover => '發現';
	@override String get timeCapsules => '時間膠囊';
	@override String get favourite => '收藏';
	@override String get superUnfolded => '超展開';
	@override String get timeMachine => '時光機';
	@override String get ranking => '排行榜';
	@override String get online => '在綫';
	@override String get anime => '動畫';
	@override String get channel => '頻道';
	@override String get entry => '條目';
	@override String get book => '書籍';
	@override String get music => '音樂';
	@override String get game => '游戲';
	@override String get film => '影視';
	@override String get character => '人物';
	@override String get user => '用戶';
	@override String get accurate => '精確';
	@override String get vague => '模糊';
	@override String get search => '搜索';
	@override String get enquiry => '查詢';
	@override String get viewInBrowser => '瀏覽器查看';
	@override String get clearHistory => '清除歷史';
	@override String get noHistory => '無歷史記錄';
	@override String get imageBroken => '圖像損壞';
	@override String get enterKeywords => '輸入關鍵字';
	@override String get nothingThere => '好像什麼都沒有';
	@override String get notAddedToFavourites => '未加入收藏';
	@override String get wished => '想看';
	@override String get watched => '看過';
	@override String get watching => '在看';
	@override String get onHold => '擱置';
	@override String get dropped => '拋棄';
	@override String get total => '總';
	@override String get chapter => '章節';
	@override String get tag => '標籤';
	@override String get summary => '簡介';
	@override String get preview => '預覽';
	@override String get more => '更多';
	@override String get details => '詳情';
	@override String get revise => '修訂';
	@override String get rating => '評分';
	@override String get trend => '趨勢';
	@override String get perspective => '透視';
	@override String get userRating => '用戶評分';
	@override String get standardDeviation => '標準差';
	@override String get role => '角色';
	@override String get productionStaff => '製作人員';
	@override String get associate => '關聯';
	@override String get catalog => '目錄';
	@override String get log => '日誌';
	@override String get post => '帖子';
	@override String get dynamicString => '動態';
	@override String get comment => '評論';
	@override String get searchEntry => '找條目';
	@override String get indexing => '索引';
	@override String get today => '每日放送';
	@override String get journal => '日誌';
	@override String get ongoing => '新番';
	@override String get info => '資訊';
	@override String get stock => '小聖杯';
	@override String get wiki => '維基人';
	@override String get almanac => '年鑒';
	@override String get timeline => '時間線';
	@override String get netabare => 'netaba.re';
	@override String get localSMB => '本地管理';
	@override String get bilibiliSync => 'bilibili 同步';
	@override String get doubanSync => '豆瓣同步';
	@override String get backupCSV => '本地備份';
	@override String get myCharacter => '我的人物';
	@override String get myCatalogue => '我的目錄';
	@override String get clipboard => '剪貼板';
	@override String get loading => '載入中';
	@override String get loadingWithDots => '載入中 。。。';
	@override String get copyLink => '複製鏈接';
	@override String get copyShare => '複製分享';
	@override String get performance => '出演';
	@override String get whoHasCollectedIt => '誰收藏了';
	@override String get recentlyParticipated => '最近參與';
	@override String get moreWorks => '更多作品';
	@override String get producer => '製作人';
	@override String get mangaka => '漫畫家';
	@override String get artist => '藝術家';
	@override String get seiyu => '聲優';
	@override String get writer => '作家';
	@override String get illustrator => '插畫家';
	@override String get actor => '演員';
	@override String get pleaseGrantStoragePermission => '請授予應用存儲權限以保存';
	@override String get fileIsBeingSaved => '文件保存中';
	@override String get subjectSharing => '主題分享';
	@override String get invalidURL => '哎呀！看起來URL無效';
	@override String get unknown => '未知';
	@override String get unknownError => '糟糕！似乎出了點小問題';
	@override String get fileSaveTimeout => '文件保存超時';
	@override String get year => '年';
	@override String get month => '月';
	@override String get all => '全部';
	@override String get entire => '全部';
	@override String get type => '類型';
	@override String get others => '其他';
	@override String get tv => 'TV';
	@override String get web => 'WEB';
	@override String get ova => 'OVA';
	@override String get movie => '剧场版';
	@override String get comic => '漫画';
	@override String get novel => '小说';
	@override String get illustration => '画集';
	@override String get japaneseDrama => '日剧';
	@override String get europeanNAmericanDramas => '欧美剧';
	@override String get chineseDrama => '中剧';
	@override String get pc => 'PC';
	@override String get ns => 'NS';
	@override String get ps5 => 'PS5';
	@override String get ps4 => 'PS4';
	@override String get psv => 'PSV';
	@override String get xboxSeries => 'Xbox Series X/S';
	@override String get xboxOne => 'Xbox One';
	@override String get wiiU => 'Wii U';
	@override String get ps3 => 'PS3';
	@override String get xbox360 => 'Xbox 360';
	@override String get threeDS => '3DS';
	@override String get psp => 'PSP';
	@override String get wii => 'Wii';
	@override String get nds => 'NDS';
	@override String get ps2 => 'PS2';
	@override String get xbox => 'Xbox';
	@override String get mac => 'Mac';
	@override String get ps => 'PS';
	@override String get gba => 'GBA';
	@override String get gb => 'GB';
	@override String get fc => 'FC';
	@override String get numberOfAnnotations => '標註數';
	@override String get name => '名稱';
	@override String get date => '日期';
	@override String get upcoming => '即將推出';
	@override String get premiere => '首播';
	@override String get duration => '時長';
	@override String get trackList => '曲目列表';
	@override String get disc => '光盤';
	@override String get sort => '排序';
	@override String get translation => '翻譯';
	@override String get chooseALanguage => '選擇語言';
	@override String get settings => '設置';
	@override String get clearCache => '清除緩存';
	@override String get searchHistory => '搜索歷史記錄';
	@override String get searchResultHistory => '搜索結果歷史記錄';
	@override String get defaultSearchSubjectOption => '默認搜索主題選項';
	@override String get homeAnimeList => '主頁動漫列表';
	@override String get translationHistory => '翻譯歷史記錄';
	@override String get subjectDetailList => '主題列表';
	@override String get areYouSureContinue => '你確定要繼續嗎？';
	@override String get no => '不是';
	@override String get yes => '是';
	@override String get applicationLanguage => '應用語言';
	@override String get english => '英文';
	@override String get simplifiedChinese => '簡體中文';
	@override String get traditionalChinese => '繁體中文';
	@override String get noInternetConnection => '沒有網路連接';
	@override String get copied => '已複製';
	@override String get withoutAName => '(名字不存在)';
	@override String get withoutADate => '(日期不存在)';
	@override String inputLessThanRatings({required Object count}) => '(少於${count}人評分)';
	@override String inputPeopleRatings({required Object count}) => '(${count}人評分)';
	@override String inputDateString({required Object year, required Object month, required Object day}) => '${year}年${month}月${day}日';
	@override String theFileSaved({required Object path}) => '文件已保存 (${path})';
	@override String charactersBelong({required Object subject}) => '${subject}的角色';
	@override String productionStaffsBelong({required Object subject}) => '${subject}的製作人員';
	@override String somethingCleared({required Object something}) => '${something}已清除';
	@override String somethingDoesNotExist({required Object something}) => '${something}不存在';
	@override String somethingUpdatedAt({required Object date}) => '更新於${date}';
	@override Map<String, String> get locales => {
		'en': '英文',
		'zh-CN': '簡體中文',
		'zh-TW': '繁體中文',
	};
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'discover': return 'Discover';
			case 'timeCapsules': return 'Time Capsules';
			case 'favourite': return 'Favourite';
			case 'superUnfolded': return 'Super Unfolded';
			case 'timeMachine': return 'Time Machine';
			case 'ranking': return 'Ranking';
			case 'online': return 'Online';
			case 'anime': return 'Anime';
			case 'channel': return 'Channel';
			case 'entry': return 'Entry';
			case 'book': return 'Book';
			case 'music': return 'Music';
			case 'game': return 'Game';
			case 'film': return 'Film';
			case 'character': return 'Character';
			case 'user': return 'User';
			case 'accurate': return 'Accurate';
			case 'vague': return 'Vague';
			case 'search': return 'Search';
			case 'enquiry': return 'Enquiry';
			case 'viewInBrowser': return 'View in Browser';
			case 'clearHistory': return 'Clear history';
			case 'noHistory': return 'No history';
			case 'imageBroken': return 'Image broken';
			case 'enterKeywords': return 'Enter keywords';
			case 'nothingThere': return 'It\'s like there\'s nothing there.';
			case 'notAddedToFavourites': return 'Not added to favourites';
			case 'wished': return 'Wished';
			case 'watched': return 'Watched';
			case 'watching': return 'Watching';
			case 'onHold': return 'On hold';
			case 'dropped': return 'Dropped';
			case 'total': return 'Total';
			case 'chapter': return 'Chapter';
			case 'tag': return 'Tag';
			case 'summary': return 'Summary';
			case 'preview': return 'Preview';
			case 'more': return 'More';
			case 'details': return 'Details';
			case 'revise': return 'Revise';
			case 'rating': return 'Rating';
			case 'trend': return 'Trend';
			case 'perspective': return 'Perspective';
			case 'userRating': return 'User rating';
			case 'standardDeviation': return 'Standard deviation';
			case 'role': return 'Role';
			case 'productionStaff': return 'Production Staff';
			case 'associate': return 'Associate';
			case 'catalog': return 'Catalog';
			case 'log': return 'Log';
			case 'post': return 'Post';
			case 'dynamicString': return 'Dynamic';
			case 'comment': return 'Comment';
			case 'searchEntry': return 'Search Entry';
			case 'indexing': return 'Indexing';
			case 'today': return 'Today';
			case 'journal': return 'Journal';
			case 'ongoing': return 'Ongoing';
			case 'info': return 'Info';
			case 'stock': return 'Stock';
			case 'wiki': return 'Wiki';
			case 'almanac': return 'Almanac';
			case 'timeline': return 'Timeline';
			case 'netabare': return 'netaba.re';
			case 'localSMB': return 'Local SMB';
			case 'bilibiliSync': return 'bilibili Sync';
			case 'doubanSync': return 'Douban Sync';
			case 'backupCSV': return 'Backup CSV';
			case 'myCharacter': return 'My Character';
			case 'myCatalogue': return 'My Catalogue';
			case 'clipboard': return 'Clipboard';
			case 'loading': return 'Loading';
			case 'loadingWithDots': return 'Loading ...';
			case 'copyLink': return 'Copy link';
			case 'copyShare': return 'Copy share';
			case 'performance': return 'Performance';
			case 'whoHasCollectedIt': return 'Who has collected it';
			case 'recentlyParticipated': return 'Recently participated';
			case 'moreWorks': return 'More works';
			case 'producer': return 'producer';
			case 'mangaka': return 'mangaka';
			case 'artist': return 'artist';
			case 'seiyu': return 'seiyu';
			case 'writer': return 'writer';
			case 'illustrator': return 'illustrator';
			case 'actor': return 'actor';
			case 'pleaseGrantStoragePermission': return 'Please grant storage permission to the app to save';
			case 'fileIsBeingSaved': return 'File is being saved';
			case 'subjectSharing': return 'Subject Sharing';
			case 'invalidURL': return 'Uh-oh! It looks like the URL is invalid';
			case 'unknown': return 'Unknown';
			case 'unknownError': return 'Oops! It seems like there might be a small hiccup';
			case 'fileSaveTimeout': return 'File save timeout';
			case 'year': return 'Year';
			case 'month': return 'Month';
			case 'all': return 'All';
			case 'entire': return 'Entire';
			case 'type': return 'Type';
			case 'others': return 'Others';
			case 'tv': return 'TV';
			case 'web': return 'WEB';
			case 'ova': return 'OVA';
			case 'movie': return 'Movie';
			case 'comic': return 'Comic';
			case 'novel': return 'Novel';
			case 'illustration': return 'Illustration';
			case 'japaneseDrama': return 'Japanese Drama';
			case 'europeanNAmericanDramas': return 'European & American Dramas';
			case 'chineseDrama': return 'Chinese Drama';
			case 'pc': return 'Personal Computer';
			case 'ns': return 'Nintendo Switch';
			case 'ps5': return 'Play Station 5';
			case 'ps4': return 'Play Station 4';
			case 'psv': return 'Play Station Vita';
			case 'xboxSeries': return 'Xbox Series X/S';
			case 'xboxOne': return 'Xbox One';
			case 'wiiU': return 'Wii U';
			case 'ps3': return 'Play Station 3';
			case 'xbox360': return 'Xbox 360';
			case 'threeDS': return 'Nintendo 3D Dual Screen';
			case 'psp': return 'Play Station Portable';
			case 'wii': return 'Wii';
			case 'nds': return 'Nintendo Dual Screen';
			case 'ps2': return 'Play Station 2';
			case 'xbox': return 'Xbox';
			case 'mac': return 'Macbook';
			case 'ps': return 'Play Station 1';
			case 'gba': return 'Game Boy Advanced';
			case 'gb': return 'Game Boy';
			case 'fc': return 'Famicom';
			case 'numberOfAnnotations': return 'Number of Annotations';
			case 'name': return 'Name';
			case 'date': return 'Date';
			case 'upcoming': return 'Upcoming';
			case 'premiere': return 'Premiere';
			case 'duration': return 'Duration';
			case 'trackList': return 'TrackList';
			case 'disc': return 'Disc';
			case 'sort': return 'Sort';
			case 'translation': return 'Translation';
			case 'chooseALanguage': return 'Choose a language';
			case 'settings': return 'Settings';
			case 'clearCache': return 'Clear Cache';
			case 'searchHistory': return 'Search History';
			case 'searchResultHistory': return 'Search Result History';
			case 'defaultSearchSubjectOption': return 'Default Search Subject Option';
			case 'homeAnimeList': return 'Home Anime List';
			case 'translationHistory': return 'Translation History';
			case 'subjectDetailList': return 'Subject Detail List';
			case 'areYouSureContinue': return 'Are you sure you would like to continue?';
			case 'no': return 'No';
			case 'yes': return 'Yes';
			case 'applicationLanguage': return 'Application Language';
			case 'english': return 'English';
			case 'simplifiedChinese': return 'Simplified Chinese';
			case 'traditionalChinese': return 'Traditional Chinese';
			case 'noInternetConnection': return 'No Internet connection';
			case 'copied': return 'Copied';
			case 'withoutAName': return '(Name does not exist)';
			case 'withoutADate': return '(Date does not exist)';
			case 'inputLessThanRatings': return ({required Object count}) => '(Less than ${count} ratings)';
			case 'inputPeopleRatings': return ({required Object count}) => '(${count} ratings)';
			case 'inputDateString': return ({required Object year, required Object month, required Object day}) => '${year}-${month}-${day}';
			case 'theFileSaved': return ({required Object path}) => 'The file saved in directory (${path})';
			case 'charactersBelong': return ({required Object subject}) => '${subject}\'s Characters';
			case 'productionStaffsBelong': return ({required Object subject}) => '${subject}\'s Production Staffs';
			case 'somethingCleared': return ({required Object something}) => '${something} Cleared';
			case 'somethingDoesNotExist': return ({required Object something}) => '${something} Does not exist';
			case 'somethingUpdatedAt': return ({required Object date}) => 'Updated at ${date}';
			case 'locales.en': return 'English';
			case 'locales.zh-CN': return 'Chinese Simplified';
			case 'locales.zh-TW': return 'Chinese Traditional';
			default: return null;
		}
	}
}

extension on _StringsZhCn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'discover': return '发现';
			case 'timeCapsules': return '时间胶囊';
			case 'favourite': return '收藏';
			case 'superUnfolded': return '超展开';
			case 'timeMachine': return '时光机';
			case 'ranking': return '排行榜';
			case 'online': return '在线';
			case 'anime': return '动画';
			case 'channel': return '频道';
			case 'entry': return '条目';
			case 'book': return '书籍';
			case 'music': return '音乐';
			case 'game': return '游戏';
			case 'film': return '影视';
			case 'character': return '人物';
			case 'user': return '用户';
			case 'accurate': return '精确';
			case 'vague': return '模糊';
			case 'search': return '搜索';
			case 'enquiry': return '查询';
			case 'viewInBrowser': return '浏览器查看';
			case 'clearHistory': return '清除历史';
			case 'noHistory': return '无历史记录';
			case 'imageBroken': return '图像损坏';
			case 'enterKeywords': return '输入关键字';
			case 'nothingThere': return '好像什么都没有';
			case 'notAddedToFavourites': return '未加入收藏';
			case 'wished': return '想看';
			case 'watched': return '看过';
			case 'watching': return '在看';
			case 'onHold': return '搁置';
			case 'dropped': return '抛弃';
			case 'total': return '总';
			case 'chapter': return '章节';
			case 'tag': return '标签';
			case 'summary': return '简介';
			case 'preview': return '预览';
			case 'more': return '更多';
			case 'details': return '详情';
			case 'revise': return '修订';
			case 'rating': return '评分';
			case 'trend': return '趋势';
			case 'perspective': return '透视';
			case 'userRating': return '用户评分';
			case 'standardDeviation': return '标准差';
			case 'role': return '角色';
			case 'productionStaff': return '制作人员';
			case 'associate': return '关联';
			case 'catalog': return '目录';
			case 'log': return '日志';
			case 'post': return '帖子';
			case 'dynamicString': return '动态';
			case 'comment': return '评论';
			case 'searchEntry': return '找条目';
			case 'indexing': return '索引';
			case 'today': return '每日放送';
			case 'journal': return '日志';
			case 'ongoing': return '新番';
			case 'info': return '资讯';
			case 'stock': return '小圣杯';
			case 'wiki': return '维基人';
			case 'almanac': return '年鉴';
			case 'timeline': return '时间线';
			case 'netabare': return 'netaba.re';
			case 'localSMB': return '本地管理';
			case 'bilibiliSync': return 'bilibili 同步';
			case 'doubanSync': return '豆瓣同步';
			case 'backupCSV': return '本地备份';
			case 'myCharacter': return '我的人物';
			case 'myCatalogue': return '我的目录';
			case 'clipboard': return '剪贴板';
			case 'loading': return '载入中';
			case 'loadingWithDots': return '载入中 。。。';
			case 'copyLink': return '复制链接';
			case 'copyShare': return '复制分享';
			case 'performance': return '出演';
			case 'whoHasCollectedIt': return '谁收藏了';
			case 'recentlyParticipated': return '最近参与';
			case 'moreWorks': return '更多作品';
			case 'producer': return '制作人';
			case 'mangaka': return '漫画家';
			case 'artist': return '艺术家';
			case 'seiyu': return '声优';
			case 'writer': return '作家';
			case 'illustrator': return '插画家';
			case 'actor': return '演员';
			case 'pleaseGrantStoragePermission': return '请授予应用存储权限以保存';
			case 'fileIsBeingSaved': return '文件保存中';
			case 'subjectSharing': return '主题分享';
			case 'invalidURL': return '哎呀！看起来URL无效';
			case 'unknown': return '未知';
			case 'unknownError': return '糟糕！似乎出了点小问题';
			case 'fileSaveTimeout': return '文件保存超时';
			case 'year': return '年';
			case 'month': return '月';
			case 'all': return '全部';
			case 'entire': return '全部';
			case 'type': return '类型';
			case 'others': return '其他';
			case 'tv': return 'TV';
			case 'web': return 'WEB';
			case 'ova': return 'OVA';
			case 'movie': return '剧场版';
			case 'comic': return '漫画';
			case 'novel': return '小说';
			case 'illustration': return '画集';
			case 'japaneseDrama': return '日剧';
			case 'europeanNAmericanDramas': return '欧美剧';
			case 'chineseDrama': return '中剧';
			case 'pc': return 'PC';
			case 'ns': return 'NS';
			case 'ps5': return 'PS5';
			case 'ps4': return 'PS4';
			case 'psv': return 'PSV';
			case 'xboxSeries': return 'Xbox Series X/S';
			case 'xboxOne': return 'Xbox One';
			case 'wiiU': return 'Wii U';
			case 'ps3': return 'PS3';
			case 'xbox360': return 'Xbox 360';
			case 'threeDS': return '3DS';
			case 'psp': return 'PSP';
			case 'wii': return 'Wii';
			case 'nds': return 'NDS';
			case 'ps2': return 'PS2';
			case 'xbox': return 'Xbox';
			case 'mac': return 'Mac';
			case 'ps': return 'PS';
			case 'gba': return 'GBA';
			case 'gb': return 'GB';
			case 'fc': return 'FC';
			case 'numberOfAnnotations': return '标注数';
			case 'name': return '名称';
			case 'date': return '日期';
			case 'upcoming': return '即将推出';
			case 'premiere': return '首播';
			case 'duration': return '时长';
			case 'trackList': return '曲目列表';
			case 'disc': return '光盘';
			case 'sort': return '排序';
			case 'translation': return '翻译';
			case 'chooseALanguage': return '选择语言';
			case 'settings': return '设置';
			case 'clearCache': return '清除缓存';
			case 'searchHistory': return '搜索历史记录';
			case 'searchResultHistory': return '搜索结果历史记录';
			case 'defaultSearchSubjectOption': return '默认搜索主题选项';
			case 'homeAnimeList': return '主页动漫列表';
			case 'translationHistory': return '翻译历史记录';
			case 'subjectDetailList': return '主题列表';
			case 'areYouSureContinue': return '你确定要继续吗？';
			case 'no': return '不是';
			case 'yes': return '是';
			case 'applicationLanguage': return '应用语言';
			case 'english': return '英文';
			case 'simplifiedChinese': return '简体中文';
			case 'traditionalChinese': return '繁体中文';
			case 'noInternetConnection': return '没有网络连接';
			case 'copied': return '已复制';
			case 'withoutAName': return '(名字不存在)';
			case 'withoutADate': return '(日期不存在)';
			case 'inputLessThanRatings': return ({required Object count}) => '(少于${count}人评分)';
			case 'inputPeopleRatings': return ({required Object count}) => '(${count}人评分)';
			case 'inputDateString': return ({required Object year, required Object month, required Object day}) => '${year}年${month}月${day}日';
			case 'theFileSaved': return ({required Object path}) => '文件已保存 (${path})';
			case 'charactersBelong': return ({required Object subject}) => '${subject}的角色';
			case 'productionStaffsBelong': return ({required Object subject}) => '${subject}的制作人员';
			case 'somethingCleared': return ({required Object something}) => '${something}已清除';
			case 'somethingDoesNotExist': return ({required Object something}) => '${something}不存在';
			case 'somethingUpdatedAt': return ({required Object date}) => '更新于${date}';
			case 'locales.en': return '英文';
			case 'locales.zh-CN': return '简体中文';
			case 'locales.zh-TW': return '繁体中文';
			default: return null;
		}
	}
}

extension on _StringsZhTw {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'discover': return '發現';
			case 'timeCapsules': return '時間膠囊';
			case 'favourite': return '收藏';
			case 'superUnfolded': return '超展開';
			case 'timeMachine': return '時光機';
			case 'ranking': return '排行榜';
			case 'online': return '在綫';
			case 'anime': return '動畫';
			case 'channel': return '頻道';
			case 'entry': return '條目';
			case 'book': return '書籍';
			case 'music': return '音樂';
			case 'game': return '游戲';
			case 'film': return '影視';
			case 'character': return '人物';
			case 'user': return '用戶';
			case 'accurate': return '精確';
			case 'vague': return '模糊';
			case 'search': return '搜索';
			case 'enquiry': return '查詢';
			case 'viewInBrowser': return '瀏覽器查看';
			case 'clearHistory': return '清除歷史';
			case 'noHistory': return '無歷史記錄';
			case 'imageBroken': return '圖像損壞';
			case 'enterKeywords': return '輸入關鍵字';
			case 'nothingThere': return '好像什麼都沒有';
			case 'notAddedToFavourites': return '未加入收藏';
			case 'wished': return '想看';
			case 'watched': return '看過';
			case 'watching': return '在看';
			case 'onHold': return '擱置';
			case 'dropped': return '拋棄';
			case 'total': return '總';
			case 'chapter': return '章節';
			case 'tag': return '標籤';
			case 'summary': return '簡介';
			case 'preview': return '預覽';
			case 'more': return '更多';
			case 'details': return '詳情';
			case 'revise': return '修訂';
			case 'rating': return '評分';
			case 'trend': return '趨勢';
			case 'perspective': return '透視';
			case 'userRating': return '用戶評分';
			case 'standardDeviation': return '標準差';
			case 'role': return '角色';
			case 'productionStaff': return '製作人員';
			case 'associate': return '關聯';
			case 'catalog': return '目錄';
			case 'log': return '日誌';
			case 'post': return '帖子';
			case 'dynamicString': return '動態';
			case 'comment': return '評論';
			case 'searchEntry': return '找條目';
			case 'indexing': return '索引';
			case 'today': return '每日放送';
			case 'journal': return '日誌';
			case 'ongoing': return '新番';
			case 'info': return '資訊';
			case 'stock': return '小聖杯';
			case 'wiki': return '維基人';
			case 'almanac': return '年鑒';
			case 'timeline': return '時間線';
			case 'netabare': return 'netaba.re';
			case 'localSMB': return '本地管理';
			case 'bilibiliSync': return 'bilibili 同步';
			case 'doubanSync': return '豆瓣同步';
			case 'backupCSV': return '本地備份';
			case 'myCharacter': return '我的人物';
			case 'myCatalogue': return '我的目錄';
			case 'clipboard': return '剪貼板';
			case 'loading': return '載入中';
			case 'loadingWithDots': return '載入中 。。。';
			case 'copyLink': return '複製鏈接';
			case 'copyShare': return '複製分享';
			case 'performance': return '出演';
			case 'whoHasCollectedIt': return '誰收藏了';
			case 'recentlyParticipated': return '最近參與';
			case 'moreWorks': return '更多作品';
			case 'producer': return '製作人';
			case 'mangaka': return '漫畫家';
			case 'artist': return '藝術家';
			case 'seiyu': return '聲優';
			case 'writer': return '作家';
			case 'illustrator': return '插畫家';
			case 'actor': return '演員';
			case 'pleaseGrantStoragePermission': return '請授予應用存儲權限以保存';
			case 'fileIsBeingSaved': return '文件保存中';
			case 'subjectSharing': return '主題分享';
			case 'invalidURL': return '哎呀！看起來URL無效';
			case 'unknown': return '未知';
			case 'unknownError': return '糟糕！似乎出了點小問題';
			case 'fileSaveTimeout': return '文件保存超時';
			case 'year': return '年';
			case 'month': return '月';
			case 'all': return '全部';
			case 'entire': return '全部';
			case 'type': return '類型';
			case 'others': return '其他';
			case 'tv': return 'TV';
			case 'web': return 'WEB';
			case 'ova': return 'OVA';
			case 'movie': return '剧场版';
			case 'comic': return '漫画';
			case 'novel': return '小说';
			case 'illustration': return '画集';
			case 'japaneseDrama': return '日剧';
			case 'europeanNAmericanDramas': return '欧美剧';
			case 'chineseDrama': return '中剧';
			case 'pc': return 'PC';
			case 'ns': return 'NS';
			case 'ps5': return 'PS5';
			case 'ps4': return 'PS4';
			case 'psv': return 'PSV';
			case 'xboxSeries': return 'Xbox Series X/S';
			case 'xboxOne': return 'Xbox One';
			case 'wiiU': return 'Wii U';
			case 'ps3': return 'PS3';
			case 'xbox360': return 'Xbox 360';
			case 'threeDS': return '3DS';
			case 'psp': return 'PSP';
			case 'wii': return 'Wii';
			case 'nds': return 'NDS';
			case 'ps2': return 'PS2';
			case 'xbox': return 'Xbox';
			case 'mac': return 'Mac';
			case 'ps': return 'PS';
			case 'gba': return 'GBA';
			case 'gb': return 'GB';
			case 'fc': return 'FC';
			case 'numberOfAnnotations': return '標註數';
			case 'name': return '名稱';
			case 'date': return '日期';
			case 'upcoming': return '即將推出';
			case 'premiere': return '首播';
			case 'duration': return '時長';
			case 'trackList': return '曲目列表';
			case 'disc': return '光盤';
			case 'sort': return '排序';
			case 'translation': return '翻譯';
			case 'chooseALanguage': return '選擇語言';
			case 'settings': return '設置';
			case 'clearCache': return '清除緩存';
			case 'searchHistory': return '搜索歷史記錄';
			case 'searchResultHistory': return '搜索結果歷史記錄';
			case 'defaultSearchSubjectOption': return '默認搜索主題選項';
			case 'homeAnimeList': return '主頁動漫列表';
			case 'translationHistory': return '翻譯歷史記錄';
			case 'subjectDetailList': return '主題列表';
			case 'areYouSureContinue': return '你確定要繼續嗎？';
			case 'no': return '不是';
			case 'yes': return '是';
			case 'applicationLanguage': return '應用語言';
			case 'english': return '英文';
			case 'simplifiedChinese': return '簡體中文';
			case 'traditionalChinese': return '繁體中文';
			case 'noInternetConnection': return '沒有網路連接';
			case 'copied': return '已複製';
			case 'withoutAName': return '(名字不存在)';
			case 'withoutADate': return '(日期不存在)';
			case 'inputLessThanRatings': return ({required Object count}) => '(少於${count}人評分)';
			case 'inputPeopleRatings': return ({required Object count}) => '(${count}人評分)';
			case 'inputDateString': return ({required Object year, required Object month, required Object day}) => '${year}年${month}月${day}日';
			case 'theFileSaved': return ({required Object path}) => '文件已保存 (${path})';
			case 'charactersBelong': return ({required Object subject}) => '${subject}的角色';
			case 'productionStaffsBelong': return ({required Object subject}) => '${subject}的製作人員';
			case 'somethingCleared': return ({required Object something}) => '${something}已清除';
			case 'somethingDoesNotExist': return ({required Object something}) => '${something}不存在';
			case 'somethingUpdatedAt': return ({required Object date}) => '更新於${date}';
			case 'locales.en': return '英文';
			case 'locales.zh-CN': return '簡體中文';
			case 'locales.zh-TW': return '繁體中文';
			default: return null;
		}
	}
}
