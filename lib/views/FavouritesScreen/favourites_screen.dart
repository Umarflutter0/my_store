import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:test/providers/ProductsProvider/products_provider.dart';

import '../../core/widgets/app_search_box.dart';
import '../../core/widgets/total_results_text.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Consumer<ProductProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSearchBox(),
            SizedBox(height: 1.25.h),
            TotalResultsText(
              count: provider.favoriteProducts.length.toString(),
            ),
          ],
        );
      }),
    );
  }
}
