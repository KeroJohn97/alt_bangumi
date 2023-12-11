import 'package:flutter/material.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/calendar_model/calendar_item.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/text_constant.dart';
import '../../subject_detail_screen.dart';

class CalendarListCard extends StatelessWidget {
  final CalendarItem item;
  const CalendarListCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () => context.push(
          SubjectDetailScreen.route,
          extra: {
            SubjectDetailScreen.subjectIdKey: item.id,
          },
        ),
        child: SizedBox(
          height: 18.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '23:30',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8.0),
              CustomNetworkImageWidget(
                height: 18.h,
                width: 28.w,
                imageUrl: item.images?.large,
                radius: 8.0,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            (item.nameCn?.isEmpty ?? true)
                                ? TextConstant.withoutAName.getString(context)
                                : '${item.nameCn}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        InkResponse(
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                    title: Text('dialog'),
                                  )),
                          child: const Icon(
                            Icons.star_outline,
                            color: Colors.black12,
                            size: 20.0,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        if (item.eps != null)
                          Text(
                            '${item.eps}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 255, 190, 60),
                            size: 16.0,
                          ),
                        ),
                        Text(
                          '${item.rating?.score}',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
