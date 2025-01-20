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
  PharmaShopsData? pharmaShops;
  List<Banner>? banners;
  String? message;

  PharamacyHomeModal({
    this.status,
    this.category,
    this.pharmaShops,
    this.banners,
    this.message,
  });

  factory PharamacyHomeModal.fromJson(Map<String, dynamic> json) =>
      PharamacyHomeModal(
        status: json["status"],
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
        pharmaShops: json["pharma_shops"] == null
            ? null
            : PharmaShopsData.fromJson(json["pharma_shops"]),
        banners: json["banner"] == null
            ? []
            : List<Banner>.from(json["banner"]!.map((x) => Banner.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        // "userdata": userdata?.toJson(),
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
        "pharma_shops": pharmaShops?.toJson(),
        "banner": banners == null
            ? []
            : List<dynamic>.from(banners!.map((x) => x.toJson())),
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_category'] = this.parentCategory;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
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
      this.avgPrice});

  PharmaShops.fromJson(Map<String, dynamic> json) {
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
    rating = json['rating'];
    avgPrice = json['avg_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['shopimage'] = this.shopimage;
    data['shop_name'] = this.shopName;
    data['shop_address'] = this.shopAddress;
    data['opens_at'] = this.opensAt;
    data['closes_at'] = this.closesAt;
    data['rating'] = this.rating;
    data['avg_price'] = this.avgPrice;
    return data;
  }
}
