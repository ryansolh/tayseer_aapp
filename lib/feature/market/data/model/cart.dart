import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';

class CartItem {
  final String id; // تغيير إلى int
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
    String? id,
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


class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int _itemLength=0;

  int get quantityOfItem{
    return _itemLength;
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void updateQuantityOfItem(String productId){

    if (_items.containsKey(productId)){
      print("/////////////////");
      print(_items[productId]!.quantity);
      _itemLength=_items[productId]!.quantity;
      print("/////////////////");


    }
    else{
      _itemLength=0;
    }

  notifyListeners();

}



  void addItem(
      String productId,
      double price,
      String name,
      String imageUrl,
      ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          imageUrl: imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
            () => CartItem(
          id: DateTime.now().toString(),
          name: name,
          price: price,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
              (existingCartItem) => CartItem(
            id: existingCartItem.id,
            name: existingCartItem.name,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1,
            imageUrl: existingCartItem.imageUrl,
          ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

