import 'package:get/get.dart';

class SpecificRestaurantModal {
  bool? status;
  Restaurant? restaurant;
  List<MoreProducts>? moreProducts;
  String? message;

  SpecificRestaurantModal({this.status, this.restaurant, this.message});

  SpecificRestaurantModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    restaurant = json['restaurant'] != null
        ? Restaurant.fromJson(json['restaurant'])
        : null;
    if (json['moreProducts'] != null) {
      moreProducts = <MoreProducts>[];
      json['moreProducts'].forEach((v) {
        moreProducts!.add(new MoreProducts.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    if (this.moreProducts != null) {
      data['moreProducts'] = this.moreProducts!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Restaurant {
  int? id;
  String? name;
  String? email;
  String? image;
  String? dob;
  String? gender;
  String? otp;
  String? rating;
  String? avgPrice;
  String? currentStatus;
  String? phoneCode;
  String? phone;
  String? imageUrl;
  String? shopName;
  String? shopEmail;
  String? shopimage;
  String? shopAddress;
  String? shopDes;
  List<OpeningHours>? openingHours;
  int? countryId;
  int? stateId;
  int? cityId;
  // List<String>? categoryId;
  String? opensAt;
  String? closesAt;
  String? role;
  int? status;
  String? createdAt;
  String? updatedAt;

  Restaurant({
    this.id,
    this.name,
    this.email,
    this.image,
    this.dob,
    this.gender,
    this.otp,
    this.rating,
    this.avgPrice,
    this.currentStatus,
    this.phoneCode,
    this.phone,
    this.imageUrl,
    this.shopName,
    this.shopEmail,
    this.shopimage,
    this.shopAddress,
    this.shopDes,
    this.openingHours,
    this.countryId,
    this.stateId,
    this.cityId,
    // this.categoryId,
    this.opensAt,
    this.closesAt,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    dob = json['dob'];
    gender = json['gender'];
    otp = json['otp'];
    rating = json['rating'];
    avgPrice = json['avg_price'];
    currentStatus = json['current_status'];
    phoneCode = json['phone_code'];
    phone = json['phone'];
    imageUrl = json['image_url'];
    shopName = json['shop_name'];
    shopEmail = json['shop_email'];
    shopimage = json['shopimage'];
    shopAddress = json['shop_address'];
    shopDes = json['shop_des'];

    // Mapping the list of opening hours
    if (json['opening_hours'] != null) {
      openingHours = [];
      json['opening_hours'].forEach((v) {
        openingHours!.add(OpeningHours.fromJson(v));
      });
    }

    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    // categoryId = json['category_id'] != null
    //     ? List<String>.from(json['category_id'])
    //     : null;
    opensAt = json['opens_at'];
    closesAt = json['closes_at'];
    role = json['role'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['otp'] = this.otp;
    data['rating'] = this.rating;
    data['avg_price'] = this.avgPrice;
    data['current_status'] = this.currentStatus;
    data['phone_code'] = this.phoneCode;
    data['phone'] = this.phone;
    data['image_url'] = this.imageUrl;
    data['shop_name'] = this.shopName;
    data['shop_email'] = this.shopEmail;
    data['shopimage'] = this.shopimage;
    data['shop_address'] = this.shopAddress;
    data['shop_des'] = this.shopDes;

    if (this.openingHours != null) {
      data['opening_hours'] =
          this.openingHours!.map((v) => v.toJson()).toList();
    }

    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    // data['category_id'] = this.categoryId;
    data['opens_at'] = this.opensAt;
    data['closes_at'] = this.closesAt;
    data['role'] = this.role;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OpeningHours {
  String? day;
  String? open;
  String? close;
  String? status;

  OpeningHours({this.day, this.open, this.close, this.status});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    open = json['open'];
    close = json['close'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['day'] = this.day;
    data['open'] = this.open;
    data['close'] = this.close;
    data['status'] = this.status;
    return data;
  }
}

class MoreProducts {
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

  MoreProducts({
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

  MoreProducts.fromJson(Map<String, dynamic> json) {
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

    // Assign values to the new keys
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
