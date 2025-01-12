import 'dart:convert';

// class ProductProvider with ChangeNotifier {
//   final ApiInterceptor _apiInterceptor =
//       ApiInterceptor(baseUrl: 'https://dummyjson.com');
//   List<ProductModel> _products = [];
//   bool _isLoading = false;
//   int _currentPage = 0;
//   final int _limit = 10;
//
//   List<ProductModel> get products => _products;
//
//   bool get isLoading => _isLoading;
//
//   Future<void> fetchProducts({bool isLoadMore = false}) async {
//     if (_isLoading) return;
//
//     _isLoading = true;
//     notifyListeners();
//
//     final endPoint = '/products?limit=100';
//     try {
//       final response = await _apiInterceptor.get(
//           endPoint: '${_apiInterceptor.baseUrl}$endPoint');
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/network/api_interceptor.dart';
import '../../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final ApiInterceptor _apiInterceptor =
      ApiInterceptor(baseUrl: 'https://dummyjson.com');
  List<ProductModel> _products = [];
  bool _isLoading = false;
  int _currentPage = 0;
  final int _limit = 10;
  int _totalProducts = 0; // New variable to store total products count

  List<ProductModel> get products => _products;

  bool get isLoading => _isLoading;

  int get totalProducts => _totalProducts; // Getter for total products count

  Future<void> fetchProducts({bool isLoadMore = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    final endPoint = '/products?limit=100';
    try {
      final response = await _apiInterceptor.get(
          endPoint: '${_apiInterceptor.baseUrl}$endPoint');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract total products count from API response
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
      // Handle error using ErrorHandler
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
