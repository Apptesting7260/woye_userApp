import 'package:get/get.dart';

class PharmacyCategoriesDetailsModal {
  bool? status;
  List<CategoryProduct>? categoryProduct;
  List<CategoryProduct>? filterProduct;
  String? message;

  PharmacyCategoriesDetailsModal(
      {this.status, this.categoryProduct, this.filterProduct, this.message});

  PharmacyCategoriesDetailsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categoryProduct'] != null) {
      categoryProduct = <CategoryProduct>[];
      json['categoryProduct'].forEach((v) {
        categoryProduct!.add(new CategoryProduct.fromJson(v));
      });
    }
    if (json['filterProduct'] != null) {
      filterProduct = <CategoryProduct>[];
      json['filterProduct'].forEach((v) {
        filterProduct!.add(CategoryProduct.fromJson(v));
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
    if (this.filterProduct != null) {
      data['filterProduct'] =
          this.filterProduct!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class CategoryProduct {
  int? id;
  String? title;
  var regularPrice;
  var salePrice;
  String? packagingValue;
  int? categoryId;
  bool? isInWishlist;
  String? shopName;
  String? urlImage;
  String? categoryName;
  Rx<bool> isLoading = false.obs;

  CategoryProduct({
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

  CategoryProduct.fromJson(Map<String, dynamic> json) {
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
