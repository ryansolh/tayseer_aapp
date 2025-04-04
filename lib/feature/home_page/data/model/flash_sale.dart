class OfferResponseData {
  final bool? state;
  final String? alert;
  final FlashSaleInfo? specialOffer;
  final List<DiscountedProductItem>? sellingItems;

  OfferResponseData({
    this.state,
    this.alert,
    this.specialOffer,
    this.sellingItems,
  });

  factory OfferResponseData.fromJson(Map<String, dynamic> json) {
    return OfferResponseData(
      state: json['status'] as bool?,
      alert: json['message'] as String?,
      specialOffer: json['flash_sale'] == null
          ? null
          : FlashSaleInfo.fromJson(json['flash_sale'] as Map<String, dynamic>),
      sellingItems: (json['products'] as List<dynamic>?)
          ?.map((item) => DiscountedProductItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FlashSaleInfo {
  final int? identifier;
  final String? closingDate;
  final DateTime? creationTime;
  final DateTime? updateTime;

  FlashSaleInfo({
    this.identifier,
    this.closingDate,
    this.creationTime,
    this.updateTime,
  });

  factory FlashSaleInfo.fromJson(Map<String, dynamic> json) {
    return FlashSaleInfo(
      identifier: json['id'] as int?,
      closingDate: json['end_date'] as String?,
      creationTime: (json['created_at'] as String?) != null
          ? DateTime.parse(json['created_at'].toString())
          : null,
      updateTime: (json['updated_at'] as String?) != null
          ? DateTime.parse(json['updated_at'].toString())
          : null,
    );
  }
}

class DiscountedProductItem {
  final int? recordId;
  final int? productIdReference;
  final int? flashSaleIdReference;
  final int? displayAtHome;
  final int? itemStatus;
  final DateTime? creationTime;
  final DateTime? updateTime;
  final ProductDetails? productInformation;

  DiscountedProductItem({
    this.recordId,
    this.productIdReference,
    this.flashSaleIdReference,
    this.displayAtHome,
    this.itemStatus,
    this.creationTime,
    this.updateTime,
    this.productInformation,
  });

  factory DiscountedProductItem.fromJson(Map<String, dynamic> json) {
    return DiscountedProductItem(
      recordId: json['id'] as int?,
      productIdReference: json['product_id'] as int?,
      flashSaleIdReference: json['flash_sale_id'] as int?,
      displayAtHome: json['show_at_home'] as int?,
      itemStatus: json['status'] as int?,
      creationTime: (json['created_at'] as String?) != null
          ? DateTime.parse(json['created_at'].toString())
          : null,
      updateTime: (json['updated_at'] as String?) != null
          ? DateTime.parse(json['updated_at'].toString())
          : null,
      productInformation: json['product'] == null
          ? null
          : ProductDetails.fromJson(json['product'] as Map<String, dynamic>),
    );
  }
}

class ProductDetails {
  final int? idCode;
  final String? label;
  final String? link;
  final String? imageThumb;
  final int? sellerId;
  final int? categoryId;
  final int? subCategoryId;
  final int? childCategoryId;
  final int? brandId;
  final int? quantity;
  final String? briefDescription;
  final String? fullDescription;
  final String? videoLink;
  final String? uniqueCode;
  final double? priceValue;
  final double? offerPriceValue;
  final String? offerStartDate;
  final String? offerEndDate;
  final String? productKind;
  final int? productStatus;
  final int? isApprovedStatus;
  final String? seoTitleTag;
  final String? seoDescriptionTag;
  final DateTime? creationTime;
  final DateTime? updateTime;

  ProductDetails({
    this.idCode,
    this.label,
    this.link,
    this.imageThumb,
    this.sellerId,
    this.categoryId,
    this.subCategoryId,
    this.childCategoryId,
    this.brandId,
    this.quantity,
    this.briefDescription,
    this.fullDescription,
    this.videoLink,
    this.uniqueCode,
    this.priceValue,
    this.offerPriceValue,
    this.offerStartDate,
    this.offerEndDate,
    this.productKind,
    this.productStatus,
    this.isApprovedStatus,
    this.seoTitleTag,
    this.seoDescriptionTag,
    this.creationTime,
    this.updateTime,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      idCode: json['id'] as int?,
      label: json['name'] as String?,
      link: json['slug'] as String?,
      imageThumb: json['thumb_image'] as String?,
      sellerId: json['vendor_id'] as int?,
      categoryId: json['category_id'] as int?,
      subCategoryId: json['sub_category_id'] as int?,
      childCategoryId: json['child_category_id'] as int?,
      brandId: json['brand_id'] as int?,
      quantity: json['qty'] as int?,
      briefDescription: json['short_description'] as String?,
      fullDescription: json['long_description'] as String?,
      videoLink: json['video_link'] as String?,
      uniqueCode: json['sku'] as String?,
      priceValue: (json['price'] as num?)?.toDouble(),
      offerPriceValue: (json['offer_price'] as num?)?.toDouble(),
      offerStartDate: json['offer_start_date'] as String?,
      offerEndDate: json['offer_end_date'] as String?,
      productKind: json['product_type'] as String?,
      productStatus: json['status'] as int?,
      isApprovedStatus: json['is_approved'] as int?,
      seoTitleTag: json['seo_title'] as String?,
      seoDescriptionTag: json['seo_description'] as String?,
      creationTime: (json['created_at'] as String?) != null
          ? DateTime.parse(json['created_at'].toString())
          : null,
      updateTime: (json['updated_at'] as String?) != null
          ? DateTime.parse(json['updated_at'].toString())
          : null,
    );
  }
}