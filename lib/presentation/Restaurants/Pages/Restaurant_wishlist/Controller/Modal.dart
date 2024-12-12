import 'package:get/get.dart';

class restaurant_product_wishlist_modal {
  bool? status;
  List<CategoryProduct>? categoryProduct;
  String? message;

  restaurant_product_wishlist_modal(
      {this.status, this.categoryProduct, this.message});

  restaurant_product_wishlist_modal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categoryProduct'] != null) {
      categoryProduct = <CategoryProduct>[];
      json['categoryProduct'].forEach((v) {
        categoryProduct!.add(new CategoryProduct.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.categoryProduct != null) {
      data['categoryProduct'] =
          this.categoryProduct!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class CategoryProduct {
  int? id;
  String? title;
  int? userId;
  int? categoryId;
  String? categoryName;
  String? regularPrice;
  int? salePrice;
  String? description;
  String? discount;
  int? rating;
  String? image;
  bool? isInWishlist;
  String? urlImage;
  Rx<bool> isLoading = false.obs;

  CategoryProduct({
    this.id,
    this.title,
    this.userId,
    this.categoryId,
    this.categoryName,
    this.regularPrice,
    this.salePrice,
    this.description,
    this.discount,
    this.rating,
    this.image,
    this.isInWishlist,
    this.urlImage,
  });

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    description = json['description'];
    discount = json['discount'];
    rating = json['rating'];
    image = json['image'];
    isInWishlist = json['is_in_wishlist'];
    urlImage = json['url_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['is_in_wishlist'] = this.isInWishlist;
    data['url_image'] = this.urlImage;
    return data;
  }
}
