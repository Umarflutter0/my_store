import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double? starSize;
  final Color? filledStarColor;
  final Color unfilledStarColor;

  const RatingBar({
    super.key,
    required this.rating,
    this.starSize,
    this.filledStarColor,
    this.unfilledStarColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          if (index < rating.floor()) {
            return Icon(
              Icons.star,
              size: starSize ?? 4.w,
              color: filledStarColor ?? AppColors.rating,
            );
          } else if (index < rating && rating % 1 != 0) {
            return Icon(
              Icons.star_half,
              size: starSize ?? 4.w,
              color: filledStarColor ?? AppColors.rating,
            );
          } else {
            return Icon(
              Icons.star_border,
              size: starSize ?? 4.w,
              color: unfilledStarColor,
            );
          }
        },
      ),
    );
  }
}
