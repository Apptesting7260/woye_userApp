import 'package:get/get.dart';
class RestaurantProductWishlistModal {
  bool? status;
  List<CategoryProduct>? categoryProduct;
  String? message;

  RestaurantProductWishlistModal(
      {this.status, this.categoryProduct, this.message});

  RestaurantProductWishlistModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categoryProduct'] != null) {
      categoryProduct = <CategoryProduct>[];
      json['categoryProduct'].forEach((v) {
        categoryProduct!.add(CategoryProduct.fromJson(v));
      });
    }
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (categoryProduct != null) {
      data['categoryProduct'] =
          categoryProduct!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class CategoryProduct {
  String? id;
  String? image;
  String? rating;
  String? salePrice;
  String? regularPrice;
  String? title;
  String? addimg;
  String? vendorId;
  String? categoryId;
  bool? isInWishlist;
  String? categoryName;
  String? restoName;
  List<String>? addimgUrl;
  String? imageUrl;
  String? cuisineName;
  String? brandName;
  String? packagingName;
  String? applicationName;
  String? productAttributeName;
  String? cuisine;
  String? brand;
  String? packaging;
  String? application;
  Rx<bool> isLoading = false.obs;

  CategoryProduct(
      {this.id,
        this.image,
        this.rating,
        this.salePrice,
        this.regularPrice,
        this.title,
        this.addimg,
        this.vendorId,
        this.categoryId,
        this.isInWishlist,
        this.categoryName,
        this.restoName,
        this.addimgUrl,
        this.imageUrl,
        this.cuisineName,
        this.brandName,
        this.packagingName,
        this.applicationName,
        this.productAttributeName,
        this.cuisine,
        this.brand,
        this.packaging,
        this.application,
      });

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    image = json['image']?.toString();
    rating = json['rating']?.toString();
    salePrice = json['sale_price']?.toString();
    regularPrice = json['regular_price']?.toString();
    title = json['title']?.toString();
    addimg = json['addimg']?.toString();
    vendorId = json['vendor_id']?.toString();
    categoryId = json['category_id']?.toString();
    isInWishlist = json['is_in_wishlist'];
    categoryName = json['category_name']?.toString();
    restoName = json['resto_name']?.toString();
    addimgUrl = json['addimg_url'].cast<String>();
    imageUrl = json['image_url']?.toString();
    cuisineName = json['cuisine_name']?.toString();
    brandName = json['brand_name']?.toString();
    packagingName = json['packaging_name']?.toString();
    applicationName = json['application_name']?.toString();
    productAttributeName = json['product_attribute_name']?.toString();
    cuisine = json['cuisine']?.toString();
    brand = json['brand']?.toString();
    packaging = json['packaging']?.toString();
    application = json['application']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['rating'] = rating;
    data['sale_price'] = salePrice;
    data['regular_price'] = regularPrice;
    data['title'] = title;
    data['addimg'] = addimg;
    data['vendor_id'] = vendorId;
    data['category_id'] = categoryId;
    data['is_in_wishlist'] = isInWishlist;
    data['category_name'] = categoryName;
    data['resto_name'] = restoName;
    data['addimg_url'] = addimgUrl;
    data['image_url'] = imageUrl;
    data['cuisine_name'] = cuisineName;
    data['brand_name'] = brandName;
    data['packaging_name'] = packagingName;
    data['application_name'] = applicationName;
    data['product_attribute_name'] = productAttributeName;
    data['cuisine'] = cuisine;
    data['brand'] = brand;
    data['packaging'] = packaging;
    data['application'] = application;
    return data;
  }
}

//
// class restaurant_product_wishlist_modal {
//   bool? status;
//   List<CategoryProduct>? categoryProduct;
//   String? message;
//
//   restaurant_product_wishlist_modal(
//       {this.status, this.categoryProduct, this.message});
//
//   restaurant_product_wishlist_modal.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['categoryProduct'] != null) {
//       categoryProduct = <CategoryProduct>[];
//       json['categoryProduct'].forEach((v) {
//         categoryProduct!.add(new CategoryProduct.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.categoryProduct != null) {
//       data['categoryProduct'] =
//           this.categoryProduct!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class CategoryProduct {
//   int? id;
//   String? title;
//   int? userId;
//   int? categoryId;
//   String? categoryName;
//   var regularPrice;
//   var salePrice;
//   String? description;
//   String? discount;
//   int? rating;
//   String? image;
//   bool? isInWishlist;
//   String? urlImage;
//   Rx<bool> isLoading = false.obs;
//
//   CategoryProduct({
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
//     this.image,
//     this.isInWishlist,
//     this.urlImage,
//   });
//
//   CategoryProduct.fromJson(Map<String, dynamic> json) {
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
//     image = json['image'];
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
//     data['image'] = this.image;
//     data['is_in_wishlist'] = this.isInWishlist;
//     data['url_image'] = this.urlImage;
//     return data;
//   }
// }
