import 'package:flutter/material.dart';
import 'package:alt_bangumi/models/calendar_model/calendar_model.dart';

import 'calendar_list_card.dart';

class CalendarListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final List<CalendarModel> calendarList;
  const CalendarListWidget({
    super.key,
    required this.scrollController,
    required this.calendarList,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          ...calendarList.map(
            (e) => CustomScrollView(
              controller: scrollController,
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  leading: const SizedBox.shrink(),
                  title: Text(
                    '${e.weekday?.cn}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leadingWidth: 0.0,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      e.items!
                          .map((calendarItem) =>
                              CalendarListCard(item: calendarItem))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
