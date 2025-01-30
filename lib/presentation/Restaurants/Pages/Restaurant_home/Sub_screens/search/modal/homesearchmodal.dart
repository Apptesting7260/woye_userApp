import 'package:get/get.dart';

class HomeSearchModal {
  bool? status;
  List<Products>? products;
  List<Restaurants>? restaurants;
  String? message;

  HomeSearchModal({this.status, this.products, this.restaurants, this.message});

  HomeSearchModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    products = json['Products'] != null
        ? (json['Products'] as List).map((v) => Products.fromJson(v)).toList()
        : [];
    restaurants = json['Restaurants'] != null
        ? (json['Restaurants'] as List)
            .map((v) => Restaurants.fromJson(v))
            .toList()
        : [];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.products != null) {
      data['Products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.restaurants != null) {
      data['Restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Products {
  int? id;
  String? image;
  int? rating;
  var salePrice;
  var regularPrice;
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

class Restaurants {
  int? id;
  String? firstName;
  String? lastName;
  String? name;
  String? email;
  String? image;
  String? dob;
  String? gender;
  String? pPassword;
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
  int? countryId;
  int? stateId;
  int? cityId;
  String? role;
  int? status;
  String? createdAt;
  String? updatedAt;

  Restaurants(
      {this.id,
      this.firstName,
      this.lastName,
      this.name,
      this.email,
      this.image,
      this.dob,
      this.gender,
      this.pPassword,
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
      this.countryId,
      this.stateId,
      this.cityId,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    dob = json['dob'];
    gender = json['gender'];
    pPassword = json['p_password'];
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
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    role = json['role'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['p_password'] = this.pPassword;
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
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
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
