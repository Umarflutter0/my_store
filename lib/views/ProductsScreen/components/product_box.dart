import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:test/config/routes/routes_names.dart';
import 'package:test/core/widgets/shimmer_cached_image.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/widgets/rating_bar.dart';
import '../../../models/product_model.dart';

class ProductBox extends StatelessWidget {
  const ProductBox({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RoutesName.productDetails, extra: product);
      },
      child: Container(
        margin: EdgeInsets.only(top: 2.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppUtils.getColorWithOpacity(
                color: AppColors.blackPrimary, opacity: 0.05),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerCachedImage(
              imageUrl: product.thumbnail,
              height: 25.h,
              width: 100.w,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    product.title,
                    style: AppTextStyles.h2(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 2.w),
                Text(
                  '\$${product.price}',
                  style: AppTextStyles.h2(
                    fontSize: 16.5,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  product.rating.toString(),
                  style: AppTextStyles.h2(
                    fontSize: 13,
                    lineHeight: 1.25,
                  ),
                ),
                RatingBar(rating: product.rating)
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              'By ${product.brand}',
              style: AppTextStyles.b1(color: AppColors.blackSecondary),
            ),
            SizedBox(height: 1.7.h),
            Text(
              'In ${product.category}',
              style: AppTextStyles.b1(),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
