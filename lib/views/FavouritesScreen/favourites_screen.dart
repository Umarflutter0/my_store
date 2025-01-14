import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:test/config/routes/routes_names.dart';
import 'package:test/core/constants/app_colors.dart';
import 'package:test/core/constants/app_text_styles.dart';
import 'package:test/core/utils/app_utils.dart';
import 'package:test/core/widgets/fav_icon.dart';
import 'package:test/core/widgets/rating_bar.dart';
import 'package:test/providers/ProductsProvider/products_provider.dart';

import '../../core/widgets/app_search_box.dart';
import '../../core/widgets/total_results_text.dart';

// class FavouritesScreen extends StatelessWidget {
//   const FavouritesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(horizontal: 6.w),
//       child: Consumer<ProductProvider>(
//         builder: (context, provider, child) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // AppSearchBox(),
//               SizedBox(height: 1.25.h),
//               TotalResultsText(
//                 count: provider.favoriteProducts.length.toString(),
//               ),
//               SizedBox(height: 2.h),
//               ListView.separated(
//                 itemCount: provider.favoriteProducts.length,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   final product = provider.favoriteProducts[index];
//                   return GestureDetector(
//                     onTap: () {
//                       context.push(RoutesName.productDetails, extra: product);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 2.w, vertical: 1.5.h),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             offset: Offset(1, 1),
//                             color: AppUtils.getColorWithOpacity(
//                               color: AppColors.blackPrimary,
//                               opacity: 0.05,
//                             ),
//                           ),
//                           BoxShadow(
//                             offset: Offset(-1, 0),
//                             color: AppUtils.getColorWithOpacity(
//                               color: AppColors.blackPrimary,
//                               opacity: 0.05,
//                             ),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: AppUtils.getColorWithOpacity(
//                               color: Colors.grey,
//                               opacity: 0.1,
//                             ),
//                             radius: 9.w,
//                             backgroundImage: NetworkImage(
//                               product.thumbnail,
//                             ),
//                           ),
//                           SizedBox(width: 3.w),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 width: 40.w,
//                                 child: Text(
//                                   product.title,
//                                   style: AppTextStyles.h2(),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.fade,
//                                 ),
//                               ),
//                               Text(
//                                 '\$${product.price}',
//                                 style: AppTextStyles.h2(),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.fade,
//                               ),
//                               RatingBar(rating: product.rating)
//                             ],
//                           ),
//                           Spacer(),
//                           FavIcon(
//                             provider: provider,
//                             product: product,
//                             size: 7.w,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return SizedBox(height: 3.h);
//                 },
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSearchBox(
                controller: searchController,
                onSearchChanged: (String value) {
                  provider.setFavoriteSearchQuery(value);
                },
              ),
              SizedBox(height: 1.25.h),
              TotalResultsText(
                count: provider.filteredFavoriteProducts.length.toString(),
              ),
              SizedBox(height: 2.h),
              ListView.separated(
                itemCount: provider.filteredFavoriteProducts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = provider.filteredFavoriteProducts[index];
                  return GestureDetector(
                    onTap: () {
                      context.push(RoutesName.productDetails, extra: product);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 1.5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(1, 1),
                            color: AppUtils.getColorWithOpacity(
                              color: AppColors.blackPrimary,
                              opacity: 0.05,
                            ),
                          ),
                          BoxShadow(
                            offset: const Offset(-1, 0),
                            color: AppUtils.getColorWithOpacity(
                              color: AppColors.blackPrimary,
                              opacity: 0.05,
                            ),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppUtils.getColorWithOpacity(
                              color: Colors.grey,
                              opacity: 0.1,
                            ),
                            radius: 9.w,
                            backgroundImage: NetworkImage(
                              product.thumbnail,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 40.w,
                                child: Text(
                                  product.title,
                                  style: AppTextStyles.h2(),
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Text(
                                '\$${product.price}',
                                style: AppTextStyles.h2(),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                              RatingBar(rating: product.rating)
                            ],
                          ),
                          const Spacer(),
                          FavIcon(
                            provider: provider,
                            product: product,
                            size: 7.w,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 3.h);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
