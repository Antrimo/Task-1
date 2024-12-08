import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  final String apiUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products (offline issue): $e');
      rethrow;
    }
  }
}
