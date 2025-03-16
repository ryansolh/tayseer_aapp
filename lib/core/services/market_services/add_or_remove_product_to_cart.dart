import 'package:flutter/cupertino.dart';

import '../../../feature/market/data/model/cart.dart';
import '../../../feature/market/data/model/product.dart';

void addProductToCart(BuildContext context, Product product, Cart cart) {
  cart.addItem(product.id, product.price, product.name, product.imageUrl);
}

void removeProductToCart(BuildContext context, Product product, Cart cart) {
  cart.removeSingleItem(product.id);
}



