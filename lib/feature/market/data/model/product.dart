
import 'package:flutter/cupertino.dart';

class ProductDataManage with ChangeNotifier{
  final int id;
  final String name;
  final String slug;
  final String thumbImage;
  final int vendorId;
  final int categoryId;
  final int subCategoryId;
  final int childCategoryId;
  final int brandId;
  final int qty;
  final String shortDescription;
  final String longDescription;
  final String? videoLink;
  final String sku;
  final double price;
  final double? offerPrice;
  final String offerStartDate;
  final String offerEndDate;
  final String productType;
  final int status;
  final int isApproved;
  final String? seoTitle;
  final String? seoDescription;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? reviewsAvgRating;
  final int reviewsCount;
  final List<VariantOfProduct> variants;
  final CategoryOfProduct category;
  final List<ProductImageGallery> productImageGalleries;

  ProductDataManage({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbImage,
    required this.vendorId,
    required this.categoryId,
    required this.subCategoryId,
    required this.childCategoryId,
    required this.brandId,
    required this.qty,
    required this.shortDescription,
    required this.longDescription,
    this.videoLink,
    required this.sku,
    required this.price,
    this.offerPrice,
    required this.offerStartDate,
    required this.offerEndDate,
    required this.productType,
    required this.status,
    required this.isApproved,
    this.seoTitle,
    this.seoDescription,
    required this.createdAt,
    required this.updatedAt,
    this.reviewsAvgRating,
    required this.reviewsCount,
    required this.variants,
    required this.category,
    required this.productImageGalleries,
  });

  factory ProductDataManage.fromJson(Map<String, dynamic> json) {
    return ProductDataManage(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      thumbImage: json['thumb_image'],
      vendorId: json['vendor_id'],
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      childCategoryId: json['child_category_id'],
      brandId: json['brand_id'],
      qty: json['qty'],
      shortDescription: json['short_description'],
      longDescription: json['long_description'],
      videoLink: json['video_link'],
      sku: json['sku'],
      price: json['price'].toDouble(),
      offerPrice: json['offer_price']?.toDouble(),
      offerStartDate: json['offer_start_date'],
      offerEndDate: json['offer_end_date'],
      productType: json['product_type'],
      status: json['status'],
      isApproved: json['is_approved'],
      seoTitle: json['seo_title'],
      seoDescription: json['seo_description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      reviewsAvgRating: json['reviews_avg_rating']?.toDouble(),
      reviewsCount: json['reviews_count'],
      variants: (json['variants'] as List).map((v) => VariantOfProduct.fromJson(v)).toList(),
      category: CategoryOfProduct.fromJson(json['category']),
      productImageGalleries: (json['product_image_galleries'] as List).map((p) => ProductImageGallery.fromJson(p)).toList(),
    );
  }
}


class VariantOfProduct {
  final int id;
  final int productId;
  final String name;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  VariantOfProduct({
    required this.id,
    required this.productId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VariantOfProduct.fromJson(Map<String, dynamic> json) {
    return VariantOfProduct(
      id: json['id'],
      productId: json['product_id'],
      name: json['name'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}


class CategoryOfProduct {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryOfProduct({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryOfProduct.fromJson(Map<String, dynamic> json) {
    return CategoryOfProduct(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      icon: json['icon'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}




class ProductImageGallery {
  final int id;
  final String image;
  final int productId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductImageGallery({
    required this.id,
    required this.image,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductImageGallery.fromJson(Map<String, dynamic> json) {
    return ProductImageGallery(
      id: json['id'],
      image: json['image'],
      productId: json['product_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}


