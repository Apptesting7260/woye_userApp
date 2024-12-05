class HomeModel {
  bool? status;
  Userdata? userdata;
  List<Category>? category;
  RestaurantsData? restaurants;
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
        ? null
        : RestaurantsData.fromJson(json["restaurants"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "userdata": userdata?.toJson(),
    "category": category == null
        ? []
        : List<dynamic>.from(category!.map((x) => x.toJson())),
    "restaurants": restaurants?.toJson(),
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
  String? rating;
  String? avgPrice;
  String? shopName;
  String? shopDes;
  String? currentStatus;
  String? shopImageUrl;
  bool? isInWishlist;

  Restaurant({
    this.id,
    this.rating,
    this.avgPrice,
    this.shopName,
    this.shopDes,
    this.currentStatus,
    this.shopImageUrl,
    this.isInWishlist,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    rating: json["rating"].toString(),
    avgPrice: json["avg_price"]?.toString() ?? "",
    shopName: json["shop_name"].toString(),
    shopDes: json["shop_des"].toString(),
    currentStatus: json["current_status"],
    shopImageUrl: json["shopimage"],
    isInWishlist: json["is_in_wishlist"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "avg_price": avgPrice,
    "shop_name": shopName,
    "shop_des": shopDes,
    "current_status": currentStatus,
    "shopimage": shopImageUrl,
    "is_in_wishlist": isInWishlist,
  };
}

class RestaurantsData {
  int? currentPage;
  List<Restaurant>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  // List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  RestaurantsData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    // this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory RestaurantsData.fromJson(Map<String, dynamic> json) =>
      RestaurantsData(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Restaurant>.from(
            json["data"]!.map((x) => Restaurant.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        // links: json["links"] == null
        //     ? []
        //     : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    // "links": links == null
    //     ? []
    //     : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Userdata {
  String? id;
  String? firstName;
  String? phone;
  String? fcmToken;
  String? image;

  Userdata({
    this.id,
    this.firstName,
    this.phone,
    this.fcmToken,
    this.image,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
    id: json["id"].toString(),
    firstName: json["first_name"].toString(),
    phone: json["phone"].toString(),
    fcmToken: json["fcm_token"].toString(),
    image: json["image_url"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "phone": phone,
    "fcm_token": fcmToken,
    "image_url": image,
  };
}

// class Link {
//   String? url;
//   String? label;
//   bool? active;
//
//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//     url: json["url"],
//     label: json["label"],
//     active: json["active"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "label": label,
//     "active": active,
//   };
// }


