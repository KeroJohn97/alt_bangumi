import 'package:alt_bangumi/models/rating_model.dart';
import 'package:alt_bangumi/widgets/subject/custom_rating_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../constants/color_constant.dart';
import '../constants/text_constant.dart';
import '../helpers/common_helper.dart';
import '../models/count_model.dart';

class SubjectDetailRatingWidget extends StatelessWidget {
  final RatingModel? rating;
  const SubjectDetailRatingWidget({super.key, required this.rating});

  String _getStandardDeviation(CountModel count) {
    return '${CommonHelper.standardDeviation(
      [
        count.rate1!,
        count.rate2!,
        count.rate3!,
        count.rate4!,
        count.rate5!,
        count.rate6!,
        count.rate7!,
        count.rate8!,
        count.rate9!,
        count.rate10!,
      ],
    )}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (rating != null) ...[
          const SizedBox(height: 8.0),
          Row(
            children: [
              Text.rich(
                TextSpan(
                  text: TextConstant.rating.getString(context),
                  children: [
                    TextSpan(
                      text: ' ${rating?.score}',
                      style: const TextStyle(color: ColorConstant.starColor),
                    ),
                  ],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(width: 4.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: ColorConstant.starColor,
                ),
                child: Text(
                  '${rating?.rank}',
                  style: const TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(0.0, 2.0),
                        blurRadius: 5.0,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      TextConstant.trend.getString(context),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Icon(
                      Icons.open_in_new_outlined,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      TextConstant.perspective.getString(context),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Icon(
                      Icons.open_in_new_outlined,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${rating?.total} ${TextConstant.rating.getString(context)}',
              style: const TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
          ),
          CustomRatingChartWidget(rating: rating!),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  '${TextConstant.userRating.getString(context)} >',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: TextConstant.standardDeviation.getString(context),
                        children: [
                          TextSpan(
                            text: _getStandardDeviation(rating!.count!),
                            style: const TextStyle(
                                color: ColorConstant.themeColor),
                          ),
                          const TextSpan(
                            text: '基本一致',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
