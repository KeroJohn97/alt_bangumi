import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';
import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';
import 'package:alt_bangumi/widgets/subject_detail_image_widget.dart';
import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

class SubjectDetailTitleWidget extends StatelessWidget {
  final SubjectModel? subject;
  final double extraHeight;
  const SubjectDetailTitleWidget({
    super.key,
    required this.subject,
    required this.extraHeight,
  });

  @override
  Widget build(BuildContext context) {
    final nameCn = subject?.nameCn?.isNotEmpty ?? false
        ? subject?.nameCn
        : subject?.name ?? '';
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          SubjectDetailImageWidget(imageUrl: subject?.images?.large),
          const SizedBox(width: 8.0),
          Expanded(
            child: SizedBox(
              height: 160.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  if (nameCn!.isEmpty) ...[
                    const CustomShimmerWidget(height: 20.0),
                    const SizedBox(height: 8.0),
                    const CustomShimmerWidget(height: 20.0),
                    const SizedBox(height: 8.0),
                    CustomShimmerWidget(height: 15.0, width: 40.w),
                    const SizedBox(height: 8.0),
                    CustomShimmerWidget(height: 15.0, width: 40.w),
                    const Spacer(),
                    const CustomShimmerWidget(height: 25.0, width: 40.0),
                  ],
                  if (nameCn.isNotEmpty) ...[
                    Text.rich(
                      TextSpan(
                        text: nameCn,
                        children: [
                          TextSpan(
                              text: subject?.date == null
                                  ? ''
                                  : '(${subject?.date})',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                              )),
                        ],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Text(
                      subject?.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    if (subject?.rating?.score != null)
                      Text(
                        '${subject?.rating?.score} / 10.0',
                        style: const TextStyle(
                          color: ColorConstant.themeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                  ],
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
