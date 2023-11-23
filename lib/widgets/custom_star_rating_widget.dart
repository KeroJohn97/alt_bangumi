import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

class CustomStarRatingWidget extends StatelessWidget {
  final int rating; // the rating value from 0 to 10
  final double size; // the size of each star icon
  final Color color; // the color of the filled star icon

  const CustomStarRatingWidget({
    super.key,
    this.rating = 0,
    this.size = 24.0,
    this.color = ColorConstant.starColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating / 2
              ? // use half of the rating value to determine the number of filled stars
              rating % 2 == 1 &&
                      index ==
                          rating ~/
                              2 // check if the rating is odd and the current index is equal to the half of the rating
                  ? Icons.star_half // use the half star icon
                  : Icons.star // use the full star icon
              : Icons.star_border, // use the empty star icon
          size: size,
          color: color,
        );
      }),
    );
  }
}
