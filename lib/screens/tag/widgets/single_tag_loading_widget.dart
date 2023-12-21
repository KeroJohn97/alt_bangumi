import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';
import 'package:flutter/material.dart';

class SingleTagLoadingWidget extends StatelessWidget {
  const SingleTagLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0, left: 8.0, right: 8.0),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  CustomShimmerWidget(height: 20.0),
                                  SizedBox(height: 5.0),
                                  CustomShimmerWidget(height: 20.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: CustomShimmerWidget(height: 45.0),
                        ),
                        const Spacer(),
                        const Padding(
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
