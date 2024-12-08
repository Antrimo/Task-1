import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/search_filter_bar.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<void> _loadProductsFuture;

  @override
  void initState() {
    super.initState();
    _loadProductsFuture = Provider.of<ProductProvider>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Product Catalog',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Cursive", fontSize: 28),
          ),
        ),
        backgroundColor: Colors.green.shade100,
      ),
      body: Column(
        children: [
          SearchFilterBar(
            onSearch: productProvider.search,
            onFilter: productProvider.filterByCategory,
          ),
          Expanded(
            child: FutureBuilder(
              future: _loadProductsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading products'));
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: productProvider.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = productProvider.filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        child: ProductCard(product: product),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
