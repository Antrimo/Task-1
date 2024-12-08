import 'package:flutter/material.dart';
import '../data/product_api_service.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  List<Product> get products => _products;
  List<Product> _filteredProducts = [];
  List<Product> get filteredProducts => _filteredProducts;

  String _searchQuery = '';
  String _selectedCategory = '';

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  Future<void> loadProducts() async {
    try {
      _products = await _apiService.fetchProducts();
      _filteredProducts = _products;
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void search(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredProducts = _products.where((product) {
      final matchesSearch = product.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory.isEmpty || product.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
    notifyListeners();
  }
}
