import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/BottomNavProvider/bottom_nav_provider.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';

AppBar customAppBar({
  Widget? leading,
  String? title,
}) {
  return AppBar(
    elevation: 0,
    scrolledUnderElevation: 0,
    leading: leading,
    centerTitle: true,
    title: Consumer<BottomNavProvider>(
      builder: (context, provider, child) {
        return Text(
          title ?? AppStrings.navbarItems[provider.selectedIndex],
          style: AppTextStyles.h1(),
        );
      },
    ),
  );
}
