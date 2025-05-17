class HomeModel {
  bool? status;
  List<Category>? category;
  RestaurantsData? freedelResto;
  RestaurantsData? nearbyResto;
  RestaurantsData? popularResto;
  RestaurantsData? restaurants;
  List<Banner>? banners;
  String? message;

  HomeModel({
    this.status,
    this.category,
    this.freedelResto,
    this.nearbyResto,
    this.popularResto,
    this.restaurants,
    this.banners,
    this.message,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
        freedelResto: json["freedel_resto"] == null
            ? null
            :RestaurantsData.fromJson(json['freedel_resto']),
      nearbyResto: json["nearby_resto"] == null
            ? null
            : RestaurantsData.fromJson(json["nearby_resto"]),
    restaurants: json["restaurants"] == null
            ? null
            : RestaurantsData.fromJson(json["restaurants"]),
    popularResto : json["popular_resto"] == null
            ? null
            : RestaurantsData.fromJson(json["popular_resto"]),
        banners: json["banners"] == null
            ? []
            : List<Banner>.from(
                json["banners"]!.map((x) => Banner.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        // "userdata": userdata?.toJson(),
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
        "freedel_resto": freedelResto?.toJson(),
        "nearby_resto": nearbyResto?.toJson(),
        "popular_resto": popularResto?.toJson(),
        "restaurants": restaurants?.toJson(),
        "banners": banners == null
            ? []
            : List<dynamic>.from(banners!.map((x) => x.toJson())),
        "message": message,
      };
}

class Banner {
  int? id;
  String? image;
  String? parentCategory;
  int? categoryId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Banner({
    this.id,
    this.image,
    this.parentCategory,
    this.categoryId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["id"],
        image: json["image"],
        parentCategory: json["parent_category"],
        categoryId: json["category_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "parent_category": parentCategory,
        "category_id": categoryId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "image_url": imageUrl,
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

