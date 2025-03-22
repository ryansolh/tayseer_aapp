import 'package:flutter/cupertino.dart';

import '../../../feature/market/data/data_sources/products.dart';
import '../../../feature/market/data/model/cart.dart';
import '../../../feature/market/data/model/product.dart';

void addProductToCart(BuildContext context, ProductDataManage product, Cart cart) {
  cart.addItem(product.id.toString(), product.price! as double, product.name!, product.thumbImage!);
}

void removeProductToCart(BuildContext context, ProductDataManage product, Cart cart) {
  cart.removeSingleItem(product.id.toString());
}



