import 'package:get/get.dart';

class GroceryBannerModal {
  bool? status;
  List<Category>? category;
  List<PharmaShops>? groceryShops;
  List<CategoryProduct>? products;
  String? message;
  CurrentBanner? currentBanner;

  GroceryBannerModal({
    this.status,
    this.category,
    this.groceryShops,
    this.products,
    this.message,
    this.currentBanner,
  });

  GroceryBannerModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    if (json['groceries'] != null) {
      groceryShops = <PharmaShops>[];
      json['groceries'].forEach((v) {
        groceryShops!.add(PharmaShops.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <CategoryProduct>[];
      json['products'].forEach((v) {
        products!.add(CategoryProduct.fromJson(v));
      });
    }
    message = json['message'];
    if (json['currentBanner'] != null) {
      currentBanner = CurrentBanner.fromJson(json['currentBanner']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.groceryShops != null) {
      data['groceries'] = this.groceryShops!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    if (this.currentBanner != null) {
      data['currentBanner'] = this.currentBanner!.toJson();
    }
    return data;
  }
}

class CurrentBanner {
  int? id;
  String? imageUrl;

  CurrentBanner({this.id, this.imageUrl});

  CurrentBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? parentCategory;
  String? image;
  String? imageUrl;

  Category({
    this.id,
    this.name,
    this.parentCategory,
    this.image,
    this.imageUrl,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentCategory = json['parent_category'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_category'] = this.parentCategory;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
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
    shopName = json['grocery_name'];
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
    data['grocery_name'] = this.shopName;
    data['url_image'] = this.urlImage;
    data['category_name'] = this.categoryName;
    return data;
  }
}

class PharmaShops {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? dob;
  String? shopimage;
  String? shopName;
  String? shopAddress;
  String? opensAt;
  String? closesAt;
  var rating;
  String? avgPrice;

  PharmaShops(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.gender,
      this.dob,
      this.shopimage,
      this.shopName,
      this.shopAddress,
      this.opensAt,
      this.closesAt,
      this.rating,
      this.avgPrice});

  PharmaShops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    dob = json['dob'];
    shopimage = json['shopimage'];
    shopName = json['shop_name'];
    shopAddress = json['shop_address'];
    opensAt = json['opens_at'];
    closesAt = json['closes_at'];
    rating = json['rating'];
    avgPrice = json['avg_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['shopimage'] = this.shopimage;
    data['shop_name'] = this.shopName;
    data['shop_address'] = this.shopAddress;
    data['opens_at'] = this.opensAt;
    data['closes_at'] = this.closesAt;
    data['rating'] = this.rating;
    data['avg_price'] = this.avgPrice;
    return data;
  }
}
