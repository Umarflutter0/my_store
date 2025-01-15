import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/network/api_interceptor.dart';
import '../../models/category_model.dart';

//
// class CategoryProvider with ChangeNotifier {
//   final ApiInterceptor _apiInterceptor =
//       ApiInterceptor(baseUrl: 'https://dummyjson.com');
//   List<CategoryModel> _categories = [];
//   bool _isLoading = false;
//   int _totalCategories = 0;
//
//   // Lazy loading variables
//   int _currentPage = 0;
//   final int _limit = 10;
//   bool _hasMore = true; // To check if more data is available
//
//   List<CategoryModel> get categories => _categories;
//
//   bool get isLoading => _isLoading;
//
//   int get totalCategories => _totalCategories;
//
//   bool get hasMore => _hasMore;
//
//   Future<void> fetchCategories({bool isLoadMore = false}) async {
//     if (_isLoading || !_hasMore) return;
//
//     _isLoading = true;
//     notifyListeners();
//
//     final endPoint = '/products/categories';
//     try {
//       final response = await _apiInterceptor.get(
//           endPoint: '${_apiInterceptor.baseUrl}$endPoint');
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         List<CategoryModel> allCategories =
//             (data as List).map((item) => CategoryModel.fromJson(item)).toList();
//
//         _totalCategories = allCategories.length;
//
//         int startIndex = _currentPage * _limit;
//         int endIndex = startIndex + _limit;
//
//         if (startIndex < _totalCategories) {
//           List<CategoryModel> newCategories = allCategories.sublist(startIndex,
//               endIndex > _totalCategories ? _totalCategories : endIndex);
//
//           if (isLoadMore) {
//             _categories.addAll(newCategories);
//           } else {
//             _categories = newCategories;
//           }
//
//           _currentPage++;
//
//           if (_categories.length >= _totalCategories) {
//             _hasMore = false; // No more data to load
//           }
//         }
//       }
//     } catch (error) {
//       // Handle error using ErrorHandler
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

class CategoryProvider with ChangeNotifier {
  final ApiInterceptor _apiInterceptor =
      ApiInterceptor(baseUrl: 'https://dummyjson.com');
  List<CategoryModel> _categories = [];
  List<CategoryModel> _filteredCategories = [];
  bool _isLoading = false;
  int _totalCategories = 0;

  // Lazy loading variables
  int _currentPage = 0;
  final int _limit = 10;
  bool _hasMore = true;

  List<CategoryModel> get categories => _categories;

  List<CategoryModel> get filteredCategories => _filteredCategories;

  bool get isLoading => _isLoading;

  int get totalCategories => _totalCategories;

  bool get hasMore => _hasMore;

  CategoryProvider() {
    fetchCategories();
  }

  Future<void> fetchCategories({bool isLoadMore = false}) async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    final endPoint = '/products/categories';
    try {
      final response = await _apiInterceptor.get(
          endPoint: '${_apiInterceptor.baseUrl}$endPoint');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List<CategoryModel> allCategories =
            (data as List).map((item) => CategoryModel.fromJson(item)).toList();

        _totalCategories = allCategories.length;

        int startIndex = _currentPage * _limit;
        int endIndex = startIndex + _limit;

        if (startIndex < _totalCategories) {
          List<CategoryModel> newCategories = allCategories.sublist(startIndex,
              endIndex > _totalCategories ? _totalCategories : endIndex);

          if (isLoadMore) {
            _categories.addAll(newCategories);
          } else {
            _categories = newCategories;
          }

          _filteredCategories = _categories; // Initialize filtered list
          _currentPage++;

          if (_categories.length >= _totalCategories) {
            _hasMore = false;
          }
        }
      }
    } catch (error) {
      // Handle error using ErrorHandler
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterCategories(String query) {
    if (query.isEmpty) {
      _filteredCategories = _categories;
    } else {
      _filteredCategories = _categories
          .where((category) =>
              category.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
