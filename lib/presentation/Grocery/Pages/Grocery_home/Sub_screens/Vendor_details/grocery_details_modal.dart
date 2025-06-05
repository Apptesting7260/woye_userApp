import 'package:get/get.dart';

class SpecificGroceryModal {
  bool? status;
  shop? pharmaShop;
  Categories? categories;
  List<Highlights>? highlights;
  List<MoreProducts>? moreProducts;
  List<Review>? review;
  String? message;
  var totalReviews;
  var averageRating;

  SpecificGroceryModal({
    this.status,
    this.pharmaShop,
    this.categories,
    this.highlights,
    this.review,
    this.message,
    this.totalReviews,
    this.averageRating,
  });

  SpecificGroceryModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pharmaShop = json['grocery'] != null ? shop.fromJson(json['grocery']) : null;
    categories = json['categories'] != null
        ? Categories.fromJson(json['categories'])
        : null;
    if (json['highlights'] != null) {
      highlights = <Highlights>[];
      json['highlights'].forEach((v) {
        highlights!.add(Highlights.fromJson(v));
      });
    }
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
    data['status'] = status;

    if (pharmaShop != null) {
      data['grocery'] = pharmaShop!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.toJson();
    }

    if (highlights != null) {
      data['highlights'] = highlights!.map((v) => v.toJson()).toList();
    }
    if (moreProducts != null) {
      data['moreProducts'] = moreProducts!.map((v) => v.toJson()).toList();
    }

    if (review != null) {
      data['reviews'] = review!.map((v) => v.toJson()).toList();
    }

    data['message'] = message;

    // Add the new fields to the JSON
    data['totalReviews'] = totalReviews;
    data['average_rating'] = averageRating;

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
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['image'] = image;
    data['dob'] = dob;
    data['gender'] = gender;
    data['otp'] = otp;
    data['rating'] = rating;
    data['avg_price'] = avgPrice;
    data['current_status'] = currentStatus;
    data['phone_code'] = phoneCode;
    data['phone'] = phone;
    data['image_url'] = imageUrl;
    data['shop_name'] = shopName;
    data['shop_email'] = shopEmail;
    data['shopimage'] = shopimage;
    data['shop_address'] = shopAddress;
    data['shop_des'] = shopDes;

    if (openingHours != null) {
      data['opening_hours'] =
          openingHours!.map((v) => v.toJson()).toList();
    }

    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    // data['category_id'] = this.categoryId;
    data['opens_at'] = opensAt;
    data['closes_at'] = closesAt;
    data['role'] = role;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    // Add latitude and longitude to JSON
    data['latitude'] = latitude;
    data['longitude'] = longitude;

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
    data['day'] = day;
    data['open'] = open;
    data['close'] = close;
    data['status'] = status;
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
    shopName = json['grocery_name'];
    urlImage = json['url_image'];
    categoryName = json['category_name'];
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
    data['grocery_name'] = shopName;
    data['url_image'] = urlImage;
    data['category_name'] = categoryName;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['first_name'] = firstName;
    return data;
  }
}

class Categories {
  Map<String, List<AllProducts>> data = {};

  Categories();

  Categories.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      if (value is List) {
        data[key] = value.map((item) => AllProducts.fromJson(item)).toList();
      }
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    data.forEach((key, value) {
      json[key] = value.map((item) => item.toJson()).toList();
    });
    return json;
  }

}

class AllProducts {
  String? id;
  String? image;
  String? rating;
  String? salePrice;
  String? regularPrice;
  String? title;
  String? addimg;
  String? userId;
  String? categoryId;
  bool? isInWishlist;
  String? restoName;
  String? categoryName;
  String? productreviewCount;
  List<String>? urlAddimg;
  String? urlImage;
  Rx<bool> isLoading = false.obs;

  // List<Null>? addOnWithNames;
  // List<Null>? productreview;

  AllProducts({
    this.id,
    this.image,
    this.rating,
    this.salePrice,
    this.regularPrice,
    this.title,
    this.addimg,
    this.userId,
    this.categoryId,
    this.isInWishlist,
    this.restoName,
    this.categoryName,
    this.productreviewCount,
    this.urlAddimg,
    this.urlImage,
    // this.addOnWithNames,
    // this.productreview,
  });

  AllProducts.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    image = json['image']?.toString();
    rating = json['rating']?.toString();
    salePrice = json['sale_price']?.toString();
    regularPrice = json['regular_price']?.toString();
    title = json['title']?.toString();
    addimg = json['addimg']?.toString();
    userId = json['user_id']?.toString();
    categoryId = json['category_id']?.toString();
    isInWishlist = json['is_in_wishlist'];
    restoName = json['grocery_name']?.toString();
    categoryName = json['category_name']?.toString();
    productreviewCount = json['productreview_count']?.toString();
    urlAddimg = (json['url_addimg'] as List?)?.cast<String>() ?? [];
    urlImage = json['url_image']?.toString();
    // if (json['add_on_with_names'] != null) {
    //   addOnWithNames = <Null>[];
    //   json['add_on_with_names'].forEach((v) {
    //     addOnWithNames!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['productreview'] != null) {
    //   productreview = <Null>[];
    //   json['productreview'].forEach((v) {
    //     productreview!.add(new Null.fromJson(v));
    //   });
    // }
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
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['is_in_wishlist'] = isInWishlist;
    data['resto_name'] = restoName;
    data['category_name'] = categoryName;
    data['productreview_count'] = productreviewCount;
    data['url_addimg'] = urlAddimg;
    data['url_image'] = urlImage;
    // if (this.productreview != null) {
    //   data['productreview'] =
    //       this.productreview!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Highlights {
  String? id;
  String? image;
  String? rating;
  String? salePrice;
  String? regularPrice;
  String? title;
  String? addimg;
  String? userId;
  String? categoryId;
  String? isWishlist;
  String? categoryName;
  String? groceryName;
  List<String>? urlAddimg;
  String? urlImage;
  RxBool isInWishlist =  false.obs;
  RxBool isLoading = false.obs;


  // Category? category;

  Highlights({
    this.id,
    this.image,
    this.rating,
    this.salePrice,
    this.regularPrice,
    this.title,
    this.addimg,
    this.userId,
    this.categoryId,
    this.isWishlist,
    this.categoryName,
    this.groceryName,
    this.urlAddimg,
    this.urlImage,
    /*this.category*/
  });

  Highlights.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    image = json['image']?.toString();
    rating = json['rating']?.toString();
    salePrice = json['sale_price']?.toString();
    regularPrice = json['regular_price']?.toString();
    title = json['title']?.toString();
    addimg = json['addimg']?.toString();
    userId = json['user_id']?.toString();
    categoryId = json['category_id']?.toString();
    isWishlist = json['is_in_wishlist']?.toString();
    categoryName = json['category_name']?.toString();
    groceryName = json['grocery_name']?.toString();
    urlAddimg = json['url_addimg'].cast<String>();
    urlImage = json['url_image']?.toString();
    // category = json['category'] != null ? new Category.fromJson(json['category']) : null;
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
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['is_in_wishlist'] = isWishlist;
    data['category_name'] = categoryName;
    data['grocery_name'] = groceryName;
    data['url_addimg'] = urlAddimg;
    data['url_image'] = urlImage;
    // if (this.category != null) {
    //   data['category'] = this.category!.toJson();
    // }
    return data;
  }
}
