import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/network/api_interceptor.dart';
import '../../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final ApiInterceptor _apiInterceptor =
      ApiInterceptor(baseUrl: 'https://dummyjson.com/products');
  List<ProductModel> _products = [];
  final List<ProductModel> _favoriteProducts = [];
  String _searchQuery = ''; // Search query
  bool _isLoading = false;
  int _currentPage = 0;
  final int _limit = 10;
  int _totalProducts = 0;
  String _favoriteSearchQuery = ''; // Search query for favorites

  List<ProductModel> get filteredFavoriteProducts => _favoriteProducts
      .where((product) => product.title
          .toLowerCase()
          .contains(_favoriteSearchQuery.toLowerCase()))
      .toList();

  // Set search query for favorite products and notify listeners

  List<ProductModel> get products => _products
      .where((product) =>
          product.title.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  bool get isLoading => _isLoading;

  int get totalProducts => _totalProducts;

  List<ProductModel> get favoriteProducts => _favoriteProducts;

  // Set search query and notify listeners
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

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

  // Toggle favorite status by comparing product ID
  void toggleFavorite(ProductModel product) {
    int index = _favoriteProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _favoriteProducts.removeAt(index); // Remove if found
    } else {
      _favoriteProducts.add(product); // Add if not found
    }
    notifyListeners();
  }

  // Check if a product is marked as favorite
  bool isFavorite(int productId) {
    return _favoriteProducts.any((product) => product.id == productId);
  }

  void setFavoriteSearchQuery(String query) {
    _favoriteSearchQuery = query;
    notifyListeners();
  }
}
