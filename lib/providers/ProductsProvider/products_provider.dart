import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/network/api_interceptor.dart';
import '../../models/product_model.dart';

//
// class ProductProvider with ChangeNotifier {
//   final ApiInterceptor _apiInterceptor =
//       ApiInterceptor(baseUrl: 'https://dummyjson.com/products');
//   List<ProductModel> _products = [];
//   bool _isLoading = false;
//   int _currentPage = 0;
//   final int _limit = 10;
//   int _totalProducts = 0; // New variable to store total products count
//
//   List<ProductModel> get products => _products;
//
//   bool get isLoading => _isLoading;
//
//   int get totalProducts => _totalProducts;
//
//   Future<void> fetchProducts(
//       {bool isLoadMore = false, required String endPoint}) async {
//     if (_isLoading) return;
//
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await _apiInterceptor.get(
//           endPoint: '${_apiInterceptor.baseUrl}/$endPoint');
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         // Extract total products count from API response
//         _totalProducts = data['total'];
//
//         List<ProductModel> newProducts = (data['products'] as List)
//             .map((item) => ProductModel.fromJson(item))
//             .toList();
//
//         if (isLoadMore) {
//           _products
//               .addAll(newProducts.skip(_currentPage * _limit).take(_limit));
//         } else {
//           _products = newProducts.take(_limit).toList();
//         }
//         _currentPage++;
//       }
//     } catch (error) {
//       // Handle error using ErrorHandler
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

class ProductProvider with ChangeNotifier {
  final ApiInterceptor _apiInterceptor =
      ApiInterceptor(baseUrl: 'https://dummyjson.com/products');
  List<ProductModel> _products = [];
  bool _isLoading = false;
  int _currentPage = 0;
  final int _limit = 10;
  int _totalProducts = 0;
  List<ProductModel> _favoriteProducts = []; // Add a list for favorite products

  List<ProductModel> get products => _products;

  bool get isLoading => _isLoading;

  int get totalProducts => _totalProducts;

  List<ProductModel> get favoriteProducts =>
      _favoriteProducts; // Getter for favorite products

  Future<void> fetchProducts(
      {bool isLoadMore = false, required String endPoint}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiInterceptor.get(
          endPoint: '${_apiInterceptor.baseUrl}/$endPoint');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _totalProducts = data['total'];

        List<ProductModel> newProducts = (data['products'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();

        if (isLoadMore) {
          _products
              .addAll(newProducts.skip(_currentPage * _limit).take(_limit));
        } else {
          _products = newProducts.take(_limit).toList();
        }
        _currentPage++;
      }
    } catch (error) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Toggle favorite status for a product
  void toggleFavorite(ProductModel product) {
    if (_favoriteProducts.contains(product)) {
      _favoriteProducts.remove(product); // Remove if already favorite
    } else {
      _favoriteProducts.add(product); // Add if not favorite
    }
    notifyListeners(); // Notify listeners for UI update
  }
}
