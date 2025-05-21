// class PharamacyHomeModal {
//   bool? status;
//   List<Category>? category;
//   List<PharmaShopsData>? pharmaShops;
//   List<Banner>? banner;
//   String? message;
//
//   PharamacyHomeModal(
//       {this.status,
//       this.category,
//       this.pharmaShops,
//       this.banner,
//       this.message});
//
//   PharamacyHomeModal.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['category'] != null) {
//       category = <Category>[];
//       json['category'].forEach((v) {
//         category!.add(new Category.fromJson(v));
//       });
//     }
//
//     if (json['pharma_shops'] != null) {
//       pharmaShops = <PharmaShopsData>[];
//       json['pharma_shops'].forEach((v) {
//         pharmaShops!.add(new PharmaShopsData.fromJson(v));
//       });
//     }
//
//     if (json['banner'] != null) {
//       banner = <Banner>[];
//       json['banner'].forEach((v) {
//         banner!.add(Banner.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = this.status;
//     if (this.category != null) {
//       data['category'] = this.category!.map((v) => v.toJson()).toList();
//     }
//
//     if (this.pharmaShops != null) {
//       data['pharma_shops'] = this.pharmaShops!.map((v) => v.toJson()).toList();
//     }
//
//     if (this.banner != null) {
//       data['banner'] = this.banner!.map((v) => v.toJson()).toList();
//     }
//
//     data['message'] = this.message;
//     return data;
//   }
// }

class PharamacyHomeModal {
  bool? status;
  List<Category>? category;
  // PharmaShopsData? pharmaShops;
  FreedelPharma? freedelPharma;
  NearbyPharma? nearbyPharma;
  NearbyPharma? popularPharma;
  NearbyPharma? pharmaShops;
  List<Banner>? banners;
  String? message;
  // Map<String, NearbyPharma>? pharmaCategories;

  PharamacyHomeModal({
    this.status,
    this.category,
    this.pharmaShops,
    this.freedelPharma,
    this.nearbyPharma,
    this.popularPharma,
    this.banners,
    this.message,
    // this.pharmaCategories,
  });

  factory PharamacyHomeModal.fromJson(Map<String, dynamic> json) {
    // final Map<String, NearbyPharma> extractedPharmaCategories = {};

    // json.forEach((key, value) {
    //   if (key.endsWith("_pharma") && value is Map<String, dynamic>) {
    //     extractedPharmaCategories[key] = NearbyPharma.fromJson(value);
    //   }
    // });


    return PharamacyHomeModal(
        status: json["status"],
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
        pharmaShops: json["pharma_shops"] == null
            ? null
            : NearbyPharma.fromJson(json["pharma_shops"]),
        freedelPharma: json["freedel_pharma"] == null
            ? null
            : FreedelPharma.fromJson(json["freedel_pharma"]),
        nearbyPharma: json["nearby_pharma"] == null
            ? null
            : NearbyPharma.fromJson(json["nearby_pharma"]),
        popularPharma: json["popular_pharma"] == null
            ? null
            : NearbyPharma.fromJson(json["popular_pharma"]),
        banners: json["banner"] == null
            ? []
            : List<Banner>.from(json["banner"]!.map((x) => Banner.fromJson(x))),
        message: json["message"],
      // pharmaCategories: extractedPharmaCategories,

      );
  }

  Map<String, dynamic> toJson() {
    // final pharmaMap = pharmaCategories?.map((key, value) => MapEntry(key, value.toJson()));

    return {
        "status": status,
        // "userdata": userdata?.toJson(),
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
        "pharma_shops": pharmaShops?.toJson(),
        "freedel_pharma": freedelPharma?.toJson(),
        "nearby_pharma": nearbyPharma?.toJson(),
        "popular_pharma": popularPharma?.toJson(),
        "banner": banners == null
            ? []
            : List<dynamic>.from(banners!.map((x) => x.toJson())),
        "message": message,
      // ...?pharmaMap, // Spreads all dynamic _pharma keys
    };
  }
}

class Category {
  int? id;
  String? name;
  String? parentCategory;
  String? image;
  String? imageUrl;

  Category(
      {this.id, this.name, this.parentCategory, this.image, this.imageUrl});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentCategory = json['parent_category'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent_category'] = parentCategory;
    data['image'] = image;
    data['image_url'] = imageUrl;
    return data;
  }
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

class PharmaShopsData {
  int? currentPage;
  List<PharmaShops>? data;
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

  PharmaShopsData({
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

  factory PharmaShopsData.fromJson(Map<String, dynamic> json) =>
      PharmaShopsData(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<PharmaShops>.from(
                json["data"]!.map((x) => PharmaShops.fromJson(x))),
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

class PharmaShops {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? dob;
  String? shopimage;
  String? shopName;
  String? shopAddress;
  String? opensAt;
  String? closesAt;
  String? rating;
  String? avgRating;
  String? avgPrice;

  PharmaShops(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.gender,
      this.dob,
      this.shopimage,
      this.shopName,
      this.shopAddress,
      this.opensAt,
      this.closesAt,
      this.rating,
      this.avgRating,
      this.avgPrice});

  PharmaShops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    gender = json['gender']?.toString();
    dob = json['dob']?.toString();
    shopimage = json['shopimage']?.toString();
    shopName = json['shop_name']?.toString();
    shopAddress = json['shop_address']?.toString();
    opensAt = json['opens_at']?.toString();
    closesAt = json['closes_at']?.toString();
    rating = json['rating']?.toString();
    avgRating = json['avg_rating']?.toString();
    avgPrice = json['avg_price']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['dob'] = dob;
    data['shopimage'] = shopimage;
    data['shop_name'] = shopName;
    data['shop_address'] = shopAddress;
    data['opens_at'] = opensAt;
    data['closes_at'] = closesAt;
    data['rating'] = rating;
    data['avg_rating'] = avgRating;
    data['avg_price'] = avgPrice;
    return data;
  }
}
class FreedelPharma {
  String? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  String? from;
  String? lastPage;
  String? lastPageUrl;
  // List<Links>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  String? to;
  String? total;

  FreedelPharma(
      {this.currentPage,
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
        this.total});

  FreedelPharma.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']?.toString();
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url']?.toString();
    from = json['from']?.toString();
    lastPage = json['last_page']?.toString();
    lastPageUrl = json['last_page_url']?.toString();
    // if (json['links'] != null) {
    //   links = <Links>[];
    //   json['links'].forEach((v) {
    //     links!.add(new Links.fromJson(v));
    //   });
    // }
    nextPageUrl = json['next_page_url']?.toString();
    path = json['path']?.toString();
    perPage = json['per_page']?.toString();
    prevPageUrl = json['prev_page_url']?.toString();
    to = json['to']?.toString();
    total = json['total']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    // if (this.links != null) {
    //   data['links'] = this.links!.map((v) => v.toJson()).toList();
    // }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? dob;
  String? rating;
  String? shopimage;
  String? shopName;
  String? avgPrice;
  String? shopAddress;
  String? opensAt;
  String? closesAt;
  String? avgRating;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.gender,
        this.dob,
        this.rating,
        this.shopimage,
        this.shopName,
        this.avgPrice,
        this.shopAddress,
        this.opensAt,
        this.closesAt,
        this.avgRating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    gender = json['gender']?.toString();
    dob = json['dob']?.toString();
    rating = json['rating']?.toString();
    shopimage = json['shopimage']?.toString();
    shopName = json['shop_name']?.toString();
    avgPrice = json['avg_price']?.toString();
    shopAddress = json['shop_address']?.toString();
    opensAt = json['opens_at']?.toString();
    closesAt = json['closes_at']?.toString();
    avgRating = json['avg_rating']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['dob'] = dob;
    data['rating'] = rating;
    data['shopimage'] = shopimage;
    data['shop_name'] = shopName;
    data['avg_price'] = avgPrice;
    data['shop_address'] = shopAddress;
    data['opens_at'] = opensAt;
    data['closes_at'] = closesAt;
    data['avg_rating'] = avgRating;
    return data;
  }
}
class NearbyPharma {
  String? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  String? from;
  String? lastPage;
  String? lastPageUrl;
  // List<Links>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  String? to;
  String? total;

  NearbyPharma(
      {this.currentPage,
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
        this.total});

  NearbyPharma.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']?.toString();
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url']?.toString();
    from = json['from']?.toString();
    lastPage = json['last_page']?.toString();
    lastPageUrl = json['last_page_url']?.toString();
    // if (json['links'] != null) {
    //   links = <Links>[];
    //   json['links'].forEach((v) {
    //     links!.add(new Links.fromJson(v));
    //   });
    // }
    nextPageUrl = json['next_page_url']?.toString();
    path = json['path']?.toString();
    perPage = json['per_page']?.toString();
    prevPageUrl = json['prev_page_url']?.toString();
    to = json['to']?.toString();
    total = json['total']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    // if (this.links != null) {
    //   data['links'] = this.links!.map((v) => v.toJson()).toList();
    // }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}