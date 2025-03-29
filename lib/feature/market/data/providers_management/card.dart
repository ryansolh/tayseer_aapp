import 'package:flutter/cupertino.dart';

import '../model/cart.dart';

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
          id: int.parse(productId),
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
