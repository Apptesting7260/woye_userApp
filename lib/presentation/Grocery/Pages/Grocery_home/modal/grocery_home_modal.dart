class GroceryHomeModal {
  bool? status;
  List<Category>? category;
  // GroceryShopsData? groceryShops;
  // FreedelGrocery? freedelGrocery;
  // GroceryShopsData? nearbyGrocery;
  // GroceryShopsData? popularGrocery;
  List<AllGroceryShops>? groceryShops;
  List<AllGroceryShops>? freedelGrocery;
  List<AllGroceryShops>? nearbyGrocery;
  List<AllGroceryShops>? popularGrocery;
  List<Banner>? banners;
  String? message;

  GroceryHomeModal({
    this.status,
    this.category,
    this.groceryShops,
    this.freedelGrocery,
    this.nearbyGrocery,
    this.popularGrocery,
    this.banners,
    this.message,
  });

  factory GroceryHomeModal.fromJson(Map<String, dynamic> json) =>
      GroceryHomeModal(
        status: json["status"],
        category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
        groceryShops: json["grocery_shops"] == null ? [] : List<AllGroceryShops>.from(json["grocery_shops"]!.map((x) => AllGroceryShops.fromJson(x))),
        freedelGrocery: json["freedel_grocery"] == null ? [] : List<AllGroceryShops>.from(json["freedel_grocery"]!.map((x) => AllGroceryShops.fromJson(x))),
        nearbyGrocery: json["nearby_grocery"] == null ? [] : List<AllGroceryShops>.from(json["nearby_grocery"]!.map((x) => AllGroceryShops.fromJson(x))),
        popularGrocery: json["popular_grocery"] == null ? [] : List<AllGroceryShops>.from(json["popular_grocery"]!.map((x) => AllGroceryShops.fromJson(x))),

        // groceryShops: json["grocery_shops"] == null
        //     ? null
        //     : GroceryShopsData.fromJson(json["grocery_shops"]),
        //
        // freedelGrocery: json["freedel_grocery"] == null
        //     ? null
        //     : FreedelGrocery.fromJson(json["freedel_grocery"]),
        //
        // nearbyGrocery: json["nearby_grocery"] == null
        //     ? null
        //     : GroceryShopsData.fromJson(json["nearby_grocery"]),
        //
        // popularGrocery: json["popular_grocery"] == null
        //     ? null
        //     : GroceryShopsData.fromJson(json["popular_grocery"]),

        banners: json["banner"] == null
            ? []
            : List<Banner>.from(json["banner"]!.map((x) => Banner.fromJson(x))),

        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        // "userdata": userdata?.toJson(),
        "category": category == null ? [] : List<AllGroceryShops>.from(category!.map((x) => x.toJson())),
        "grocery_shops": groceryShops == null ? [] : List<AllGroceryShops>.from(groceryShops!.map((x) => x.toJson())),
        "freedel_grocery": freedelGrocery == null ? [] : List<AllGroceryShops>.from(freedelGrocery!.map((x) => x.toJson())),
        "nearby_grocery": nearbyGrocery == null ? [] : List<AllGroceryShops>.from(nearbyGrocery!.map((x) => x.toJson())),
        "popular_grocery": popularGrocery == null ? [] : List<AllGroceryShops>.from(popularGrocery!.map((x) => x.toJson())),
        // "grocery_shops": groceryShops?.toJson(),
        "banner": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x.toJson())),
        "message": message,
      };
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

class GroceryShopsData {
  int? currentPage;
  List<GroceryShops>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;

  // List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  var to;
  var total;

  GroceryShopsData({
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

  factory GroceryShopsData.fromJson(Map<String, dynamic> json) =>
      GroceryShopsData(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<GroceryShops>.from(
                json["data"]!.map((x) => GroceryShops.fromJson(x))),
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

class GroceryShops {
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
  String? avgRating;
  var rating;
  var avgPrice;

  GroceryShops(
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
      this.avgRating,
      this.rating,
      this.avgPrice});

  GroceryShops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    dob = json['dob'];
    shopimage = json['shopimage'];
    shopName = json['shop_name'];
    shopAddress = json['shop_address'];
    opensAt = json['opens_at'];
    closesAt = json['closes_at'];
    avgRating = json['avg_rating']?.toString();
    rating = json['rating'];
    avgPrice = json['avg_price'];
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
    data['avg_rating'] = avgRating;
    data['rating'] = rating;
    data['avg_price'] = avgPrice;
    return data;
  }
}
class FreedelGrocery {
  String? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  String? from;
  String? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  String? to;
  String? total;

  FreedelGrocery(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  FreedelGrocery.fromJson(Map<String, dynamic> json) {
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
  String? shopimage;
  String? shopName;
  String? rating;
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
        this.shopimage,
        this.shopName,
        this.rating,
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
    shopimage = json['shopimage']?.toString();
    shopName = json['shop_name']?.toString();
    rating = json['rating']?.toString();
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
    data['shopimage'] = shopimage;
    data['shop_name'] = shopName;
    data['rating'] = rating;
    data['avg_price'] = avgPrice;
    data['shop_address'] = shopAddress;
    data['opens_at'] = opensAt;
    data['closes_at'] = closesAt;
    data['avg_rating'] = avgRating;
    return data;
  }
}

//---------------------------------------------------
class AllGroceryShops {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? dob;
  String? shopimage;
  String? shopName;
  String? rating;
  String? avgPrice;
  String? shopAddress;
  String? opensAt;
  String? closesAt;
  String? latitude;
  String? longitude;
  String? avgRating;

  AllGroceryShops({this.id,
        this.name,
        this.email,
        this.phone,
        this.gender,
        this.dob,
        this.shopimage,
        this.shopName,
        this.rating,
        this.avgPrice,
        this.shopAddress,
        this.opensAt,
        this.closesAt,
        this.latitude,
        this.longitude,
        this.avgRating});

  AllGroceryShops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    gender = json['gender']?.toString();
    dob = json['dob']?.toString();
    shopimage = json['shopimage']?.toString();
    shopName = json['shop_name']?.toString();
    rating = json['rating']?.toString();
    avgPrice = json['avg_price']?.toString();
    shopAddress = json['shop_address']?.toString();
    opensAt = json['opens_at']?.toString();
    closesAt = json['closes_at']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
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
    data['shopimage'] = shopimage;
    data['shop_name'] = shopName;
    data['rating'] = rating;
    data['avg_price'] = avgPrice;
    data['shop_address'] = shopAddress;
    data['opens_at'] = opensAt;
    data['closes_at'] = closesAt;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['avg_rating'] = avgRating;
    return data;
  }
}

