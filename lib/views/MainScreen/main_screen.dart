import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../providers/BottomNavProvider/bottom_nav_provider.dart';
import '../CategoriesScreen/categories_screen.dart';
import '../FavouritesScreen/favourites_screen.dart';
import '../ProductsScreen/products_screen.dart';
import '../ProfileScreen/profile_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final pages = [
    ProductsScreen(
      values: {'endPoint': '', 'category': ''},
    ),
    CategoriesScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Consumer<BottomNavProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: pages[provider.selectedIndex],
          );
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(7),
          topLeft: Radius.circular(7),
        ),
        child: Container(
          constraints: BoxConstraints.expand(height: 10.h),
          color: Colors.black,
          child: Row(
            children: List.generate(
              AppStrings.navbarItems.length,
              (index) => navItem(
                context,
                svg: AppAssets.icons.navbarIcons[index],
                index: index,
                label: AppStrings.navbarItems[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded navItem(
    BuildContext context, {
    required String svg,
    required int index,
    required String label,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<BottomNavProvider>().setSelectedIndex(index);
        },
        child: Consumer<BottomNavProvider>(
          builder: (context, provider, child) {
            bool isSelected = provider.selectedIndex == index;

            return Container(
              color: isSelected ? Colors.white10 : Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    svg,
                    width: index == 3 ? 4.5.w : 6.5.w,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    label,
                    style: AppTextStyles.b1(
                        color: AppColors.whiteSecondary, fontSize: 11),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
