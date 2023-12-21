import 'package:alt_bangumi/models/rating_model.dart';
import 'package:alt_bangumi/widgets/subject/custom_rating_chart_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../constants/color_constant.dart';
import '../constants/text_constant.dart';
import '../helpers/common_helper.dart';
import '../models/count_model.dart';

class SubjectDetailRatingWidget extends StatefulWidget {
  final int? subjectId;
  final RatingModel? rating;
  const SubjectDetailRatingWidget(
      {super.key, required this.subjectId, required this.rating});

  @override
  State<SubjectDetailRatingWidget> createState() =>
      _SubjectDetailRatingWidgetState();
}

class _SubjectDetailRatingWidgetState extends State<SubjectDetailRatingWidget> {
  late final AutoSizeGroup _autoSizeGroup;

  @override
  void initState() {
    super.initState();
    _autoSizeGroup = AutoSizeGroup();
  }

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.rating != null) ...[
          const SizedBox(height: 8.0),
          Row(
            children: [
              Text.rich(
                TextSpan(
                  text: TextConstant.rating.getString(context),
                  children: [
                    TextSpan(
                      text: ' ${widget.rating?.score}',
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
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: ColorConstant.starColor,
                ),
                child: Text(
                  '${widget.rating?.rank}',
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
                onPressed: () {
                  if (widget.subjectId == null) {
                    CommonHelper.showToast(
                        TextConstant.invalidURL.getString(context));
                    return;
                  }
                  final url = 'https://netaba.re/subject/${widget.subjectId}';
                  CommonHelper.showInBrowser(context: context, url: url);
                },
                child: Row(
                  children: [
                    AutoSizeText(
                      TextConstant.trend.getString(context),
                      group: _autoSizeGroup,
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 14.0),
                      stepGranularity: 0.1,
                      minFontSize: 12.0,
                      maxFontSize: 14.0,
                    ),
                    const Icon(
                      Icons.open_in_new_outlined,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  if (widget.subjectId == null) {
                    CommonHelper.showToast(
                        TextConstant.invalidURL.getString(context));
                    return;
                  }
                  final url =
                      'https://bgm.tv/subject/${widget.subjectId}/stats';
                  CommonHelper.showInBrowser(context: context, url: url);
                },
                child: Row(
                  children: [
                    AutoSizeText(
                      TextConstant.perspective.getString(context),
                      group: _autoSizeGroup,
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 14.0),
                      stepGranularity: 0.1,
                      minFontSize: 12.0,
                      maxFontSize: 14.0,
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
              '${widget.rating?.total} ${TextConstant.rating.getString(context)}',
              style: const TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
          ),
          CustomRatingChartWidget(rating: widget.rating!),
          Row(
            children: [
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     '${TextConstant.userRating.getString(context)} >',
              //     style: const TextStyle(
              //       color: Colors.grey,
              //       fontSize: 12.0,
              //     ),
              //   ),
              // ),
              const Spacer(),
              GestureDetector(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text.rich(
                        TextSpan(
                          text:
                              TextConstant.standardDeviation.getString(context),
                          children: [
                            TextSpan(
                              text:
                                  _getStandardDeviation(widget.rating!.count!),
                              style: const TextStyle(
                                  color: ColorConstant.themeColor),
                            ),
                            // const TextSpan(
                            //   text: '基本一致',
                            //   style: TextStyle(color: Colors.grey),
                            // ),
                          ],
                        ),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
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
