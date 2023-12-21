import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/rating_model.dart';
import 'package:alt_bangumi/screens/subject_detail_screen.dart';
import 'package:alt_bangumi/widgets/custom_star_rating_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/enum_constant.dart';
import '../../../models/search_model/search_info_model.dart';
import '../../custom_network_image_widget.dart';

class SearchListCard extends StatelessWidget {
  final SearchInfoModel info;
  final bool disable;
  const SearchListCard({
    super.key,
    required this.info,
    this.disable = false,
  });

  void _navigate(BuildContext context) =>
      context.push(SubjectDetailScreen.route, extra: {
        SubjectDetailScreen.subjectIdKey: info.id,
      });

  @override
  Widget build(BuildContext context) {
    final nameCn =
        '${(info.nameCn?.isEmpty ?? true) ? (info.name?.isEmpty ?? true) ? TextConstant.withoutAName.getString(context) : info.name : info.nameCn.showHTML()}';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _navigate(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImageWidget(
              height: 150,
              width: 100,
              imageUrl: info.images?.large,
              radius: 8.0,
              boxFit: BoxFit.cover,
              onTap: disable ? () => _navigate(context) : null,
            ),
            Expanded(
              child: Container(
                height: 18.h,
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nameCn,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${info.name.showHTML()}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: ColorConstant.themeColor),
                            color: ColorConstant.themeColor.withOpacity(0.2),
                          ),
                          child: Text(
                            '${ScreenSubjectOption.values.firstWhereOrNull((element) => element.value == info.type)?.getString(context)}',
                            style: const TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // IconButton(
                        //   onPressed: _toggleFavorite,
                        //   icon: Icon(
                        //     Icons.star_outline,
                        //     color: Colors.grey[400],
                        //   ),
                        //   padding: EdgeInsets.zero,
                        //   visualDensity: VisualDensity.compact,
                        // ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        '${info.airDate}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    RatingsRow(
                      rating: info.rating,
                      rank: info.rank,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingsRow extends StatelessWidget {
  final RatingModel? rating;
  final int? rank;
  const RatingsRow({
    super.key,
    required this.rating,
    required this.rank,
  });

  static const minimumRatings = 10;

  @override
  Widget build(BuildContext context) {
    if ((rating?.total ?? 0) < minimumRatings) {
      return Text(
        context.formatString(
          TextConstant.inputLessThanRatings.getString(context),
          [minimumRatings],
        ),
        style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
      );
    }
    return Row(
      children: [
        if (rank != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: ColorConstant.starColor,
            ),
            child: Text(
              '${rank!}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
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
        const SizedBox(width: 2.0),
        CustomStarRatingWidget(
          size: 12.0,
          rating: rating!.score!.round(),
        ),
        const SizedBox(width: 2.0),
        Text(
          '${rating!.score} ${context.formatString(
            TextConstant.inputPeopleRatings.getString(context),
            [rating?.total],
          )}',
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
