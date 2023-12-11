import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../constants/color_constant.dart';

class CalendarLoadingWidget extends StatelessWidget {
  const CalendarLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: SizedBox.shrink(),
          title: CustomShimmerWidget(height: 15.0, width: 20.0),
          leadingWidth: 0.0,
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 16.0),
          sliver: SliverAlignedGrid.count(
            crossAxisCount: 3,
            itemCount: 12,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 18.h + 80.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerWidget(
                      height: 18.h,
                      width: 28.w,
                      radius: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, top: 4.0, bottom: 4.0),
                      child: CustomShimmerWidget(height: 15.0, width: 28.w),
                    ),
                    const SizedBox(height: 4.0),
                    CustomShimmerWidget(height: 10.0, width: 20.w),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: CustomShimmerWidget(height: 8.0, width: 20.w),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.star,
                            color: ColorConstant.starColor,
                            size: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
