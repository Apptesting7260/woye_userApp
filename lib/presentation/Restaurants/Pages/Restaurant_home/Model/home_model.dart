/*
class HomeModel {
  bool? status;
  List<Category>? category;

  // AllRestaurant? freedelResto;
  // AllRestaurant? nearbyResto;
  // AllRestaurant? popularResto;
  // AllRestaurant? restaurants;
  List<AllRestaurant>? freedelResto;
  List<AllRestaurant>? nearbyResto;
  List<AllRestaurant>? popularResto;
  List<AllRestaurant>? restaurants;
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
            ? []
            : List<AllRestaurant>.from(
                json["freedel_resto"]!.map((x) => AllRestaurant.fromJson(x))),

        nearbyResto: json["nearby_resto"] == null
            ? []
            : List<AllRestaurant>.from(
                json["nearby_resto"]!.map((x) => AllRestaurant.fromJson(x))),

        restaurants: json["restaurants"] == null
            ? []
            : List<AllRestaurant>.from(
                json["restaurants"]!.map((x) => AllRestaurant.fromJson(x))),

        popularResto: json["popular_resto"] == null
            ? []
            : List<AllRestaurant>.from(
                json["popular_resto"]!.map((x) => AllRestaurant.fromJson(x))),

        //     freedelResto: json["freedel_resto"] == null
        //         ? null
        //         :AllRestaurant.fromJson(json['freedel_resto']),
        //   nearbyResto: json["nearby_resto"] == null
        //         ? null
        //         : AllRestaurant.fromJson(json["nearby_resto"]),
        // restaurants: json["restaurants"] == null
        //         ? null
        //         : AllRestaurant.fromJson(json["restaurants"]),
        // popularResto : json["popular_resto"] == null
        //         ? null
        //         : AllRestaurant.fromJson(json["popular_resto"]),

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
        "freedel_resto": freedelResto == null
            ? []
            : List<AllRestaurant>.from(freedelResto!.map((x) => x.toJson())),

        "nearby_resto": nearbyResto == null
            ? []
            : List<AllRestaurant>.from(nearbyResto!.map((x) => x.toJson())),

        "popular_resto": popularResto == null
            ? []
            : List<AllRestaurant>.from(popularResto!.map((x) => x.toJson())),

        "restaurants": restaurants == null
            ? []
            : List<AllRestaurant>.from(restaurants!.map((x) => x.toJson())),

        // "freedel_resto": freedelResto?.toJson(),
        // "nearby_resto": nearbyResto?.toJson(),
        // "popular_resto": popularResto?.toJson(),
        // "restaurants": restaurants?.toJson(),
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

// class RestaurantsData {
//   int? currentPage;
//   List<Restaurant>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//
//   // List<Link>? links;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   String? prevPageUrl;
//   int? to;
//   int? total;
//
//   RestaurantsData({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     // this.links,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });
//
//   factory RestaurantsData.fromJson(Map<String, dynamic> json) =>
//       RestaurantsData(
//         currentPage: json["current_page"],
//         data: json["data"] == null
//             ? []
//             : List<Restaurant>.from(
//                 json["data"]!.map((x) => Restaurant.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         // links: json["links"] == null
//         //     ? []
//         //     : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         // "links": links == null
//         //     ? []
//         //     : List<dynamic>.from(links!.map((x) => x.toJson())),
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//       };
// }

class AllRestaurant {
  int? id;
  String? rating;
  String? avgPrice;
  String? shopName;
  String? shopDes;
  int? status;
  String? shopimage;
  List<String>? categoriesName;
  bool? isInWishlist;

  AllRestaurant(
      {this.id,
      this.rating,
      this.avgPrice,
      this.shopName,
      this.shopDes,
      this.status,
      this.shopimage,
      this.categoriesName,
      this.isInWishlist});

  AllRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    avgPrice = json['avg_price'];
    shopName = json['shop_name'];
    shopDes = json['shop_des'];
    status = json['status'];
    shopimage = json['shopimage'];
    isInWishlist = json['is_in_wishlist'];
    if (json['category_names'] != null) {
      categoriesName = json['category_names'].cast<String>();
    } else {
      categoriesName = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rating'] = rating;
    data['avg_price'] = avgPrice;
    data['shop_name'] = shopName;
    data['shop_des'] = shopDes;
    data['status'] = status;
    data['shopimage'] = shopimage;
    data['is_in_wishlist'] = isInWishlist;
    data['category_names'] = categoriesName;
    return data;
  }
}
*/

class HomeModel {
  bool? status;
  List<Category>? category;
  List<AllRestaurant>? freedelResto;
  List<AllRestaurant>? nearbyResto;
  List<AllRestaurant>? popularResto;
  List<AllRestaurant>? restaurants;
  List<Banner>? banners;
  String? address;
  int? totalRestoProducts;
  String? message;

  HomeModel({
    this.status,
    this.category,
    this.freedelResto,
    this.nearbyResto,
    this.popularResto,
    this.restaurants,
    this.banners,
    this.address,
    this.totalRestoProducts,
    this.message,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    status: json["status"],
    category: json["category"] == null
        ? []
        : List<Category>.from(
        json["category"]!.map((x) => Category.fromJson(x))),
    freedelResto: json["freedel_resto"] == null
        ? []
        : List<AllRestaurant>.from(
        json["freedel_resto"]!.map((x) => AllRestaurant.fromJson(x))),
    nearbyResto: json["nearby_resto"] == null
        ? []
        : List<AllRestaurant>.from(
        json["nearby_resto"]!.map((x) => AllRestaurant.fromJson(x))),
    popularResto: json["popular_resto"] == null
        ? []
        : List<AllRestaurant>.from(
        json["popular_resto"]!.map((x) => AllRestaurant.fromJson(x))),
    restaurants: json["restaurants"] == null
        ? []
        : List<AllRestaurant>.from(
        json["restaurants"]!.map((x) => AllRestaurant.fromJson(x))),
    banners: json["banners"] == null
        ? []
        : List<Banner>.from(
        json["banners"]!.map((x) => Banner.fromJson(x))),
    address: json["address"],
    totalRestoProducts: json["total_resto_products"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "category": category == null
        ? []
        : List<dynamic>.from(category!.map((x) => x.toJson())),
    "freedel_resto": freedelResto == null
        ? []
        : List<dynamic>.from(freedelResto!.map((x) => x.toJson())),
    "nearby_resto": nearbyResto == null
        ? []
        : List<dynamic>.from(nearbyResto!.map((x) => x.toJson())),
    "popular_resto": popularResto == null
        ? []
        : List<dynamic>.from(popularResto!.map((x) => x.toJson())),
    "restaurants": restaurants == null
        ? []
        : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
    "banners": banners == null
        ? []
        : List<dynamic>.from(banners!.map((x) => x.toJson())),
    "address": address,
    "total_resto_products": totalRestoProducts,
    "message": message,
  };
}

class Category {
  int? id;
  String? name;
  String? parentCategory;
  String? image;
  String? imageUrl;
  int? productsCount;

  Category({
    this.id,
    this.name,
    this.parentCategory,
    this.image,
    this.imageUrl,
    this.productsCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    parentCategory: json["parent_category"],
    image: json["image"],
    imageUrl: json["image_url"],
    productsCount: json["products_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent_category": parentCategory,
    "image": image,
    "image_url": imageUrl,
    "products_count": productsCount,
  };
}

class Banner {
  int? id;
  String? image;
  String? parentCategory;
  String? imageUrl;

  Banner({
    this.id,
    this.image,
    this.parentCategory,
    this.imageUrl,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    image: json["image"],
    parentCategory: json["parent_category"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "parent_category": parentCategory,
    "image_url": imageUrl,
  };
}

class AllRestaurant {
  int? id;
  String? rating;
  String? shopName;
  String? description;
  String? status;
  String? logo;
  String? coverPhoto;
  List<CategoryIds>? categoryIds;
  bool? isInWishlist;
  List<String>? categoryNames;
  String? logoUrl;
  String? coverPhotoUrl;
  String? roleName;
  String? role;
  String? avgPrice;
  String? shopDes;
  String? shopimage;

  AllRestaurant({
    this.id,
    this.rating,
    this.shopName,
    this.description,
    this.status,
    this.logo,
    this.coverPhoto,
    this.categoryIds,
    this.isInWishlist,
    this.categoryNames,
    this.logoUrl,
    this.coverPhotoUrl,
    this.roleName,
    this.role,
    this.avgPrice,
    this.shopDes,
    this.shopimage,
  });

  factory AllRestaurant.fromJson(Map<String, dynamic> json) => AllRestaurant(
    id: json["id"],
    rating: json["rating"]?.toString(),
    shopName: json["shop_name"],
    description: json["description"],
    status: json["status"]?.toString(),
    logo: json["logo"],
    coverPhoto: json["cover_photo"],
    categoryIds: json["category_ids"] == null
        ? []
        : List<CategoryIds>.from(
        json["category_ids"]!.map((x) => CategoryIds.fromJson(x))),
    isInWishlist: json["is_in_wishlist"],
    categoryNames: json["category_names"] == null
        ? []
        : List<String>.from(json["category_names"]!.map((x) => x)),
    logoUrl: json["logo_url"],
    coverPhotoUrl: json["cover_photo_url"],
    roleName: json["role_name"],
    role: json["role"],
    avgPrice: json["avg_price"]?.toString() ?? "",
    shopDes: json["shop_des"] ?? json["description"],
    shopimage: json["shopimage"] ?? json["logo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "shop_name": shopName,
    "description": description,
    "status": status,
    "logo": logo,
    "cover_photo": coverPhoto,
    "category_ids": categoryIds == null
        ? []
        : List<dynamic>.from(categoryIds!.map((x) => x.toJson())),
    "is_in_wishlist": isInWishlist,
    "category_names": categoryNames == null
        ? []
        : List<dynamic>.from(categoryNames!.map((x) => x)),
    "logo_url": logoUrl,
    "cover_photo_url": coverPhotoUrl,
    "role_name": roleName,
    "role": role,
    "avg_price": avgPrice,
    "shop_des": shopDes,
    "shopimage": shopimage,
  };
}

class CategoryIds {
  String? id;
  String? name;
  String? status;
  String? added;

  CategoryIds({
    this.id,
    this.name,
    this.status,
    this.added,
  });

  factory CategoryIds.fromJson(Map<String, dynamic> json) => CategoryIds(
    id: json["id"]?.toString(),
    name: json["name"]?.toString(),
    status: json["status"]?.toString(),
    added: json["added"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "added": added,
  };
}