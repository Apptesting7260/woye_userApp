import 'package:get/get.dart';

class SpecificGroceryModal {
  bool? status;
  shop? pharmaShop;
  List<MoreProducts>? moreProducts;
  List<Review>? review;
  String? message;
  var totalReviews;
  var averageRating;

  SpecificGroceryModal({
    this.status,
    this.pharmaShop,
    this.review,
    this.message,
    this.totalReviews,
    this.averageRating,
  });

  SpecificGroceryModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pharmaShop = json['grocery'] != null ? shop.fromJson(json['grocery']) : null;

    if (json['moreProducts'] != null) {
      moreProducts = <MoreProducts>[];
      json['moreProducts'].forEach((v) {
        moreProducts!.add(MoreProducts.fromJson(v));
      });
    }

    if (json['reviews'] != null) {
      review = <Review>[];
      json['reviews'].forEach((v) {
        review!.add(Review.fromJson(v));
      });
    }

    message = json['message'];

    // Parse the new fields
    totalReviews = json['totalReviews'];
    averageRating = json['average_rating'];
    // averageRating = json['average_rating'] != null ? json['average_rating'].toDouble() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;

    if (this.pharmaShop != null) {
      data['grocery'] = this.pharmaShop!.toJson();
    }

    if (this.moreProducts != null) {
      data['moreProducts'] = this.moreProducts!.map((v) => v.toJson()).toList();
    }

    if (review != null) {
      data['reviews'] = review!.map((v) => v.toJson()).toList();
    }

    data['message'] = this.message;

    // Add the new fields to the JSON
    data['totalReviews'] = this.totalReviews;
    data['average_rating'] = this.averageRating;

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
  var rating;
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

  // New fields for latitude and longitude
  String? latitude;
  String? longitude;

  // String? categoryId;
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
    this.latitude,
    this.longitude,
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

    // Add parsing of latitude and longitude from JSON
    latitude = json['latitude'];
    longitude = json['longitude'];
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

    // Add latitude and longitude to JSON
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

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

  MoreProducts({
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

  MoreProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    packagingValue = json['packaging_value'];
    categoryId = json['category_id'];
    isInWishlist = json['is_in_wishlist'];
    shopName = json['pharma_name'];
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
    data['pharma_name'] = this.shopName;
    data['url_image'] = this.urlImage;
    data['category_name'] = this.categoryName;
    return data;
  }
}
class Review {
  int? id;
  var userId;
  String? username;
  int? productId;
  var rating;
  String? message;
  String? reply;
  String? createdAt;
  String? updatedAt;
  User? user;

  Review(
      {this.id,
        this.userId,
        this.username,
        this.productId,
        this.rating,
        this.message,
        this.reply,
        this.createdAt,
        this.updatedAt,
        this.user});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
    productId = json['product_id'];
    rating = json['rating'];
    // rating = json['rating']?.toDouble();
    message = json['review'];
    reply = json['reply'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['username'] = username;
    data['product_id'] = productId;
    data['rating'] = rating;
    data['review'] = message;
    data['reply'] = reply;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  var id;
  String? imageUrl;
  String? firstName;

  User({this.id, this.imageUrl, this.firstName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['first_name'] = this.firstName;
    return data;
  }
}