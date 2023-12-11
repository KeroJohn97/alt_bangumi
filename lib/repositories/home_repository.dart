import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/helpers/http_helper.dart';
import 'package:alt_bangumi/models/calendar_item_model/calendar_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/home_subject_model/home_subject_model.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

class HomeRepository {
  Future<List<CalendarItemModel>> getCalendarItem() async {
    final List<dynamic> json = await HttpHelper.get(HttpConstant.cdnOnair);
    return json.map((e) => (CalendarItemModel.fromMap(e))).toList();
  }

  Future<HomeSubjectModel> getSubject(String subjectId) async {
    final dynamic json = await HttpHelper.get(HttpConstant.cdnEps(subjectId));
    return HomeSubjectModel.fromMap(json);
  }
}
