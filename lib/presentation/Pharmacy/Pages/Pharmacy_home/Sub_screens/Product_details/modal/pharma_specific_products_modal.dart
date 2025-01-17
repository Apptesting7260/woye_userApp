import 'package:get/get.dart';

class PharmaSpecificProductModal {
  bool? status;
  Product? product;
  List<MoreProducts>? moreProducts;
  String? message;

  PharmaSpecificProductModal(
      {this.status, this.product, this.moreProducts, this.message});

  PharmaSpecificProductModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['moreProducts'] != null) {
      moreProducts = <MoreProducts>[];
      json['moreProducts'].forEach((v) {
        moreProducts!.add(new MoreProducts.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.moreProducts != null) {
      data['moreProducts'] = this.moreProducts!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Product {
  int? id;
  String? title;
  Null? slug;
  int? userId;
  int? categoryId;
  int? consumeId;
  String? expire;
  String? regularPrice;
  String? salePrice;
  String? quanInStock;
  int? packagingId;
  String? packagingValue;
  String? description;
  String? image;
  String? addimg;
  Null? variant;
  int? prescription;
  String? use;
  String? missedDose;
  String? overdose;
  String? interactions;
  String? sideEffect;
  String? advice;
  String? notUse;
  String? warnings;
  String? otherDetails;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? pharmaName;
  List<String>? urlAddimg;
  String? urlImage;

  Product(
      {this.id,
      this.title,
      this.slug,
      this.userId,
      this.categoryId,
      this.consumeId,
      this.expire,
      this.regularPrice,
      this.salePrice,
      this.quanInStock,
      this.packagingId,
      this.packagingValue,
      this.description,
      this.image,
      this.addimg,
      this.variant,
      this.prescription,
      this.use,
      this.missedDose,
      this.overdose,
      this.interactions,
      this.sideEffect,
      this.advice,
      this.notUse,
      this.warnings,
      this.otherDetails,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.pharmaName,
      this.urlAddimg,
      this.urlImage});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    consumeId = json['consume_id'];
    expire = json['expire'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    quanInStock = json['quan_in_stock'];
    packagingId = json['packaging_id'];
    packagingValue = json['packaging_value'];
    description = json['description'];
    image = json['image'];
    addimg = json['addimg'];
    variant = json['variant'];
    prescription = json['prescription'];
    use = json['use'];
    missedDose = json['missed_dose'];
    overdose = json['overdose'];
    interactions = json['interactions'];
    sideEffect = json['side_effect'];
    advice = json['advice'];
    notUse = json['not_use'];
    warnings = json['warnings'];
    otherDetails = json['other_details'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    pharmaName = json['pharma_name'];
    urlAddimg = json['url_addimg'].cast<String>();
    urlImage = json['url_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['consume_id'] = this.consumeId;
    data['expire'] = this.expire;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['quan_in_stock'] = this.quanInStock;
    data['packaging_id'] = this.packagingId;
    data['packaging_value'] = this.packagingValue;
    data['description'] = this.description;
    data['image'] = this.image;
    data['addimg'] = this.addimg;
    data['variant'] = this.variant;
    data['prescription'] = this.prescription;
    data['use'] = this.use;
    data['missed_dose'] = this.missedDose;
    data['overdose'] = this.overdose;
    data['interactions'] = this.interactions;
    data['side_effect'] = this.sideEffect;
    data['advice'] = this.advice;
    data['not_use'] = this.notUse;
    data['warnings'] = this.warnings;
    data['other_details'] = this.otherDetails;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['pharma_name'] = this.pharmaName;
    data['url_addimg'] = this.urlAddimg;
    data['url_image'] = this.urlImage;
    return data;
  }
}

class MoreProducts {
  int? id;
  String? title;
  String? regularPrice;
  String? salePrice;
  String? packagingValue;
  int? categoryId;
  bool? isInWishlist;
  String? shopName;
  String? urlImage;
  String? categoryName;
  Rx<bool> isLoading = false.obs;

  MoreProducts({
    this.id,
    this.title,
    this.regularPrice,
    this.salePrice,
    this.packagingValue,
    this.categoryId,
    this.isInWishlist,
    this.shopName,
    this.urlImage,
    this.categoryName,
  });

  MoreProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    packagingValue = json['packaging_value'];
    categoryId = json['category_id'];
    isInWishlist = json['is_in_wishlist'];
    shopName = json['shop_name'];
    urlImage = json['url_image'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['packaging_value'] = this.packagingValue;
    data['category_id'] = this.categoryId;
    data['is_in_wishlist'] = this.isInWishlist;
    data['shop_name'] = this.shopName;
    data['url_image'] = this.urlImage;
    data['category_name'] = this.categoryName;
    return data;
  }
}

// class MoreProducts {
//   int? id;
//   String? title;
//   String? regularPrice;
//   String? salePrice;
//   String? packagingValue;
//   String? image;
//   String? addimg;
//   int? categoryId;
//   int? userId;
//   bool? isInWishlist;
//   String? shopName;
//   List<String>? urlAddimg;
//   String? urlImage;
//
//   MoreProducts(
//       {this.id,
//         this.title,
//         this.regularPrice,
//         this.salePrice,
//         this.packagingValue,
//         this.image,
//         this.addimg,
//         this.categoryId,
//         this.userId,
//         this.isInWishlist,
//         this.shopName,
//         this.urlAddimg,
//         this.urlImage});
//
//   MoreProducts.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     regularPrice = json['regular_price'];
//     salePrice = json['sale_price'];
//     packagingValue = json['packaging_value'];
//     image = json['image'];
//     addimg = json['addimg'];
//     categoryId = json['category_id'];
//     userId = json['user_id'];
//     isInWishlist = json['is_in_wishlist'];
//     shopName = json['shop_name'];
//     urlAddimg = json['url_addimg'].cast<String>();
//     urlImage = json['url_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['regular_price'] = this.regularPrice;
//     data['sale_price'] = this.salePrice;
//     data['packaging_value'] = this.packagingValue;
//     data['image'] = this.image;
//     data['addimg'] = this.addimg;
//     data['category_id'] = this.categoryId;
//     data['user_id'] = this.userId;
//     data['is_in_wishlist'] = this.isInWishlist;
//     data['shop_name'] = this.shopName;
//     data['url_addimg'] = this.urlAddimg;
//     data['url_image'] = this.urlImage;
//     return data;
//   }
// }
