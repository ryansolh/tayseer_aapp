//
//
//
// import 'package:flutter/cupertino.dart';
//
// class ProductResponseModel {
//   final bool success;
//   final String message;
//   final Data data;
//
//   ProductResponseModel({
//     required this.success,
//     required this.message,
//     required this.data,
//   });
//
//   factory ProductResponseModel.fromJson(Map<String, dynamic> json) => ProductResponseModel(
//     success: json["success"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   final int currentPage;
//   final List<Product> data;
//   final String firstPageUrl;
//   final int from;
//   final int lastPage;
//   final String lastPageUrl;
//   final List<Link> links;
//   final String nextPageUrl;
//   final String path;
//   final int perPage;
//   final dynamic prevPageUrl;
//   final int to;
//   final int total;
//
//   Data({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     required this.links,
//     required this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     required this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     currentPage: json["current_page"],
//     data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
//     firstPageUrl: json["first_page_url"],
//     from: json["from"],
//     lastPage: json["last_page"],
//     lastPageUrl: json["last_page_url"],
//     links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
//     nextPageUrl: json["next_page_url"],
//     path: json["path"],
//     perPage: json["per_page"],
//     prevPageUrl: json["prev_page_url"],
//     to: json["to"],
//     total: json["total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "current_page": currentPage,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "first_page_url": firstPageUrl,
//     "from": from,
//     "last_page": lastPage,
//     "last_page_url": lastPageUrl,
//     "links": List<dynamic>.from(links.map((x) => x.toJson())),
//     "next_page_url": nextPageUrl,
//     "path": path,
//     "per_page": perPage,
//     "prev_page_url": prevPageUrl,
//     "to": to,
//     "total": total,
//   };
// }
//
// class Product  with ChangeNotifier{
//   final int id;
//   final String name;
//   final String slug;
//   final String thumbImage;
//   final int vendorId;
//   final int categoryId;
//   final int subCategoryId;
//   final int childCategoryId;
//   final int brandId;
//   final int qty;
//   final String shortDescription;
//   final String longDescription;
//   final dynamic videoLink;
//   final Sku sku;
//   final double price;
//   final int? offerPrice;
//   final DateTime offerStartDate;
//   final DateTime offerEndDate;
//   final String productType;
//   final int status;
//   final int isApproved;
//   final dynamic seoTitle;
//   final dynamic seoDescription;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final dynamic reviewsAvgRating;
//   final int reviewsCount;
//   final List<Variant> variants;
//   final Category category;
//   final List<ProductImageGallery> productImageGalleries;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.thumbImage,
//     required this.vendorId,
//     required this.categoryId,
//     required this.subCategoryId,
//     required this.childCategoryId,
//     required this.brandId,
//     required this.qty,
//     required this.shortDescription,
//     required this.longDescription,
//     required this.videoLink,
//     required this.sku,
//     required this.price,
//     required this.offerPrice,
//     required this.offerStartDate,
//     required this.offerEndDate,
//     required this.productType,
//     required this.status,
//     required this.isApproved,
//     required this.seoTitle,
//     required this.seoDescription,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.reviewsAvgRating,
//     required this.reviewsCount,
//     required this.variants,
//     required this.category,
//     required this.productImageGalleries,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     name: json["name"],
//     slug: json["slug"],
//     thumbImage: json["thumb_image"],
//     vendorId: json["vendor_id"],
//     categoryId: json["category_id"],
//     subCategoryId: json["sub_category_id"],
//     childCategoryId: json["child_category_id"],
//     brandId: json["brand_id"],
//     qty: json["qty"],
//     shortDescription: json["short_description"],
//     longDescription: json["long_description"],
//     videoLink: json["video_link"],
//     sku: skuValues.map[json["sku"]]!,
//     price: json["price"],
//     offerPrice: json["offer_price"],
//     offerStartDate: DateTime.parse(json["offer_start_date"]),
//     offerEndDate: DateTime.parse(json["offer_end_date"]),
//     productType: json["product_type"],
//     status: json["status"],
//     isApproved: json["is_approved"],
//     seoTitle: json["seo_title"],
//     seoDescription: json["seo_description"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     reviewsAvgRating: json["reviews_avg_rating"],
//     reviewsCount: json["reviews_count"],
//     variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
//     category: Category.fromJson(json["category"]),
//     productImageGalleries: List<ProductImageGallery>.from(json["product_image_galleries"].map((x) => ProductImageGallery.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "slug": slug,
//     "thumb_image": thumbImage,
//     "vendor_id": vendorId,
//     "category_id": categoryId,
//     "sub_category_id": subCategoryId,
//     "child_category_id": childCategoryId,
//     "brand_id": brandId,
//     "qty": qty,
//     "short_description": shortDescription,
//     "long_description": longDescription,
//     "video_link": videoLink,
//     "sku": skuValues.reverse[sku],
//     "price": price,
//     "offer_price": offerPrice,
//     "offer_start_date": "${offerStartDate.year.toString().padLeft(4, '0')}-${offerStartDate.month.toString().padLeft(2, '0')}-${offerStartDate.day.toString().padLeft(2, '0')}",
//     "offer_end_date": "${offerEndDate.year.toString().padLeft(4, '0')}-${offerEndDate.month.toString().padLeft(2, '0')}-${offerEndDate.day.toString().padLeft(2, '0')}",
//     "product_type": productType,
//     "status": status,
//     "is_approved": isApproved,
//     "seo_title": seoTitle,
//     "seo_description": seoDescription,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "reviews_avg_rating": reviewsAvgRating,
//     "reviews_count": reviewsCount,
//     "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
//     "category": category.toJson(),
//     "product_image_galleries": List<dynamic>.from(productImageGalleries.map((x) => x.toJson())),
//   };
// }
//
// class Category {
//   final int id;
//   final Name name;
//   final Name slug;
//   final CatogeryIcon icon;
//   final int status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   Category({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.icon,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json["id"],
//     name: nameValues.map[json["name"]]!,
//     slug: nameValues.map[json["slug"]]!,
//     icon: iconValues.map[json["icon"]]!,
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": nameValues.reverse[name],
//     "slug": nameValues.reverse[slug],
//     "icon": iconValues.reverse[icon],
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// enum CatogeryIcon {
//   FAS_FA_DEAF
// }
//
// final iconValues = EnumValues({
//   "fas fa-deaf": CatogeryIcon.FAS_FA_DEAF
// });
//
// enum Name {
//   EMPTY
// }
//
// final nameValues = EnumValues({
//   "إعاقة سمعية": Name.EMPTY
// });
//
// class ProductImageGallery {
//   final int id;
//   final String image;
//   final int productId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   ProductImageGallery({
//     required this.id,
//     required this.image,
//     required this.productId,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory ProductImageGallery.fromJson(Map<String, dynamic> json) => ProductImageGallery(
//     id: json["id"],
//     image: json["image"],
//     productId: json["product_id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "image": image,
//     "product_id": productId,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// enum Sku {
//   MKV_2342345,
//   SIK_43234
// }
//
// final skuValues = EnumValues({
//   "MKV-2342345": Sku.MKV_2342345,
//   "SIK-43234": Sku.SIK_43234
// });
//
// class Variant {
//   final int id;
//   final int productId;
//   final String name;
//   final int status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   Variant({
//     required this.id,
//     required this.productId,
//     required this.name,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Variant.fromJson(Map<String, dynamic> json) => Variant(
//     id: json["id"],
//     productId: json["product_id"],
//     name: json["name"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_id": productId,
//     "name": name,
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// class Link {
//   final String? url;
//   final String label;
//   final bool active;
//
//   Link({
//     required this.url,
//     required this.label,
//     required this.active,
//   });
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//     url: json["url"],
//     label: json["label"],
//     active: json["active"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "label": label,
//     "active": active,
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }




import 'package:todo_apps/feature/market/data/model/product.dart';

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



class ProductResponse {
  final bool success;
  final String message;
  final ProductData data;

  ProductResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'],
      message: json['message'],
      data: ProductData.fromJson(json['data']),
    );
  }
}



class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}







class ProductData {
  final int currentPage;
  final List<ProductDataManage> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  ProductData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      currentPage: json['current_page'],
      data: (json['data'] as List).map((p) => ProductDataManage.fromJson(p)).toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List).map((l) => Link.fromJson(l)).toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}