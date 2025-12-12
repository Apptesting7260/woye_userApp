import 'package:get/get.dart';

class PharmacyProductWishlistModal {
  bool? status;
  List<WishlistProduct>? allWishlist;
  String? message;

  PharmacyProductWishlistModal({this.status, this.allWishlist, this.message});

  PharmacyProductWishlistModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['allWishlist'] != null) {
      allWishlist = <WishlistProduct>[];
      json['allWishlist'].forEach((v) {
        allWishlist!.add(WishlistProduct.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (allWishlist != null) {
      data['allWishlist'] = allWishlist!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class WishlistProduct {
  int? id;
  String? title;
  var regularPrice;
  var salePrice;
  String? packagingValue;
  int? categoryId;
  String? categoryName;
  bool? isInWishlist = true;
  String? shopName;
  String? urlImage;
  String? rating;
  Rx<bool> isLoading = false.obs;

  WishlistProduct({
    this.id,
    this.title,
    this.regularPrice,
    this.salePrice,
    this.packagingValue,
    this.categoryId,
    this.categoryName,
    // this.isInWishlist = true,
    this.shopName,
    this.urlImage,
    this.rating,
  });

  WishlistProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    packagingValue = json['packaging_value'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    // isInWishlist = json['is_in_wishlist'];
    shopName = json['shop_name'];
    urlImage = json['url_image'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['packaging_value'] = packagingValue;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    // data['is_in_wishlist'] = this.isInWishlist;
    data['shop_name'] = shopName;
    data['url_image'] = urlImage;
    data['rating'] = rating;
    return data;
  }
}

// class WishlistProduct {
//   int? id;
//   String? title;
//   var userId;
//   var categoryId;
//   String? categoryName;
//   String? regularPrice;
//   int? salePrice;
//   String? description;
//   String? discount;
//   int? rating;
//   bool? isInWishlist;
//   String? urlImage;
//   Rx<bool> isLoading = false.obs;
//
//   WishlistProduct({
//     this.id,
//     this.title,
//     this.userId,
//     this.categoryId,
//     this.categoryName,
//     this.regularPrice,
//     this.salePrice,
//     this.description,
//     this.discount,
//     this.rating,
//     this.isInWishlist,
//     this.urlImage,
//   });
//
//   WishlistProduct.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     userId = json['user_id'];
//     categoryId = json['category_id'];
//     categoryName = json['category_name'];
//     regularPrice = json['regular_price'];
//     salePrice = json['sale_price'];
//     description = json['description'];
//     discount = json['discount'];
//     rating = json['rating'];
//     isInWishlist = json['is_in_wishlist'];
//     urlImage = json['url_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['user_id'] = this.userId;
//     data['category_id'] = this.categoryId;
//     data['category_name'] = this.categoryName;
//     data['regular_price'] = this.regularPrice;
//     data['sale_price'] = this.salePrice;
//     data['description'] = this.description;
//     data['discount'] = this.discount;
//     data['rating'] = this.rating;
//     data['is_in_wishlist'] = this.isInWishlist;
//     data['url_image'] = this.urlImage;
//     return data;
//   }
// }
