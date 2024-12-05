class SpecificRestaurantModal {
  bool? status;
  Restaurant? restaurant;
  String? message;

  SpecificRestaurantModal({this.status, this.restaurant, this.message});

  SpecificRestaurantModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    restaurant = json['restaurant'] != null
        ? Restaurant.fromJson(json['restaurant'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Restaurant {
  int? id;
  String? name;
  String? email;
  String? image;
  String? dob;
  String? gender;
  Null? otp;
  String? rating;
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
  OpeningHours? openingHours;
  int? countryId;
  int? stateId;
  int? cityId;
  List<String>? categoryId;  // Nullable List of Strings
  String? opensAt;
  String? closesAt;
  String? role;
  int? status;
  String? createdAt;
  String? updatedAt;

  Restaurant({
    this.id,
    this.name,
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
    this.categoryId,
    this.opensAt,
    this.closesAt,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    openingHours = json['opening_hours'] != null
        ? new OpeningHours.fromJson(json['opening_hours'])
        : null;
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    categoryId = json['category_id'] != null ? List<String>.from(json['category_id']) : null;  // Handle nullable List
    opensAt = json['opens_at'];
    closesAt = json['closes_at'];
    role = json['role'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['otp'] = this.otp;
    data['rating'] = this.rating;
    data['avg_price'] = this.avgPrice;
    data['current_status'] = this.currentStatus;
    data['phone_code'] = this.phoneCode;
    data['phone'] = this.phone;
    data['image_url'] = this.imageUrl;
    data['shop_name'] = this.shopName;
    data['shop_email'] = this.shopEmail;
    data['shopimage'] = this.shopimage;
    data['shop_address'] = this.shopAddress;
    data['shop_des'] = this.shopDes;
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours!.toJson();
    }
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['category_id'] = this.categoryId;
    data['opens_at'] = this.opensAt;
    data['closes_at'] = this.closesAt;
    data['role'] = this.role;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OpeningHours {
  Sunday? sunday;
  Sunday? monday;
  Sunday? tuesday;
  Sunday? wednesday;
  Sunday? thursday;
  Sunday? friday;
  Saturday? saturday;

  OpeningHours({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  OpeningHours.fromJson(Map<String, dynamic> json) {
    sunday = json['Sunday'] != null ? Sunday.fromJson(json['Sunday']) : null;
    monday = json['Monday'] != null ? Sunday.fromJson(json['Monday']) : null;
    tuesday = json['Tuesday'] != null ? Sunday.fromJson(json['Tuesday']) : null;
    wednesday = json['Wednesday'] != null ? Sunday.fromJson(json['Wednesday']) : null;
    thursday = json['Thursday'] != null ? Sunday.fromJson(json['Thursday']) : null;
    friday = json['Friday'] != null ? Sunday.fromJson(json['Friday']) : null;
    saturday = json['Saturday'] != null ? Saturday.fromJson(json['Saturday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sunday != null) data['Sunday'] = this.sunday!.toJson();
    if (this.monday != null) data['Monday'] = this.monday!.toJson();
    if (this.tuesday != null) data['Tuesday'] = this.tuesday!.toJson();
    if (this.wednesday != null) data['Wednesday'] = this.wednesday!.toJson();
    if (this.thursday != null) data['Thursday'] = this.thursday!.toJson();
    if (this.friday != null) data['Friday'] = this.friday!.toJson();
    if (this.saturday != null) data['Saturday'] = this.saturday!.toJson();
    return data;
  }
}

class Sunday {
  String? open;
  String? close;

  Sunday({this.open, this.close});

  Sunday.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['close'] = this.close;
    return data;
  }
}

class Saturday {
  String? open;
  String? close;

  Saturday({this.open, this.close});

  Saturday.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['close'] = this.close;
    return data;
  }
}
// class specific_restaurant_modal {
//   bool? status;
//   Restaurant? restaurant;
//   String? message;
//
//   specific_restaurant_modal({this.status, this.restaurant, this.message});
//
//   specific_restaurant_modal.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     restaurant = json['restaurant'] != null
//         ? Restaurant.fromJson(json['restaurant'])
//         : null;
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.restaurant != null) {
//       data['restaurant'] = this.restaurant!.toJson();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class Restaurant {
//   int? id;
//   String? name;
//   String? email;
//   String? image;
//   String? dob;
//   String? gender;
//   Null? otp;
//   String? rating;
//   String? avgPrice;
//   String? currentStatus;
//   String? phoneCode;
//   String? phone;
//   String? imageUrl;
//   String? shopName;
//   String? shopEmail;
//   String? shopimage;
//   String? shopAddress;
//   String? shopDes;
//   OpeningHours? openingHours;
//   int? countryId;
//   int? stateId;
//   int? cityId;
//   List<String>? categoryId;
//   Null? opensAt;
//   Null? closesAt;
//   String? role;
//   int? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Restaurant(
//       {this.id,
//       this.name,
//       this.email,
//       this.image,
//       this.dob,
//       this.gender,
//       this.otp,
//       this.rating,
//       this.avgPrice,
//       this.currentStatus,
//       this.phoneCode,
//       this.phone,
//       this.imageUrl,
//       this.shopName,
//       this.shopEmail,
//       this.shopimage,
//       this.shopAddress,
//       this.shopDes,
//       this.openingHours,
//       this.countryId,
//       this.stateId,
//       this.cityId,
//       this.categoryId,
//       this.opensAt,
//       this.closesAt,
//       this.role,
//       this.status,
//       this.createdAt,
//       this.updatedAt});
//
//   Restaurant.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     image = json['image'];
//     dob = json['dob'];
//     gender = json['gender'];
//     otp = json['otp'];
//     rating = json['rating'];
//     avgPrice = json['avg_price'];
//     currentStatus = json['current_status'];
//     phoneCode = json['phone_code'];
//     phone = json['phone'];
//     imageUrl = json['image_url'];
//     shopName = json['shop_name'];
//     shopEmail = json['shop_email'];
//     shopimage = json['shopimage'];
//     shopAddress = json['shop_address'];
//     shopDes = json['shop_des'];
//     openingHours = json['opening_hours'] != null
//         ? new OpeningHours.fromJson(json['opening_hours'])
//         : null;
//     countryId = json['country_id'];
//     stateId = json['state_id'];
//     cityId = json['city_id'];
//     categoryId = json['category_id'].cast<String>();
//     opensAt = json['opens_at'];
//     closesAt = json['closes_at'];
//     role = json['role'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['image'] = this.image;
//     data['dob'] = this.dob;
//     data['gender'] = this.gender;
//     data['otp'] = this.otp;
//     data['rating'] = this.rating;
//     data['avg_price'] = this.avgPrice;
//     data['current_status'] = this.currentStatus;
//     data['phone_code'] = this.phoneCode;
//     data['phone'] = this.phone;
//     data['image_url'] = this.imageUrl;
//     data['shop_name'] = this.shopName;
//     data['shop_email'] = this.shopEmail;
//     data['shopimage'] = this.shopimage;
//     data['shop_address'] = this.shopAddress;
//     data['shop_des'] = this.shopDes;
//     if (this.openingHours != null) {
//       data['opening_hours'] = this.openingHours!.toJson();
//     }
//     data['country_id'] = this.countryId;
//     data['state_id'] = this.stateId;
//     data['city_id'] = this.cityId;
//     data['category_id'] = this.categoryId;
//     data['opens_at'] = this.opensAt;
//     data['closes_at'] = this.closesAt;
//     data['role'] = this.role;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class OpeningHours {
//   Sunday? sunday;
//   Sunday? monday;
//   Sunday? tuesday;
//   Sunday? wednesday;
//   Sunday? thursday;
//   Sunday? friday;
//   Saturday? saturday;
//
//   OpeningHours({
//     this.sunday,
//     this.monday,
//     this.tuesday,
//     this.wednesday,
//     this.thursday,
//     this.friday,
//     this.saturday,
//   });
//
//   OpeningHours.fromJson(Map<String, dynamic> json) {
//     sunday = json['Sunday'] != null ? Sunday.fromJson(json['Sunday']) : null;
//     monday = json['Monday'] != null ? Sunday.fromJson(json['Monday']) : null;
//     tuesday = json['Tuesday'] != null ? Sunday.fromJson(json['Tuesday']) : null;
//     wednesday =
//         json['Wednesday'] != null ? Sunday.fromJson(json['Wednesday']) : null;
//     thursday =
//         json['Thursday'] != null ? Sunday.fromJson(json['Thursday']) : null;
//     friday = json['Friday'] != null ? Sunday.fromJson(json['Friday']) : null;
//     saturday =
//         json['Saturday'] != null ? Saturday.fromJson(json['Saturday']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.sunday != null) data['Sunday'] = this.sunday!.toJson();
//     if (this.monday != null) data['Monday'] = this.monday!.toJson();
//     if (this.tuesday != null) data['Tuesday'] = this.tuesday!.toJson();
//     if (this.wednesday != null) data['Wednesday'] = this.wednesday!.toJson();
//     if (this.thursday != null) data['Thursday'] = this.thursday!.toJson();
//     if (this.friday != null) data['Friday'] = this.friday!.toJson();
//     if (this.saturday != null) data['Saturday'] = this.saturday!.toJson();
//     return data;
//   }
// }
//
// class Sunday {
//   String? status;
//   String? open;
//   String? close;
//
//   Sunday({this.status, this.open, this.close});
//
//   Sunday.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     open = json['open'];
//     close = json['close'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['open'] = this.open;
//     data['close'] = this.close;
//     return data;
//   }
// }
//
// class Saturday {
//   String? open;
//   String? close;
//
//   Saturday({this.open, this.close});
//
//   Saturday.fromJson(Map<String, dynamic> json) {
//     open = json['open'];
//     close = json['close'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['open'] = this.open;
//     data['close'] = this.close;
//     return data;
//   }
// }
