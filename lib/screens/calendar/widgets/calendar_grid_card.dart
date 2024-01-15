import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:alt_bangumi/screens/subject_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/calendar_model/calendar_item.dart';

import 'package:go_router/go_router.dart';

import '../../../widgets/custom_network_image_widget.dart';

class CalendarGridCard extends StatelessWidget {
  final CalendarItem item;
  const CalendarGridCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        SubjectDetailScreen.route,
        extra: {
          SubjectDetailScreen.subjectIdKey: item.id,
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImageWidget(
            height: 18.h,
            width: 28.w,
            imageUrl: item.images?.large,
            radius: 8.0,
          ),
          // const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              (item.nameCn?.isEmpty ?? true)
                  ? context.t.withoutAName
                  : '${item.nameCn}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
          ),
          Text(
            '${item.id}',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          // const SizedBox(height: 4.0),
          Row(
            children: [
              if (item.eps != null)
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Text(
                    '${item.eps}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              const Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Icon(
                  Icons.star,
                  color: ColorConstant.starColor,
                  size: 16.0,
                ),
              ),
              Text(
                '${item.rating?.score ?? 0.0}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
