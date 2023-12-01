import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';
import 'package:flutter/material.dart';

class AnimeLoadingComponent extends StatelessWidget {
  const AnimeLoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomShimmerWidget(
          height: 500.0,
          width: 100.w,
          borderRadius: 8.0,
        ),
        const SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CustomShimmerWidget(
                height: 150.0,
                width: 30.w,
                borderRadius: 8.0,
              ),
              const SizedBox(width: 12.0),
              CustomShimmerWidget(
                height: 150.0,
                width: 30.w,
                borderRadius: 8.0,
              ),
              const SizedBox(width: 12.0),
              CustomShimmerWidget(
                height: 150.0,
                width: 30.w,
                borderRadius: 8.0,
              )
            ],
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
