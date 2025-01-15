import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/app_search_box.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/loader.dart';
import '../../core/widgets/total_results_text.dart';
import '../../providers/ProductsProvider/products_provider.dart';
import '../ProductsScreen/components/product_box.dart';

class ProductsFromCategoriesS extends StatelessWidget {
  final Map<String, dynamic> values;

  const ProductsFromCategoriesS({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Scaffold(
      appBar: customAppBar(
        title: values['category'],
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) =>
            ProductProvider()..fetchProducts(endPoint: values['endPoint']),
        child: RefreshIndicator(
          color: AppColors.blackPrimary,
          onRefresh: () async {
            await ProductProvider().fetchProducts(endPoint: values['endPoint']);
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
                        isLoadMore: true, endPoint: values['endPoint']);
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
                        count: productProvider.totalProducts.toString(),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: productProvider.filteredProducts.length +
                            (productProvider.isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index ==
                              productProvider.filteredProducts.length) {
                            return Loader();
                          }
                          final product =
                              productProvider.filteredProducts[index];
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
      ),
    );
  }
}
