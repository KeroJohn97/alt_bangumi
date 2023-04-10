class HttpConstant {
  static const String calendarItem =
      'https://cdn.jsdelivr.net/gh/ekibot/bangumi-onair/calendar.json';
  static String subject(String id) {
    return 'https://cdn.jsdelivr.net/gh/ekibot/bangumi-onair/onair/${(int.parse(id) / 1000).floor()}/$id.json';
  }
}
