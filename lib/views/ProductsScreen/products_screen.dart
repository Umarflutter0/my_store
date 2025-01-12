// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:test/core/widgets/rating_bar.dart';
// import 'package:test/core/widgets/total_results_text.dart';
//
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_strings.dart';
// import '../../core/constants/app_text_styles.dart';
// import '../../core/utils/app_utils.dart';
// import '../../core/widgets/app_search_box.dart';
//
// class ProductsScreen extends StatelessWidget {
//   const ProductsScreen({super.key});
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
//           TotalResultsText(
//             count: AppStrings.resultsFound,
//           ),
//           ListView.builder(
//             shrinkWrap: true,
//             itemCount: 2,
//             padding: EdgeInsets.only(bottom: 2.h),
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return Container(
//                 // constraints: BoxConstraints.expand(height: 15.h),
//                 margin: EdgeInsets.only(top: 2.h),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: AppUtils.getColorWithOpacity(
//                         color: AppColors.blackPrimary, opacity: 0.05),
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(6),
//                     bottomRight: Radius.circular(6),
//                   ),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 4.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.asset(
//                       'assets/images/img.png',
//                       height: 25.h,
//                       width: 100.w,
//                       fit: BoxFit.cover,
//                     ),
//                     SizedBox(height: 2.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Iphone 14',
//                           style: AppTextStyles.h2(),
//                         ),
//                         Text(
//                           '\$60',
//                           style: AppTextStyles.h2(
//                             fontSize: 16.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           '4.9',
//                           style: AppTextStyles.h2(
//                             fontSize: 13,
//                             lineHeight: 1.25,
//                           ),
//                         ),
//                         RatingBar(rating: 4.9)
//                       ],
//                     ),
//                     SizedBox(height: 1.h),
//                     Text(
//                       'By ${AppStrings.brand}',
//                       style: AppTextStyles.b1(color: AppColors.blackSecondary),
//                     ),
//                     SizedBox(height: 1.7.h),
//                     Text(
//                       'In smartphones',
//                       style: AppTextStyles.b1(),
//                     ),
//                     SizedBox(height: 2.h),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/widgets/app_search_box.dart';
import '../../core/widgets/total_results_text.dart';
import '../../providers/ProductsProvider/products_provider.dart';
import 'components/product_box.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProductProvider()..fetchProducts(),
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            if (productProvider.isLoading && productProvider.products.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent &&
                    !productProvider.isLoading) {
                  productProvider.fetchProducts(isLoadMore: true);
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
                      count: productProvider.totalProducts.toString(),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: productProvider.products.length +
                          (productProvider.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == productProvider.products.length) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final product = productProvider.products[index];
                        return ProductBox(product: product);
                      },
                    ),
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
