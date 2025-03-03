import 'package:flutter/material.dart';

import '../model/product.dart';


class Products with ChangeNotifier {
  static String dummyDesc =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";


  List<Product> _items = [
    /// Fruits Products
    Product(
      id: "1",
      name: 'كرسي لمعاقين المشي',
      price: 80,
      imageUrl:
      'https://th.bing.com/th/id/OIP.zl8uxrncWhrf2XT2JlobhwHaHa?rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),

    Product(
      id: "2",
      name: 'سماعات لضعيفي السمع',
      price: 60,
      imageUrl:
      'https://th.bing.com/th/id/OIP.aq46CiFsvjgapLLwFsUPFAHaHa?rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),
    Product(
      id: "3",
      name: 'عصا للمكفوفين',
      price: 50,
      imageUrl:
      'https://th.bing.com/th/id/OIP._eg-vwXA7kYHYxlNxNhLWwHaHa?rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),

    Product(
      id: "4",
      name: 'كرسي ذكي لمعاقين الحركة',
      price: 40,
      imageUrl:
      'https://images-na.ssl-images-amazon.com/images/I/41MSUhHIizL.jpg',
      description: dummyDesc,
    ),
    Product(
      id: "5",
      name: 'عصا ذكية للمكفوفين',
      price: 30,
      imageUrl:
      'https://th.bing.com/th/id/OIP.IbiasQlCshSqnZy-w1NZdQHaHa?rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),
    Product(
      id: "6",
      name: 'نظارات ذكية للمكفوفين',
      price: 50,
      imageUrl:
      'https://th.bing.com/th/id/OIP.bZ31D15fVMI1yLC8chNStgHaHa?w=720&h=720&rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),
    /// Vegetable Products
    Product(
      id: "7",
      name: 'كرسي معاقي الحركة مع حوض',
      price: 20,
      imageUrl:
      'https://th.bing.com/th/id/OIP.zl8uxrncWhrf2XT2JlobhwHaHa?rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),
    Product(
      id: "8",
      name: 'كتب تعلم منقوطة للمكفوفين',
      price: 40,
      imageUrl:
      'https://th.bing.com/th/id/OIP.aq46CiFsvjgapLLwFsUPFAHaHa?rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),
    Product(
      id: "9",
      name: 'عكازات مع مساعدات',
      price: 90,
      imageUrl:
      'https://th.bing.com/th/id/OIP._eg-vwXA7kYHYxlNxNhLWwHaHa?rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),
    Product(
      id: "10",
      name: 'عكازات عادية',
      price: 60,
      imageUrl:
      'https://th.bing.com/th/id/OIP.IbiasQlCshSqnZy-w1NZdQHaHa?rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),
    Product(
      id: "11",
      name: 'دعامات ارجل اصطناعية',
      price: 50,
      imageUrl:
      'https://images-na.ssl-images-amazon.com/images/I/41MSUhHIizL.jpg',
      description: dummyDesc,
    ),
    Product(
      id: "12",
      name: 'كفوف هزازة لتمرين مصابي ضمور الدماغ',
      price: 40,
      imageUrl:
      'https://th.bing.com/th/id/OIP.bZ31D15fVMI1yLC8chNStgHaHa?w=720&h=720&rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),
  ];



  var _searchText='';

  List<Product> get items {

      if(_searchText==''){
        return [..._items];
      }else{
        return [..._items.where((prod)=>prod.name.contains(_searchText))];
      }

  }



  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
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

  void addProduct(Product product) {
    final newProduct = Product(
      name: product.name,
      price: product.price,
      imageUrl: product.imageUrl,
      id: product.id,
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
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
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
