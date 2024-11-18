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
  ParentCategory? parentCategory;
  UserId? userId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  Category({
    this.id,
    this.name,
    this.image,
    this.parentCategory,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        parentCategory: parentCategoryValues.map[json["parent_category"]]!,
        userId: userIdValues.map[json["user_id"]]!,
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "parent_category": parentCategoryValues.reverse[parentCategory],
        "user_id": userIdValues.reverse[userId],
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
      };
}

enum ParentCategory { RESTAURANT }

final parentCategoryValues =
    EnumValues({"restaurant": ParentCategory.RESTAURANT});

enum UserId { ALL }

final userIdValues = EnumValues({"all": UserId.ALL});

class Restaurant {
  String? id;
  String? name;
  String? email;
  dynamic otp;
  String? password;
  String? rating;
  String? avgPrice;
  String? currentStatus;
  String? phone;
  String? shopImage;
  String? shopName;
  String? shopEmail;
  String? shopAddress;
  String? shopDes;
  OpeningHours? openingHours;
  String? countryId;
  String? stateId;
  String? cityId;
  List<String>? categoryId;
  String? opensAt;
  String? closesAt;
  String? role;
  String? status;
  String? createdAt;
  String? updatedAt;

  Restaurant({
    this.id,
    this.name,
    this.email,
    this.otp,
    this.password,
    this.rating,
    this.avgPrice,
    this.currentStatus,
    this.phone,
    this.shopImage,
    this.shopName,
    this.shopEmail,
    this.shopAddress,
    this.shopDes,
    this.openingHours,
    this.countryId,
    this.stateId,
    this.cityId,
    this.categoryId,
    this.opensAt,
    this.closesAt,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"].toString(),
        name: json["name"].toString(),
        email: json["email"].toString(),
        otp: json["otp"].toString(),
        password: json["password"].toString(),
        rating: json["rating"].toString(),
        avgPrice: json["avg_price"].toString(),
        currentStatus: json["current_status"].toString(),
        phone: json["phone"].toString(),
        shopImage: json["shop_image"].toString(),
        shopName: json["shop_name"].toString(),
        shopEmail: json["shop_email"].toString(),
        shopAddress: json["shop_address"].toString(),
        shopDes: json["shop_des"].toString(),
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        countryId: json["country_id"].toString(),
        stateId: json["state_id"].toString(),
        cityId: json["city_id"].toString(),
        categoryId: json["category_id"] == null
            ? []
            : List<String>.from(json["category_id"]!.map((x) => x)),
        opensAt: json["opens_at"].toString(),
        closesAt: json["closes_at"].toString(),
        role: json["role"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "otp": otp,
        "password": password,
        "rating": rating,
        "avg_price": avgPrice,
        "current_status": currentStatus,
        "phone": phone,
        "shop_image": shopImage,
        "shop_name": shopName,
        "shop_email": shopEmail,
        "shop_address": shopAddress,
        "shop_des": shopDes,
        "opening_hours": openingHours?.toJson(),
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "category_id": categoryId == null
            ? []
            : List<dynamic>.from(categoryId!.map((x) => x)),
        "opens_at": opensAt,
        "closes_at": closesAt,
        "role": role,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class OpeningHours {
  Day? sunday;
  Day? monday;
  Day? tuesday;
  Day? wednesday;

  OpeningHours({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        sunday: json["Sunday"] == null ? null : Day.fromJson(json["Sunday"]),
        monday: json["Monday"] == null ? null : Day.fromJson(json["Monday"]),
        tuesday: json["Tuesday"] == null ? null : Day.fromJson(json["Tuesday"]),
        wednesday:
            json["Wednesday"] == null ? null : Day.fromJson(json["Wednesday"]),
      );

  Map<String, dynamic> toJson() => {
        "Sunday": sunday?.toJson(),
        "Monday": monday?.toJson(),
        "Tuesday": tuesday?.toJson(),
        "Wednesday": wednesday?.toJson(),
      };
}

class Day {
  String? status;
  String? open;
  String? close;

  Day({
    this.status,
    this.open,
    this.close,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        status: json["status"],
        open: json["open"],
        close: json["close"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "open": open,
        "close": close,
      };
}

class Userdata {
  String? id;
  String? firstName;
  dynamic lastName;
  dynamic email;
  dynamic plainPassword;
  String? proImg;
  String? imageUrl;
  String? dob;
  String? gender;
  String? phone;
  String? countryCode;
  dynamic terms;
  dynamic otp;
  String? fcmToken;
  dynamic status;
  String? step;
  dynamic uuid;
  String? type;
  dynamic userType;
  String? mobileVerified;
  String? emailVerified;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  Userdata({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.plainPassword,
    this.proImg,
    this.imageUrl,
    this.dob,
    this.gender,
    this.phone,
    this.countryCode,
    this.terms,
    this.otp,
    this.fcmToken,
    this.status,
    this.step,
    this.uuid,
    this.type,
    this.userType,
    this.mobileVerified,
    this.emailVerified,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        id: json["id"].toString(),
        firstName: json["first_name"].toString(),
        lastName: json["last_name"].toString(),
        email: json["email"].toString(),
        plainPassword: json["plain_password"].toString(),
        proImg: json["pro_img"].toString(),
        imageUrl: json["image_url"].toString(),
        dob: json["dob"].toString(),
        gender: json["gender"].toString(),
        phone: json["phone"].toString(),
        countryCode: json["country_code"].toString(),
        terms: json["terms"].toString(),
        otp: json["otp"].toString(),
        fcmToken: json["fcm_token"].toString(),
        status: json["status"].toString(),
        step: json["step"].toString(),
        uuid: json["uuid"].toString(),
        type: json["type"].toString(),
        userType: json["user_type"].toString(),
        mobileVerified: json["mobile_verified"].toString(),
        emailVerified: json["email_verified"].toString(),
        deletedAt: json["deleted_at"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "plain_password": plainPassword,
        "pro_img": proImg,
        "image_url": imageUrl,
        "dob": dob,
        "gender": gender,
        "phone": phone,
        "country_code": countryCode,
        "terms": terms,
        "otp": otp,
        "fcm_token": fcmToken,
        "status": status,
        "step": step,
        "uuid": uuid,
        "type": type,
        "user_type": userType,
        "mobile_verified": mobileVerified,
        "email_verified": emailVerified,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
