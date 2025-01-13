import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:test/core/widgets/custom_app_bar.dart';

import '../../core/widgets/app_search_box.dart';
import '../../core/widgets/total_results_text.dart';
import '../../providers/ProductsProvider/products_provider.dart';
import 'components/product_box.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.values});

  final Map<String, dynamic> values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: values['endPoint'].isEmpty
          ? null
          : customAppBar(title: values['category']),
      body: ChangeNotifierProvider(
        create: (_) => ProductProvider()
          ..fetchProducts(
              endPoint: values['endPoint'].isEmpty
                  ? '?limit=100'
                  : values['endPoint']),
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
