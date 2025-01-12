import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';

class AppSearchBox extends StatelessWidget {
  const AppSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 4.5.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blackPrimary, width: 1.5),
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: AppColors.blackSecondary),
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,

          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
          ), // Padding inside field
        ),
      ),
    );
  }
}
