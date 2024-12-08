import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Box favoritesBox;

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box('favorites');
    widget.product.isFavorite = favoritesBox.get(widget.product.id, defaultValue: false);
  }

  void toggleFavorite() {
    setState(() {
      widget.product.isFavorite = !widget.product.isFavorite;
    });
    favoritesBox.put(widget.product.id, widget.product.isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Product Catalog',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Cursive", fontSize: 28),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Center(
                  child: Image.network(
                    widget.product.image,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Row(
                    children: List.generate(
                      5,
                          (index) => Icon(
                        index < widget.product.rating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.product.rating.toStringAsFixed(1)} (${widget.product.ratingCount})',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Category: ${widget.product.category}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleFavorite,
        backgroundColor: widget.product.isFavorite ? Colors.red : Colors.grey,
        child: Icon(
          widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        ),
      ),
    );
  }
}
