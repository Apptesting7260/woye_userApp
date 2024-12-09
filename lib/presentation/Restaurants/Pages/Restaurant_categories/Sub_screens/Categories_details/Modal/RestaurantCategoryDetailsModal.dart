import 'package:get/get_rx/src/rx_types/rx_types.dart';

class RestaurantCategoryDetailsModal {
  bool? status;
  List<CategoryProduct>? categoryProduct;
  String? message;

  RestaurantCategoryDetailsModal({this.status, this.categoryProduct, this.message});

  RestaurantCategoryDetailsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categoryProduct'] != null) {
      categoryProduct = <CategoryProduct>[];
      json['categoryProduct'].forEach((v) {
        categoryProduct!.add(CategoryProduct.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    if (this.categoryProduct != null) {
      data['categoryProduct'] = this.categoryProduct!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class CategoryProduct {
  int? id;
  int? salePrice;
  String? regularPrice;
  String? title;
  bool? isInWishlist;
  String? restoName;
  String? urlImage;
  var rating;
  Rx<bool> isLoading = false.obs;

  CategoryProduct({
    this.id,
    this.salePrice,
    this.regularPrice,
    this.title,
    this.isInWishlist,
    this.restoName,
    this.urlImage,
    this.rating,
  });

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salePrice = json['sale_price'];
    regularPrice = json['regular_price'];
    title = json['title'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    urlImage = json['url_image'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['sale_price'] = this.salePrice;
    data['regular_price'] = this.regularPrice;
    data['title'] = this.title;
    data['is_in_wishlist'] = this.isInWishlist;
    data['resto_name'] = this.restoName;
    data['url_image'] = this.urlImage;
    data['rating'] = this.rating;
    return data;
  }
}

