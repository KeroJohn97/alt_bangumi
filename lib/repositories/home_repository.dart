import 'package:flutter_bangumi/constants/http_constant.dart';
import 'package:flutter_bangumi/helpers/http_helper.dart';
import 'package:flutter_bangumi/models/calendar_item_model/calendar_item_model.dart';
import 'package:riverpod/riverpod.dart';

import '../models/subject_model/subject_model.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

class HomeRepository {
  Future<List<CalendarItemModel>> getCalendarItem() async {
    final List<dynamic> json = await HttpHelper.get(HttpConstant.calendarItem);
    return json.map((e) => (CalendarItemModel.fromMap(e))).toList();
  }

  Future<SubjectModel> getSubject(String subjectId) async {
    final dynamic json = await HttpHelper.get(HttpConstant.subject(subjectId));
    return SubjectModel.fromMap(json);
  }
}
