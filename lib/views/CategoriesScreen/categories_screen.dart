// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:test/core/constants/app_assets.dart';
// import 'package:test/core/constants/app_colors.dart';
// import 'package:test/core/constants/app_text_styles.dart';
// import 'package:test/core/utils/app_utils.dart';
// import 'package:test/core/widgets/total_results_text.dart';
//
// import '../../core/widgets/app_search_box.dart';
//
// class CategoriesScreen extends StatelessWidget {
//   const CategoriesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(horizontal: 6.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AppSearchBox(),
//           SizedBox(height: 1.25.h),
//           TotalResultsText(count: '234'),
//           ProductsGrid(
//             products: [
//               {'title': 'Laptops', 'image': AppAssets.images.img},
//               {'title': 'Naglar', 'image': 'assets/images/image 4.png'},
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:test/core/constants/app_assets.dart';
import 'package:test/core/constants/app_colors.dart';
import 'package:test/core/constants/app_text_styles.dart';
import 'package:test/core/widgets/total_results_text.dart';
import 'package:test/models/category_model.dart';

import '../../core/utils/app_utils.dart';
import '../../core/widgets/app_search_box.dart';
import '../../providers/CategoryProvider/category_provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CategoryProvider()..fetchCategories(),
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) {
            // Loading indicator if no categories are loaded yet
            if (categoryProvider.isLoading &&
                categoryProvider.categories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                // Lazy loading logic when the user reaches the bottom
                if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent &&
                    !categoryProvider.isLoading &&
                    categoryProvider.hasMore) {
                  categoryProvider.fetchCategories(isLoadMore: true);
                }
                return false;
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSearchBox(),
                    SizedBox(height: 1.25.h),
                    TotalResultsText(
                      count: categoryProvider.totalCategories.toString(),
                    ),
                    ProductsGrid(products: categoryProvider.categories),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  final List<CategoryModel> products;

  const ProductsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.5.h,
        crossAxisSpacing: 6.w,
        childAspectRatio: 1,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(AppAssets.images.img),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    AppUtils.getColorWithOpacity(
                      color: AppColors.blackPrimary,
                      opacity: 0.25,
                    ),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.w, bottom: 2.5.h, right: 2.w),
              child: Text(
                product.name,
                style: AppTextStyles.h2(
                  color: AppColors.whiteSecondary,
                  fontSize: 13,
                ),
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
