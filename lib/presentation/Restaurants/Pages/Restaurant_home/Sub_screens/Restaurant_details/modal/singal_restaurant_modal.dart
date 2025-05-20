import 'package:get/get.dart';

class SpecificRestaurantModal {
  bool? status;
  Restaurant? restaurant;
  Categories? categories;
  List<MoreProducts>? moreProducts;
  List<Highlights>? highlights;
  String? message;
  List<Review>? review;
  var totalReviews;
  var averageRating;

  SpecificRestaurantModal({
    this.status,
    this.restaurant,
    this.categories,
    this.message,
    this.review,
    this.totalReviews,
    this.averageRating,
  });

  SpecificRestaurantModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    restaurant = json['restaurant'] != null
        ? Restaurant.fromJson(json['restaurant'])
        : null;
    categories = json['categories'] != null
        ? Categories.fromJson(json['categories'])
        : null;
    if (json['moreProducts'] != null) {
      moreProducts = <MoreProducts>[];
      json['moreProducts'].forEach((v) {
        moreProducts!.add(MoreProducts.fromJson(v));
      });
    }
    if (json['highlights'] != null) {
      highlights = <Highlights>[];
      json['highlights'].forEach((v) {
        highlights!.add(Highlights.fromJson(v));
      });
    }
    message = json['message'];
    if (json['reviews'] != null) {
      review = <Review>[];
      json['reviews'].forEach((v) {
        review!.add(Review.fromJson(v));
      });
    }
    totalReviews = json['totalReviews'];
    averageRating = json['average_rating'];
    // averageRating = json['average_rating'] != null
    //     ? double.tryParse(
    //         json['average_rating'].toString())
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (restaurant != null) {
      data['restaurant'] = restaurant!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.toJson();
    }
    if (moreProducts != null) {
      data['moreProducts'] = moreProducts!.map((v) => v.toJson()).toList();
    }
    if (highlights != null) {
      data['highlights'] = highlights!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    if (review != null) {
      data['reviews'] = review!.map((v) => v.toJson()).toList();
    }
    data['totalReviews'] =
        totalReviews; // Include totalReviews in the JSON
    data['average_rating'] =
        averageRating; // Include average_rating in the JSON
    return data;
  }
}

class Restaurant {
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

  // List<String>? categoryId;
  String? opensAt;
  String? closesAt;
  String? role;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? latitude;
  String? longitude;

  Restaurant({
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

  Restaurant.fromJson(Map<String, dynamic> json) {
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
  String? image;
  int? rating;
  var salePrice;
  var regularPrice;
  String? title;
  int? userId;
  bool? isInWishlist;
  String? restoName;

  // List<String>? urlAddimg;
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
    this.userId,
    this.isInWishlist,
    this.restoName,
    // this.urlAddimg,
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
    userId = json['user_id'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    // urlAddimg = json['url_addimg'].cast<String>();
    urlImage = json['url_image'];

    // Assign values to the new keys
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['rating'] = rating;
    data['sale_price'] = salePrice;
    data['regular_price'] = regularPrice;
    data['title'] = title;
    data['user_id'] = userId;
    data['is_in_wishlist'] = isInWishlist;
    data['resto_name'] = restoName;
    // data['url_addimg'] = this.urlAddimg;
    data['url_image'] = urlImage;
    data['category_id'] = categoryId;
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


class Highlights {
  int? id;
  String? image;
  String? rating;
  String? salePrice;
  String? regularPrice;
  String? title;
  String? addimg;
  String? userId;
  String? categoryId;
  String? isWishlist;
  List<String>? urlAddimg;
  String? restoName;
  String? urlImage;
  // List<Null>? addOnWithNames;
  // RestaurantHigh? restaurantHigh;
  Category? category;
  RxBool isInWishlist =  false.obs;
  RxBool isLoading = false.obs;
  // List<Productreview>? productreview;

  Highlights(
      {this.id,
        this.image,
        this.rating,
        this.salePrice,
        this.regularPrice,
        this.title,
        this.addimg,
        this.userId,
        this.categoryId,
        this.isWishlist,
        this.urlAddimg,
        this.restoName,
        this.urlImage,
        // this.addOnWithNames,
        // this.restaurantHigh,
        this.category,
        // this.productreview,
      });

  Highlights.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image']?.toString();
    rating = json['rating']?.toString();
    salePrice = json['sale_price']?.toString();
    regularPrice = json['regular_price']?.toString();
    title = json['title']?.toString();
    addimg = json['addimg']?.toString();
    userId = json['user_id']?.toString();
    categoryId = json['category_id']?.toString();
    isWishlist = json['is_in_wishlist']?.toString();
    if(json['url_addimg'] != null){
      urlAddimg = json['url_addimg'].cast<String>();
    }else{
      urlAddimg = [];
    }
    restoName = json['resto_name']?.toString();
    urlImage = json['url_image']?.toString();
    // if (json['add_on_with_names'] != null) {
    //   addOnWithNames = <Null>[];
    //   json['add_on_with_names'].forEach((v) {
    //     addOnWithNames!.add(new Null.fromJson(v));
    //   });
    // }
    // restaurantHigh = json['restaurant'] != null
    //     ? RestaurantHigh.fromJson(json['restaurant'])
    //     : null;
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    // if (json['productreview'] != null) {
    //   productreview = <Productreview>[];
    //   json['productreview'].forEach((v) {
    //     productreview!.add(new Productreview.fromJson(v));
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
    data['is_in_wishlist'] = isWishlist;
    data['url_addimg'] = urlAddimg;
    data['resto_name'] = restoName;
    data['url_image'] = urlImage;
    // if (this.addOnWithNames != null) {
    //   data['add_on_with_names'] =
    //       this.addOnWithNames!.map((v) => v.toJson()).toList();
    // }
    // if (restaurantHigh != null) {
    //   data['restaurant'] = restaurantHigh!.toJson();
    // }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    // if (this.productreview != null) {
    //   data['productreview'] =
    //       this.productreview!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
// class RestaurantHigh {
//   int? id;
//   String? firstName;
//   String? lastName;
//   String? name;
//   String? email;
//   String? image;
//   String? dob;
//   String? gender;
//   String? rating;
//   String? emailVerify;
//   String? avgPrice;
//   String? currentStatus;
//   String? phoneCode;
//   String? phone;
//   String? step;
//   String? deviceToken;
//   String? imageUrl;
//   String? shopName;
//   String? shopEmail;
//   String? shopimage;
//   String? shopAddress;
//   String? latitude;
//   String? longitude;
//   String? shopDes;
//   OpeningHours? openingHours;
//   List<int>? categoryId;
//   String? role;
//   String? status;
//   String? delivery;
//   String? addedBy;
//   String? createdAt;
//   String? updatedAt;
//
//   RestaurantHigh(
//       {this.id,
//         this.firstName,
//         this.lastName,
//         this.name,
//         this.email,
//         this.image,
//         this.dob,
//         this.gender,
//         this.rating,
//         this.emailVerify,
//         this.avgPrice,
//         this.currentStatus,
//         this.phoneCode,
//         this.phone,
//         this.step,
//         this.deviceToken,
//         this.imageUrl,
//         this.shopName,
//         this.shopEmail,
//         this.shopimage,
//         this.shopAddress,
//         this.latitude,
//         this.longitude,
//         this.shopDes,
//         this.openingHours,
//         this.categoryId,
//         this.role,
//         this.status,
//         this.delivery,
//         this.addedBy,
//         this.createdAt,
//         this.updatedAt});
//
//   RestaurantHigh.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firstName = json['first_name']?.toString();
//     lastName = json['last_name']?.toString();
//     name = json['name']?.toString();
//     email = json['email']?.toString();
//     image = json['image']?.toString();
//     dob = json['dob']?.toString();
//     gender = json['gender']?.toString();
//     rating = json['rating']?.toString();
//     emailVerify = json['email_verify']?.toString();
//     avgPrice = json['avg_price']?.toString();
//     currentStatus = json['current_status']?.toString();
//     phoneCode = json['phone_code']?.toString();
//     phone = json['phone']?.toString();
//     step = json['step']?.toString();
//     deviceToken = json['device_token']?.toString();
//     imageUrl = json['image_url']?.toString();
//     shopName = json['shop_name']?.toString();
//     shopEmail = json['shop_email']?.toString();
//     shopimage = json['shopimage']?.toString();
//     shopAddress = json['shop_address']?.toString();
//     latitude = json['latitude']?.toString();
//     longitude = json['longitude']?.toString();
//     shopDes = json['shop_des']?.toString();
//     openingHours = json['opening_hours'] != null
//         ? OpeningHours.fromJson(json['opening_hours'])
//         : null;
//     if(json['category_id'] != null){
//       categoryId = json['category_id'].cast<int>();
//     }else{
//       categoryId = [];
//     }
//     role = json['role']?.toString();
//     status = json['status']?.toString();
//     delivery = json['delivery']?.toString();
//     addedBy = json['added_by']?.toString();
//     createdAt = json['created_at']?.toString();
//     updatedAt = json['updated_at']?.toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['name'] = name;
//     data['email'] = email;
//     data['image'] = image;
//     data['dob'] = dob;
//     data['gender'] = gender;
//     data['rating'] = rating;
//     data['email_verify'] = emailVerify;
//     data['avg_price'] = avgPrice;
//     data['current_status'] = currentStatus;
//     data['phone_code'] = phoneCode;
//     data['phone'] = phone;
//     data['step'] = step;
//     data['device_token'] = deviceToken;
//     data['image_url'] = imageUrl;
//     data['shop_name'] = shopName;
//     data['shop_email'] = shopEmail;
//     data['shopimage'] = shopimage;
//     data['shop_address'] = shopAddress;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['shop_des'] = shopDes;
//     if (openingHours != null) {
//       data['opening_hours'] = openingHours!.toJson();
//     }
//     data['category_id'] = categoryId;
//     data['role'] = role;
//     data['status'] = status;
//     data['delivery'] = delivery;
//     data['added_by'] = addedBy;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
class Category {
  int? id;
  String? name;
  String? imageUrl;

  Category({this.id, this.name, this.imageUrl});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    return data;
  }
}


// class Categories {
//   List<dynamic>? pizza;
//   List<dynamic>? burgers;
//   List<dynamic>? pasta;
//   List<dynamic>? sandwich;
//   List<dynamic>? salad;
//   List<dynamic>? soup;
//   List<dynamic>? fries;
//   List<dynamic>? steak;
//   List<dynamic>? sushi;
//   List<dynamic>? noodles;
//   List<dynamic>? shakes;
//   List<dynamic>? breadBake;
//   List<dynamic>? italian;
//   List<dynamic>? smoothies;
//   List<dynamic>? iceCream;
//   List<dynamic>? seafood;
//   List<dynamic>? dumplings;
//   List<dynamic>? grill;
//   List<dynamic>? bBQ;
//   List<dynamic>? veganSnacks;
//   List<dynamic>? energyDrinks;
//   List<dynamic>? sandwiches;
//   List<dynamic>? wraps;
//   List<dynamic>? soups;
//   List<dynamic>? salads;
//   List<dynamic>? coffee;
//   List<dynamic>? fastFood;
//   List<dynamic>? streetFood;
//   List<dynamic>? cake;
//   List<dynamic>? healthy;
//   List<dynamic>? masala;
//   List<dynamic>? snacks;
//   List<dynamic>? vegMasala;
//   List<dynamic>? punjabi;
//   List<dynamic>? beverage;
//
//   Categories(
//       {this.pizza,
//         this.burgers,
//         this.pasta,
//         this.sandwich,
//         this.salad,
//         this.soup,
//         this.fries,
//         this.steak,
//         this.sushi,
//         this.noodles,
//         this.shakes,
//         this.breadBake,
//         this.italian,
//         this.smoothies,
//         this.iceCream,
//         this.seafood,
//         this.dumplings,
//         this.grill,
//         this.bBQ,
//         this.veganSnacks,
//         this.energyDrinks,
//         this.sandwiches,
//         this.wraps,
//         this.soups,
//         this.salads,
//         this.coffee,
//         this.fastFood,
//         this.streetFood,
//         this.cake,
//         this.healthy,
//         this.masala,
//         this.snacks,
//         this.vegMasala,
//         this.punjabi,
//         this.beverage});
//
//   Categories.fromJson(Map<String, dynamic> json) {
//     if (json['Pizza'] != null) {
//       pizza = <Pizza>[];
//       json['Pizza'].forEach((v) {
//         pizza!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Burgers'] != null) {
//       burgers = <Pizza>[];
//       json['Burgers'].forEach((v) {
//         burgers!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Pasta'] != null) {
//       pasta = <Pizza>[];
//       json['Pasta'].forEach((v) {
//         pasta!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Sandwich'] != null) {
//       sandwich = <Pizza>[];
//       json['Sandwich'].forEach((v) {
//         sandwich!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Salad'] != null) {
//       salad = <Pizza>[];
//       json['Salad'].forEach((v) {
//         salad!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Soup'] != null) {
//       soup = <Pizza>[];
//       json['Soup'].forEach((v) {
//         soup!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Fries'] != null) {
//       fries = <Pizza>[];
//       json['Fries'].forEach((v) {
//         fries!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Steak'] != null) {
//       steak = <Pizza>[];
//       json['Steak'].forEach((v) {
//         steak!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Sushi'] != null) {
//       sushi = <Pizza>[];
//       json['Sushi'].forEach((v) {
//         sushi!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Noodles'] != null) {
//       noodles = <Pizza>[];
//       json['Noodles'].forEach((v) {
//         noodles!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Shakes'] != null) {
//       shakes = <Pizza>[];
//       json['Shakes'].forEach((v) {
//         shakes!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Bread & Bake'] != null) {
//       breadBake = <Pizza>[];
//       json['Bread & Bake'].forEach((v) {
//         breadBake!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Italian'] != null) {
//       italian = <Pizza>[];
//       json['Italian'].forEach((v) {
//         italian!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Smoothies'] != null) {
//       smoothies = <Pizza>[];
//       json['Smoothies'].forEach((v) {
//         smoothies!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Ice Cream'] != null) {
//       iceCream = <Pizza>[];
//       json['Ice Cream'].forEach((v) {
//         iceCream!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Seafood'] != null) {
//       seafood = <Pizza>[];
//       json['Seafood'].forEach((v) {
//         seafood!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Dumplings'] != null) {
//       dumplings = <Pizza>[];
//       json['Dumplings'].forEach((v) {
//         dumplings!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Grill'] != null) {
//       grill = <Pizza>[];
//       json['Grill'].forEach((v) {
//         grill!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['BBQ'] != null) {
//       bBQ = <Pizza>[];
//       json['BBQ'].forEach((v) {
//         bBQ!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Vegan Snacks'] != null) {
//       veganSnacks = <Pizza>[];
//       json['Vegan Snacks'].forEach((v) {
//         veganSnacks!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Energy Drinks'] != null) {
//       energyDrinks = <Pizza>[];
//       json['Energy Drinks'].forEach((v) {
//         energyDrinks!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Sandwiches'] != null) {
//       sandwiches = <Pizza>[];
//       json['Sandwiches'].forEach((v) {
//         sandwiches!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Wraps'] != null) {
//       wraps = <Pizza>[];
//       json['Wraps'].forEach((v) {
//         wraps!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Soups'] != null) {
//       soups = <Pizza>[];
//       json['Soups'].forEach((v) {
//         soups!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Salads'] != null) {
//       salads = <Pizza>[];
//       json['Salads'].forEach((v) {
//         salads!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Coffee'] != null) {
//       coffee = <Pizza>[];
//       json['Coffee'].forEach((v) {
//         coffee!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Fast Food'] != null) {
//       fastFood = <Pizza>[];
//       json['Fast Food'].forEach((v) {
//         fastFood!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Street Food'] != null) {
//       streetFood = <Pizza>[];
//       json['Street Food'].forEach((v) {
//         streetFood!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Cake'] != null) {
//       cake = <Pizza>[];
//       json['Cake'].forEach((v) {
//         cake!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Healthy'] != null) {
//       healthy = <Pizza>[];
//       json['Healthy'].forEach((v) {
//         healthy!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Masala'] != null) {
//       masala = <Pizza>[];
//       json['Masala'].forEach((v) {
//         masala!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Snacks'] != null) {
//       snacks = <Pizza>[];
//       json['Snacks'].forEach((v) {
//         snacks!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Veg Masala'] != null) {
//       vegMasala = <Pizza>[];
//       json['Veg Masala'].forEach((v) {
//         vegMasala!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Punjabi'] != null) {
//       punjabi = <Pizza>[];
//       json['Punjabi'].forEach((v) {
//         punjabi!.add(Pizza.fromJson(v));
//       });
//     }
//     if (json['Beverage'] != null) {
//       beverage = <Pizza>[];
//       json['Beverage'].forEach((v) {
//         beverage!.add(Pizza.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (pizza != null) {
//       data['Pizza'] = pizza!.map((v) => v.toJson()).toList();
//     }
//     if (burgers != null) {
//       data['Burgers'] = burgers!.map((v) => v.toJson()).toList();
//     }
//     if (pasta != null) {
//       data['Pasta'] = pasta!.map((v) => v.toJson()).toList();
//     }
//     if (sandwich != null) {
//       data['Sandwich'] = sandwich!.map((v) => v.toJson()).toList();
//     }
//     if (salad != null) {
//       data['Salad'] = salad!.map((v) => v.toJson()).toList();
//     }
//     if (soup != null) {
//       data['Soup'] = soup!.map((v) => v.toJson()).toList();
//     }
//     if (fries != null) {
//       data['Fries'] = fries!.map((v) => v.toJson()).toList();
//     }
//     if (steak != null) {
//       data['Steak'] = steak!.map((v) => v.toJson()).toList();
//     }
//     if (sushi != null) {
//       data['Sushi'] = sushi!.map((v) => v.toJson()).toList();
//     }
//     if (noodles != null) {
//       data['Noodles'] = noodles!.map((v) => v.toJson()).toList();
//     }
//     if (shakes != null) {
//       data['Shakes'] = shakes!.map((v) => v.toJson()).toList();
//     }
//     if (breadBake != null) {
//       data['Bread & Bake'] = breadBake!.map((v) => v.toJson()).toList();
//     }
//     if (italian != null) {
//       data['Italian'] = italian!.map((v) => v.toJson()).toList();
//     }
//     if (smoothies != null) {
//       data['Smoothies'] = smoothies!.map((v) => v.toJson()).toList();
//     }
//     if (iceCream != null) {
//       data['Ice Cream'] = iceCream!.map((v) => v.toJson()).toList();
//     }
//     if (seafood != null) {
//       data['Seafood'] = seafood!.map((v) => v.toJson()).toList();
//     }
//     if (dumplings != null) {
//       data['Dumplings'] = dumplings!.map((v) => v.toJson()).toList();
//     }
//     if (grill != null) {
//       data['Grill'] = grill!.map((v) => v.toJson()).toList();
//     }
//     if (bBQ != null) {
//       data['BBQ'] = bBQ!.map((v) => v.toJson()).toList();
//     }
//     if (veganSnacks != null) {
//       data['Vegan Snacks'] = veganSnacks!.map((v) => v.toJson()).toList();
//     }
//     if (energyDrinks != null) {
//       data['Energy Drinks'] =
//           energyDrinks!.map((v) => v.toJson()).toList();
//     }
//     if (sandwiches != null) {
//       data['Sandwiches'] = sandwiches!.map((v) => v.toJson()).toList();
//     }
//     if (wraps != null) {
//       data['Wraps'] = wraps!.map((v) => v.toJson()).toList();
//     }
//     if (soups != null) {
//       data['Soups'] = soups!.map((v) => v.toJson()).toList();
//     }
//     if (salads != null) {
//       data['Salads'] = salads!.map((v) => v.toJson()).toList();
//     }
//     if (coffee != null) {
//       data['Coffee'] = coffee!.map((v) => v.toJson()).toList();
//     }
//     if (fastFood != null) {
//       data['Fast Food'] = fastFood!.map((v) => v.toJson()).toList();
//     }
//     if (streetFood != null) {
//       data['Street Food'] = streetFood!.map((v) => v.toJson()).toList();
//     }
//     if (cake != null) {
//       data['Cake'] = cake!.map((v) => v.toJson()).toList();
//     }
//     if (healthy != null) {
//       data['Healthy'] = healthy!.map((v) => v.toJson()).toList();
//     }
//     if (masala != null) {
//       data['Masala'] = masala!.map((v) => v.toJson()).toList();
//     }
//     if (snacks != null) {
//       data['Snacks'] = snacks!.map((v) => v.toJson()).toList();
//     }
//     if (vegMasala != null) {
//       data['Veg Masala'] = vegMasala!.map((v) => v.toJson()).toList();
//     }
//     if (punjabi != null) {
//       data['Punjabi'] = punjabi!.map((v) => v.toJson()).toList();
//     }
//     if (beverage != null) {
//       data['Beverage'] = beverage!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }


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
  int? id;
  String? image;
  int? rating;
  String? salePrice;
  String? regularPrice;
  String? title;
  String? addimg;
  int? userId;
  int? categoryId;
  bool? isInWishlist;
  String? restoName;
  String? categoryName;
  int? productreviewCount;
  List<String>? urlAddimg;
  String? urlImage;
  Rx<bool> isLoading = false.obs;

  // List<Null>? addOnWithNames;
  // List<Null>? productreview;

  AllProducts(
      {this.id,
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
    id = json['id'];
    image = json['image'];
    rating = json['rating'];
    salePrice = json['sale_price'];
    regularPrice = json['regular_price'];
    title = json['title'];
    addimg = json['addimg'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    categoryName = json['category_name'];
    productreviewCount = json['productreview_count'];
    urlAddimg = json['url_addimg'].cast<String>();
    urlImage = json['url_image'];
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
