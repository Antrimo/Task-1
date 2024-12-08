import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  final Function(String) onSearch;
  final Function(String) onFilter;

  const SearchFilterBar({
    super.key,
    required this.onSearch,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: TextStyle(color: Colors.grey[600]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none, // No border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
            ),
            onChanged: onSearch,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
            hint: const Text(
              'Filter by category',
              style: TextStyle(color: Colors.grey),
            ),
            onChanged: (value) => onFilter(value ?? ''),
            items: const [
              DropdownMenuItem(
                value: '',
                child: Text('All Categories'),
              ),
              DropdownMenuItem(
                value: 'electronics',
                child: Text('Electronics'),
              ),
              DropdownMenuItem(
                value: 'jewelery',
                child: Text('Jewelry'),
              ),
              DropdownMenuItem(
                value: "men's clothing",
                child: Text("Men's Clothing"),
              ),
              DropdownMenuItem(
                value: "women's clothing",
                child: Text("Women's Clothing"),
              ),
            ],
            dropdownColor: Colors.white,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
