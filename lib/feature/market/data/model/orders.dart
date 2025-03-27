import 'package:flutter/foundation.dart';

import './cart.dart';

class OrderResponse {
  final String status;
  final String message;
  final List<Order>? data;

  OrderResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List?)?.map((e) => Order.fromJson(e)).toList(),
    );
  }
}

class Order {
  final int id;
  final String invoiceId;
  final int userId;
  final double subTotal;
  final double amount;
  final Currency currency;
  final int productQty;
  final Payment payment;
  final OrderAddress orderAddress;
  final ShippingMethod shippingMethod;
  final String orderStatus;
  final List<Product> products;

  Order({
    required this.id,
    required this.invoiceId,
    required this.userId,
    required this.subTotal,
    required this.amount,
    required this.currency,
    required this.productQty,
    required this.payment,
    required this.orderAddress,
    required this.shippingMethod,
    required this.orderStatus,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      invoiceId: json['invoice_id'],
      userId: json['user_id'],
      subTotal: (json['sub_total'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      currency: Currency.fromJson(json['currency']),
      productQty: json['product_qty'],
      payment: Payment.fromJson(json['payment']),
      orderAddress: OrderAddress.fromJson(json['order_address']),
      shippingMethod: ShippingMethod.fromJson(json['shipping_method']),
      orderStatus: json['order_status'],
      products: (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
    );
  }
}

class Currency {
  final String name;
  final String icon;

  Currency({
    required this.name,
    required this.icon,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'],
      icon: json['icon'],
    );
  }
}

class Payment {
  final String method;
  final int status;

  Payment({
    required this.method,
    required this.status,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      method: json['method'],
      status: json['status'],
    );
  }
}

class OrderAddress {
  final String name;
  final String email;
  final String phone;
  final String country;
  final String state;
  final String city;
  final String zip;
  final String? address;
  final String? street;

  OrderAddress({
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.zip,
    this.address,
    this.street,
  });

  factory OrderAddress.fromJson(Map<String, dynamic> json) {
    return OrderAddress(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      zip: json['zip'],
      address: json['address'],
      street: json['street'],
    );
  }
}

class ShippingMethod {
  final String name;
  final int cost;

  ShippingMethod({
    required this.name,
    required this.cost,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      name: json['name'],
      cost: json['cost'],
    );
  }
}

class Product {
  final int productId;
  final String name;
  final String image;
  final int quantity;

  Product({
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      name: json['name'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }
}


