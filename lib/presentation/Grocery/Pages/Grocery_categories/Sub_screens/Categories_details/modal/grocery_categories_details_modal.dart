import 'package:get/get.dart';

class GroceryCategoriesDetailsModal {
  bool? status;
  List<CategoryProduct>? categoryProduct;
  List<CategoryProduct>? filterProduct;
  String? message;

  GroceryCategoriesDetailsModal(
      {this.status, this.categoryProduct, this.filterProduct, this.message});

  GroceryCategoriesDetailsModal.fromJson(Map<String, dynamic> json) {
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
    data['status'] = status;
    if (categoryProduct != null) {
      data['categoryProduct'] =
          categoryProduct!.map((v) => v.toJson()).toList();
    }
    if (filterProduct != null) {
      data['filterProduct'] =
          filterProduct!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
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
  String? groceryName;
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
    this.groceryName,
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
    groceryName = json['grocery_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['packaging_value'] = packagingValue;
    data['category_id'] = categoryId;
    data['is_in_wishlist'] = isInWishlist;
    data['shop_name'] = shopName;
    data['url_image'] = urlImage;
    data['category_name'] = categoryName;
    data['grocery_name'] = groceryName;
    return data;
  }
}
