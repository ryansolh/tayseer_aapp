import 'package:flutter/material.dart';

import '../model/product.dart';



class Products with ChangeNotifier {
  static String dummyDesc =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";



//=ProductResposeModel.fromJson(productResponseData).responseData.products;
 final List<ProductDataManage> _products=[];

  var _searchText='';

  List<ProductDataManage> get items {

      if(_searchText==''){
       // print(ProductResposeModel.fromJson(productResponseData).responseData.products);
        return [..._products];
      }else{
        return [..._products.where((prod)=>prod.name.contains(_searchText))];
      }

  }



  ProductDataManage findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }


 /* Product findByProductName(String PruductName) {
    return _items.;
  }*/

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(ProductDataManage product) {
    final  newProduct = ProductDataManage(

      name: product.name,
      price: product.price,
      thumbImage: product.thumbImage,
      id: product.id,
      brandId: product.brandId,
      category: product.category,
      categoryId: product.categoryId,
      childCategoryId: product.childCategoryId,
      longDescription: product.longDescription,
      createdAt: product.createdAt,
      isApproved: product.isApproved,
      qty: product.qty,
      offerEndDate: product.offerEndDate,
      offerPrice: product.offerPrice,
      offerStartDate: product.offerStartDate,
      productImageGalleries: product.productImageGalleries,
      productType: product.productType,
      reviewsCount: product.reviewsCount,
      shortDescription: product.shortDescription,
      sku: product.sku,
      slug: product.slug,
      status: product.status,
      subCategoryId: product.subCategoryId,
      updatedAt: product.updatedAt,
      variants: product.variants,
      vendorId: product.vendorId,
      reviewsAvgRating: product.reviewsAvgRating,
      seoDescription: product.seoDescription,
      seoTitle: product.seoTitle,
      videoLink: product.videoLink
    );
    _products.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }



  void addAllProducts(List<ProductDataManage> products) {

    _products.addAll(products);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, ProductDataManage newProduct) {
    final prodIndex = _products.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _products[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void searchByName(String searchText) {
    if(searchText.isEmpty||searchText=='') {
      _searchText = '';
      notifyListeners();
    }
    else{
      _searchText = searchText;
      notifyListeners();
    }

  }


  void deleteProduct(String id) {
    _products!.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}


