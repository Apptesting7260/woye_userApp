import 'package:get/get.dart';

class GroceryProductWishlistModal {
  bool? status;
  List<WishlistProduct>? allWishlist;
  String? message;

  GroceryProductWishlistModal({this.status, this.allWishlist, this.message});

  GroceryProductWishlistModal.fromJson(Map<String, dynamic> json) {
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
    this.rating,
    this.urlImage,
  });

  WishlistProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title']?.toString();
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    packagingValue = json['packaging_value'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    // isInWishlist = json['is_in_wishlist'];
    shopName = json['shop_name'];
    rating = json['rating']?.toString();
    urlImage = json['url_image'];
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
    data['rating'] = rating;
    data['url_image'] = urlImage;
    return data;
  }
}


