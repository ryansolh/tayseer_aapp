import 'dart:ffi';

import 'package:flutter/foundation.dart';

class CentersModel with ChangeNotifier {
  final int id;
  final String name;
  final String location;
  final String imageUrl;
  final String? description;

  bool isFavorite;

  CentersModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.location,
    this.description,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
