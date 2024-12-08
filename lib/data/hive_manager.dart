// import 'package:hive_flutter/hive_flutter.dart';
//
// class HiveManager {
//   final _favoritesBox = Hive.box('favorites');
//
//   List<int> getFavorites() {
//     return _favoritesBox.keys.cast<int>().toList();
//   }
//
//   void toggleFavorite(int productId) {
//     if (_favoritesBox.containsKey(productId)) {
//       _favoritesBox.delete(productId);
//     } else {
//       _favoritesBox.put(productId, true);
//     }
//   }
//
//   bool isFavorite(int productId) {
//     return _favoritesBox.containsKey(productId);
//   }
// }
