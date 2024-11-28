class HomeModel {
  bool? status;
  Userdata? userdata;
  List<Category>? category;
  List<Restaurant>? restaurants;
  String? message;

  HomeModel({
    this.status,
    this.userdata,
    this.category,
    this.restaurants,
    this.message,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        userdata: json["userdata"] == null
            ? null
            : Userdata.fromJson(json["userdata"]),
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "userdata": userdata?.toJson(),
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
        "message": message,
      };
}

class Category {
  int? id;
  String? name;
  String? image;
  String? imageUrl;

  Category({
    this.id,
    this.name,
    this.image,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "image_url": imageUrl,
      };
}

class Restaurant {
  int? id;
  String? name;
  String? email;
  String? rating;
  String? avgPrice;
  String? shopName;
  String? shopImageUrl;
  String? shopAddress;
  String? opensAt;
  String? closesAt;

  Restaurant({
    this.id,
    this.name,
    this.email,
    this.rating,
    this.avgPrice,
    this.shopName,
    this.shopImageUrl,
    this.shopAddress,
    this.opensAt,
    this.closesAt,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"].toString(),
        email: json["email"].toString(),
        rating: json["rating"].toString(),
        avgPrice: json["avg_price"].toString(),
        shopName: json["shop_name"].toString(),
        shopImageUrl: json["shopimage"],
        shopAddress: json["shop_address"].toString(),
        opensAt: json["opens_at"].toString(),
        closesAt: json["closes_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "rating": rating,
        "avg_price": avgPrice,
        "shop_name": shopName,
        "shopimage": shopImageUrl,
        "shop_address": shopAddress,
        "opens_at": opensAt,
        "closes_at": closesAt,
      };
}

class Userdata {
  String? id;
  String? firstName;
  String? phone;
  String? fcmToken;

  Userdata({
    this.id,
    this.firstName,
    this.phone,
    this.fcmToken,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        id: json["id"].toString(),
        firstName: json["first_name"].toString(),
        phone: json["phone"].toString(),
        fcmToken: json["fcm_token"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "phone": phone,
        "fcm_token": fcmToken,
      };
}

