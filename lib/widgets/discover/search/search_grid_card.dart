import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/models/rating_model.dart';
import 'package:alt_bangumi/screens/subject_detail_screen.dart';
import 'package:alt_bangumi/widgets/custom_star_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../models/search_model/search_info_model.dart';
import '../../custom_network_image_widget.dart';

class SearchGridCard extends StatelessWidget {
  final SearchInfoModel info;
  final bool disable;
  const SearchGridCard({
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _navigate(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomNetworkImageWidget(
              height: 150,
              width: 100,
              imageUrl: info.images?.large,
              radius: 8.0,
              boxFit: BoxFit.cover,
              onTap: disable ? () => _navigate(context) : null,
            ),
            Container(
              height: 40.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                '${(info.nameCn?.isEmpty ?? true) ? TextConstant.withoutAName.getString(context) : info.nameCn.showHTML()}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: RatingsRow(
                rating: info.rating,
                rank: info.rank,
                showTotal: false,
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
  final bool showTotal;
  const RatingsRow({
    super.key,
    required this.rating,
    required this.rank,
    this.showTotal = true,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (rank != null && showTotal)
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
          '${rating!.score} ${showTotal ? context.formatString(
              TextConstant.inputPeopleRatings.getString(context),
              [rating?.total],
            ) : ''}',
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
