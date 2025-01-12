import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class TotalResultsText extends StatelessWidget {
  const TotalResultsText({super.key, required this.count});

  final String count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.5.w),
      child: Text(
        '$count results found',
        style: AppTextStyles.b1(color: AppColors.blackSecondary),
      ),
    );
  }
}
