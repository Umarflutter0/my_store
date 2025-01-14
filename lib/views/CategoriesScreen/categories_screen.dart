import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:test/config/routes/routes_names.dart';
import 'package:test/core/constants/app_assets.dart';
import 'package:test/core/constants/app_colors.dart';
import 'package:test/core/constants/app_text_styles.dart';
import 'package:test/core/widgets/total_results_text.dart';
import 'package:test/models/category_model.dart';

import '../../core/utils/app_utils.dart';
import '../../core/widgets/app_search_box.dart';
import '../../core/widgets/loader.dart';
import '../../providers/CategoryProvider/category_provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return ChangeNotifierProvider(
      create: (_) => CategoryProvider()..fetchCategories(),
      child: RefreshIndicator(
        color: AppColors.blackPrimary,
        onRefresh: () async {
          await CategoryProvider().fetchCategories();
        },
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) {
            if (categoryProvider.isLoading &&
                categoryProvider.filteredCategories.isEmpty) {
              return Loader();
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
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
                    AppSearchBox(
                      controller: searchController,
                      onSearchChanged: (String value) {
                        categoryProvider.filterCategories(value);
                      },
                    ),
                    SizedBox(height: 1.25.h),
                    TotalResultsText(
                      count:
                          categoryProvider.filteredCategories.length.toString(),
                    ),
                    ProductsGrid(products: categoryProvider.filteredCategories),
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
            GestureDetector(
              onTap: () {
                context.push(RoutesName.productsScreen, extra: {
                  'url': AppUtils.extractCategoryEndpoint(product.url),
                  'category': product.name
                });
              },
              child: Container(
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
