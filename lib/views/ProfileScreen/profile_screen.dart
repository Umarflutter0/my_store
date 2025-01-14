import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:test/core/constants/app_assets.dart';
import 'package:test/core/constants/app_colors.dart';
import 'package:test/core/constants/app_strings.dart';
import 'package:test/core/constants/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.whiteSecondary,
                  radius: 10.w,
                ),
                SizedBox(width: 6.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.myName,
                      style: AppTextStyles.h2(color: Colors.white),
                    ),
                    Text(
                      AppStrings.gmail,
                      style: AppTextStyles.b1(color: Colors.white),
                    ),
                    Text(
                      AppStrings.phone,
                      style: AppTextStyles.b1(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 5.h),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.icons.profileIcons[index]),
                      SizedBox(width: 3.w),
                      Text(
                        AppStrings.profileTexts[index],
                        style: AppTextStyles.b1(fontSize: 16),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 4.h);
              },
              itemCount: AppAssets.icons.profileIcons.length)
        ],
      ),
    );
  }
}
