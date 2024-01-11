import 'package:flutter/material.dart';
import 'package:alt_bangumi/models/calendar_model/calendar_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'calendar_grid_card.dart';

class CalendarGridWidget extends StatelessWidget {
  final ScrollController scrollController;
  final List<CalendarModel> calendarList;
  const CalendarGridWidget({
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
                  padding: const EdgeInsets.only(left: 16.0),
                  sliver: SliverAlignedGrid.count(
                    crossAxisCount: 3,
                    itemCount: e.items!.length,
                    itemBuilder: (context, index) {
                      return CalendarGridCard(
                        item: e.items![index],
                      );
                    },
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
