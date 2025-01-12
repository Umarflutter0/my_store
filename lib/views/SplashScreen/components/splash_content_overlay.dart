import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class SplashContentOverlay extends StatelessWidget {
  const SplashContentOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0x000C0C0C),
            Color(0xE60C0C0C),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Spacer(flex: 1),
          Text(
            AppStrings.myStore,
            style: AppTextStyles.h1(
              fontWeight: FontWeight.w400,
              fontSize: 28,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5.5.h),
          Spacer(flex: 6),
          // SizedBox(height: 2.h),
          Text(
            AppStrings.valkommen,
            style: AppTextStyles.h2(color: Colors.white),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              AppStrings.intro,
              style: AppTextStyles.b1(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 7.h),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
