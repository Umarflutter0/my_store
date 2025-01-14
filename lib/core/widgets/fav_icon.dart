import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test/models/product_model.dart';
import 'package:test/providers/ProductsProvider/products_provider.dart';

import '../constants/app_colors.dart';

class FavIcon extends StatelessWidget {
  const FavIcon({
    super.key,
    required this.provider,
    required this.product,
    this.size,
  });

  final ProductProvider provider;
  final ProductModel product;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        provider.isFavorite(product.id) // Check favorite status by ID
            ? Icons.favorite
            : Icons.favorite_border_rounded,
        size: size ?? 9.w,
        color: provider.isFavorite(product.id)
            ? AppColors.redPrimary
            : AppColors.blackPrimary,
      ),
      onPressed: () {
        provider.toggleFavorite(product); // Pass the full product model
      },
    );
  }
}
