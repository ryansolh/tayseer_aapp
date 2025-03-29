import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';

class CartItem {
  final int id; // تغيير إلى int
  final String name;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'qty': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ,
      name: map['name'] as String,
      quantity: map['qty'] as int,
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'] as String,
    );
  }

  CartItem copyWith({
    int? id,
    String? title,
    int? quantity,
    double? price,
    String? imageUrl,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: title ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
String cartItemsToJson(List<CartItem> cartItems) {
  List<Map<String, dynamic>> cartItemsMap =
  cartItems.map((cartItem) => cartItem.toMap()).toList();
  return json.encode(cartItemsMap);
}



