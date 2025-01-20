import 'dart:convert';

import 'package:get/get.dart';

class BannerModal {
  bool? status;
  List<Category>? category;
  List<PharmaShops>? restaurants;
  List<Products>? products;
  String? message;
  CurrentBanner? currentBanner;

  BannerModal({
    this.status,
    this.category,
    // this.restaurants,
    this.products,
    this.message,
    this.currentBanner,
  });

  BannerModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    if (json['restaurants'] != null) {
      restaurants = <PharmaShops>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(
            PharmaShops.fromJson(v)); // Assuming Restaurant class exists.
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v)); // Assuming Product class exists.
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
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
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

class Products {
  int? id;
  String? image;
  int? rating;
  int? salePrice;
  String? regularPrice;
  String? title;
  String? addimg;
  int? userId;
  bool? isInWishlist;
  String? restoName;
  List<String>? urlAddimg;
  String? urlImage;
  int? categoryId;
  String? categoryName;
  Rx<bool> isLoading = false.obs;


  Products({
    this.id,
    this.image,
    this.rating,
    this.salePrice,
    this.regularPrice,
    this.title,
    this.addimg,
    this.userId,
    this.isInWishlist,
    this.restoName,
    this.urlAddimg,
    this.urlImage,
    this.categoryId,
    this.categoryName,
  });

  // From JSON constructor
  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    rating = json['rating'];
    salePrice = json['sale_price'];
    regularPrice = json['regular_price'];
    title = json['title'];
    addimg = json['addimg'];
    userId = json['user_id'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    urlAddimg = json['url_addimg'].cast<String>();
    urlImage = json['url_image'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['sale_price'] = this.salePrice;
    data['regular_price'] = this.regularPrice;
    data['title'] = this.title;
    data['addimg'] = this.addimg;
    data['user_id'] = this.userId;
    data['is_in_wishlist'] = this.isInWishlist;
    data['resto_name'] = this.restoName;
    data['url_addimg'] = this.urlAddimg;
    data['url_image'] = this.urlImage;
    data['category_id'] = this.categoryId;
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
  String? rating;
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

