// class ProductResponseModell {
//   final bool success;
//   final String message;
//   final Data data;
//
//   ProductResponseModell({
//     required this.success,
//     required this.message,
//     required this.data,
//   });
//
//   factory ProductResponseModell.fromJson(Map<String, dynamic> json) => ProductResponseModell(
//     success: json["success"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
// }
//
// class Data {
//   final int ? currentPage;
//   final List<Datum> ? data;
//   final String ? nextPageUrl;
//   final String ? path;
//   final int ?  perPage;
//   final dynamic ? prevPageUrl;
//   final int?  to;
//   final int ? total;
//
//   Data({
//     required this.currentPage,
//     required this.data,
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
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     nextPageUrl: json["next_page_url"],
//     path: json["path"],
//     perPage: json["per_page"],
//     prevPageUrl: json["prev_page_url"],
//     to: json["to"],
//     total: json["total"],
//   );
// }
//
// class Datum {
//   final int ? id;
//   final String ? name;
//   final String  ?slug;
//   final String ?thumbImage;
//   final int ?vendorId;
//   final int ?categoryId;
//   final int ?subCategoryId;
//   final int ?childCategoryId;
//   final int ?brandId;
//   final int ?qty;
//   final String ?shortDescription;
//   final String ?longDescription;
//   final dynamic ?videoLink;
//   final String ?sku;
//   final int ?price;
//   final int ?offerPrice;
//   final DateTime ?offerStartDate;
//   final DateTime ?offerEndDate;
//   final String ?productType;
//   final int ?status;
//   final int ?isApproved;
//   final dynamic? seoTitle;
//   final dynamic ?seoDescription;
//   final DateTime ?createdAt;
//   final DateTime ?updatedAt;
//   final dynamic ? reviewsAvgRating;
//   final int ?reviewsCount;
//   final List<dynamic> ?variants;
//   final List<ProductImageGallery>? productImageGalleries;
//
//   Datum({
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
//     required this.productImageGalleries,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
//     sku: json["sku"],
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
//     variants: List<dynamic>.from(json["variants"].map((x) => x)),
//     productImageGalleries: List<ProductImageGallery>.from(json["product_image_galleries"].map((x) => ProductImageGallery.fromJson(x))),
//   );
// }
//
// class ProductImageGallery {
//   final int ?id;
//   final String ?image;
//   final int ?productId;
//   final DateTime ?createdAt;
//   final DateTime ?updatedAt;
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
// }
