import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';
import 'package:flutter/material.dart';

class TagLoadingWidget extends StatelessWidget {
  const TagLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: 32,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.all(4.0),
          child: CustomShimmerWidget(radius: 4.0),
        );
        // return Card(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //         child: Text(
        //           '${e.name}',
        //           style: const TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 12.0,
        //           ),
        //           maxLines: 3,
        //           overflow: TextOverflow.ellipsis,
        //           textAlign: TextAlign.center,
        //         ),
        //       ),
        //       Text(
        //         '${value != null ? value.showInUnit() : e.count}',
        //         maxLines: 1,
        //         overflow: TextOverflow.ellipsis,
        //         textAlign: TextAlign.center,
        //         style: const TextStyle(fontSize: 10.0),
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }
}
