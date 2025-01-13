import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:test/core/constants/app_colors.dart';
import 'package:test/core/constants/app_strings.dart';
import 'package:test/core/constants/app_text_styles.dart';
import 'package:test/core/widgets/custom_app_bar.dart';
import 'package:test/core/widgets/rating_bar.dart';
import 'package:test/core/widgets/shimmer_cached_image.dart';
import 'package:test/models/product_model.dart';

import '../../providers/ProductsProvider/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: AppStrings.productDetails,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            ShimmerCachedImage(
              imageUrl: product.thumbnail,
              height: 25.h,
              width: 100.w,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 3.h),
            ProductDetails(
              product: product,
            )
          ],
        ),
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ProductProvider>(context); // Access ProductProvider

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppStrings.productDetails}:",
                style: AppTextStyles.h2(fontSize: 18),
              ),
              IconButton(
                icon: Icon(
                  provider.favoriteProducts.contains(product)
                      ? Icons.favorite
                      : Icons.favorite_border_rounded,
                  size: 9.w,
                  color: provider.favoriteProducts.contains(product)
                      ? AppColors.redPrimary
                      : AppColors.blackPrimary,
                ),
                onPressed: () {
                  provider.toggleFavorite(product); // Toggle favorite status
                },
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          ProductInfoRow(title: 'Name :', value: product.title),
          ProductInfoRow(title: 'Price :', value: '\$ ${product.price}'),
          ProductInfoRow(title: 'Category :', value: product.category),
          ProductInfoRow(title: 'Brand :', value: product.brand),
          ProductInfoRow(
            title: 'Rating :',
            value: product.rating.toString(),
            rating: true,
          ),
          ProductInfoRow(title: 'Stock :', value: product.stock.toString()),
          Text(
            AppStrings.description,
            style: AppTextStyles.h2(),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.only(left: 1.w),
            child: Text(
              product.description,
              style: AppTextStyles.b1(),
            ),
          )
        ],
      ),
    );
  }
}

class ProductInfoRow extends StatelessWidget {
  const ProductInfoRow({
    super.key,
    required this.title,
    required this.value,
    this.rating = false,
  });

  final String title;
  final String value;
  final bool rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.h2(),
          ),
          SizedBox(width: 3.w),
          Text(
            value,
            style: AppTextStyles.b1(),
          ),
          if (rating) SizedBox(width: 1.5.w),
          if (rating) RatingBar(rating: double.tryParse(value)!)
        ],
      ),
    );
  }
}
