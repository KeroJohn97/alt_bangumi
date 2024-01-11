import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';
import 'package:flutter/material.dart';

class RankingLoadingWidget extends StatelessWidget {
  final double horizontalPadding;
  const RankingLoadingWidget({super.key, this.horizontalPadding = 8.0});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: 12.0,
              left: horizontalPadding,
              right: horizontalPadding,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomShimmerWidget(
                  height: 150,
                  width: 100,
                  radius: 8.0,
                ),
                Expanded(
                  child: Container(
                    height: 18.h,
                    padding: const EdgeInsets.only(left: 12.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomShimmerWidget(height: 20.0),
                                  SizedBox(height: 5.0),
                                  CustomShimmerWidget(height: 20.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: CustomShimmerWidget(height: 45.0),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: CustomShimmerWidget(height: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
