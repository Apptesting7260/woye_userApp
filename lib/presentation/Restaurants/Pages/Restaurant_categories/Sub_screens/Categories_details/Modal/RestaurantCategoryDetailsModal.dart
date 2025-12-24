import 'package:get/get_rx/src/rx_types/rx_types.dart';

class RestaurantCategoryDetailsModal {
  bool? status;
  List<CategoryProduct>? categoryProduct;
  List<CategoryProduct>? filterProduct;
  String? message;

  RestaurantCategoryDetailsModal(
      {this.status, this.categoryProduct, this.message});

  RestaurantCategoryDetailsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categoryProduct'] != null) {
      categoryProduct = <CategoryProduct>[];
      json['categoryProduct'].forEach((v) {
        categoryProduct!.add(CategoryProduct.fromJson(v));
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
    final Map<String, dynamic> data = {};
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
  String? id;
  String? image;
  var salePrice;
  var regularPrice;
  String? title;
  String? preparationTime;
  bool? isInWishlist;
  String? restoName;
  String? urlImage;
  String? vendorId;
  var rating;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isAddToCart = false.obs;
  Rx<bool> isCartLoading  = false.obs;

  CategoryProduct({
    this.id,
    this.image,
    this.salePrice,
    this.regularPrice,
    this.title,
    this.preparationTime,
    this.isInWishlist,
    this.restoName,
    this.urlImage,
    this.vendorId,
    this.rating,
  }){
    isCartLoading = false.obs;
  }

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    image = json['image_url'].toString();
    salePrice = json['sale_price'].toString();
    regularPrice = json['regular_price'].toString();
    title = json['title'].toString();
    preparationTime = json['preparation_time'].toString();
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'].toString();
    urlImage = json['url_image'];
    vendorId = json['vendor_id']?.toString();
    rating = json['rating'].toString();
    isCartLoading = false.obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['image_url'] = this.image;
    data['sale_price'] = this.salePrice;
    data['regular_price'] = this.regularPrice;
    data['title'] = this.title;
    data['preparation_time'] = this.preparationTime;
    data['is_in_wishlist'] = this.isInWishlist;
    data['resto_name'] = this.restoName;
    data['url_image'] = this.urlImage;
    data['vendor_id'] = this.vendorId;
    data['rating'] = this.rating;
    return data;
  }
}
