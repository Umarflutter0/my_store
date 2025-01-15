import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:test/core/constants/app_colors.dart';
import 'package:test/core/widgets/custom_app_bar.dart';
import 'package:test/core/widgets/loader.dart';

import '../../core/widgets/app_search_box.dart';
import '../../core/widgets/total_results_text.dart';
import '../../providers/ProductsProvider/products_provider.dart';
import 'components/product_box.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.values});

  final Map<String, dynamic> values;

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Scaffold(
      appBar: values['endPoint'].isEmpty
          ? null
          : customAppBar(
              title: values['category'],
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
      body: RefreshIndicator(
        color: AppColors.blackPrimary,
        onRefresh: () async {
          await ProductProvider().fetchProducts(endPoint: '?limit=100');
        },
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            if (productProvider.isLoading &&
                productProvider.filteredProducts.isEmpty) {
              return Loader();
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent &&
                    !productProvider.isLoading) {
                  productProvider.fetchProducts(
                      isLoadMore: true,
                      endPoint: values['endPoint'].isEmpty
                          ? '?limit=100'
                          : values['endPoint']);
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
                      onSearchChanged: productProvider.setSearchQuery,
                    ),
                    SizedBox(height: 1.25.h),
                    TotalResultsText(
                      count: productProvider.filteredProducts.length.toString(),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productProvider.filteredProducts.length +
                          (productProvider.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == productProvider.filteredProducts.length) {
                          return Loader();
                        }
                        final product = productProvider.filteredProducts[index];
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
