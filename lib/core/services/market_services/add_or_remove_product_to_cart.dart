import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../feature/market/data/data_sources/products.dart';
import '../../../feature/market/data/model/cart.dart';
import '../../../feature/market/data/model/product.dart';

void addProductToCart(BuildContext context, ProductDataManage product) {
  final cart = Provider.of<Cart>(context, listen: false);
  cart.addItem(product.id.toString(), product.price!, product.name!, product.thumbImage!);
}

void removeProductToCart(BuildContext context, ProductDataManage product) {
  final cart = Provider.of<Cart>(context, listen: false);
  cart.removeSingleItem(product.id.toString());
}



