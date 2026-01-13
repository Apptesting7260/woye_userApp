import 'package:get/get.dart';

class PharmaHomeSearchModal {
  bool? status;
  List<CategoryProduct>? products;
  List<shop>? pharmaShop;
  String? message;

  PharmaHomeSearchModal(
      {this.status, this.products, this.pharmaShop, this.message});

  PharmaHomeSearchModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    products = json['products'] != null
        ? (json['products'] as List).map((v) => CategoryProduct.fromJson(v)).toList()
        : [];
    pharmaShop = json['pharma_shops'] != null
        ? (json['pharma_shops'] as List).map((v) => shop.fromJson(v)).toList()
        : [];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.pharmaShop != null) {
      data['pharma_shops'] = this.pharmaShop!.map((v) => v.toJson()).toList();
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

class shop {
  int? id;
  String? firstName;
  String? lastName;
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

  shop({
    this.id,
    this.firstName,
    this.lastName,
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

  shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
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
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
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
  Sunday? sunday;
  Sunday? monday;
  Sunday? tuesday;
  Sunday? wednesday;
  Sunday? thursday;
  Sunday? friday;
  Sunday? saturday;

  OpeningHours(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    sunday =
        json['Sunday'] != null ? new Sunday.fromJson(json['Sunday']) : null;
    monday =
        json['Monday'] != null ? new Sunday.fromJson(json['Monday']) : null;
    tuesday =
        json['Tuesday'] != null ? new Sunday.fromJson(json['Tuesday']) : null;
    wednesday = json['Wednesday'] != null
        ? new Sunday.fromJson(json['Wednesday'])
        : null;
    thursday =
        json['Thursday'] != null ? new Sunday.fromJson(json['Thursday']) : null;
    friday =
        json['Friday'] != null ? new Sunday.fromJson(json['Friday']) : null;
    saturday =
        json['Saturday'] != null ? new Sunday.fromJson(json['Saturday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sunday != null) {
      data['Sunday'] = this.sunday!.toJson();
    }
    if (this.monday != null) {
      data['Monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['Tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['Wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['Thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['Friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['Saturday'] = this.saturday!.toJson();
    }
    return data;
  }
}

class Sunday {
  String? status;
  String? open;
  String? close;

  Sunday({this.status, this.open, this.close});

  Sunday.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    open = json['open'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['open'] = this.open;
    data['close'] = this.close;
    return data;
  }
}
