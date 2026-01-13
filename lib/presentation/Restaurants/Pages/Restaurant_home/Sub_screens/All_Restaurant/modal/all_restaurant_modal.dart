class all_restaurant_modal {
  bool? status;
  List<Restaurants>? restaurants;
  String? message;
  String? avgPrice;

  all_restaurant_modal({this.status, this.restaurants, this.message, this.avgPrice});

  all_restaurant_modal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(new Restaurants.fromJson(v));
      });
    }
    message = json['message'];
    avgPrice = json['avg_price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['avg_price'] = this.avgPrice;
    return data;
  }
}

class Restaurants {
  int? id;
  String? rating;
  String? shopName;
  String? description;
  OpeningHours? openingHours;
  String? logo;
  bool? isInWishlist;
  String? logoUrl;
  String? coverPhotoUrl;
  String? roleName;
  String? role;

  Restaurants(
      {this.id,
        this.rating,
        this.shopName,
        this.description,
        this.openingHours,
        this.logo,
        this.isInWishlist,
        this.logoUrl,
        this.coverPhotoUrl,
        this.roleName,
        this.role});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating']?.toString();
    shopName = json['shop_name']?.toString();
    description = json['description']?.toString();
    openingHours = json['opening_hours'] != null
        ? new OpeningHours.fromJson(json['opening_hours'])
        : null;
    logo = json['logo'];
    isInWishlist = json['is_in_wishlist'];
    logoUrl = json['logo_url'];
    coverPhotoUrl = json['cover_photo_url']?.toString();
    roleName = json['role_name']?.toString();
    role = json['role']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['shop_name'] = this.shopName;
    data['description'] = this.description;
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours!.toJson();
    }
    data['logo'] = this.logo;
    data['is_in_wishlist'] = this.isInWishlist;
    data['logo_url'] = this.logoUrl;
    data['cover_photo_url'] = this.coverPhotoUrl;
    data['role_name'] = this.roleName;
    data['role'] = this.role;
    return data;
  }
}

class OpeningHours {
  Monday? monday;
  Monday? tuesday;
  Monday? wednesday;
  Monday? thursday;
  Monday? friday;
  Monday? saturday;
  Monday? sunday;

  OpeningHours(
      {this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.sunday});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    monday =
    json['Monday'] != null ? new Monday.fromJson(json['Monday']) : null;
    tuesday =
    json['Tuesday'] != null ? new Monday.fromJson(json['Tuesday']) : null;
    wednesday = json['Wednesday'] != null
        ? new Monday.fromJson(json['Wednesday'])
        : null;
    thursday =
    json['Thursday'] != null ? new Monday.fromJson(json['Thursday']) : null;
    friday =
    json['Friday'] != null ? new Monday.fromJson(json['Friday']) : null;
    saturday =
    json['Saturday'] != null ? new Monday.fromJson(json['Saturday']) : null;
    sunday =
    json['Sunday'] != null ? new Monday.fromJson(json['Sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monday != null) {
      data['Monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['Tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['Wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['Thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['Friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['Saturday'] = this.saturday!.toJson();
    }
    if (this.sunday != null) {
      data['Sunday'] = this.sunday!.toJson();
    }
    return data;
  }
}

class Monday {
  String? status;
  String? open;
  String? close;

  Monday({this.status, this.open, this.close});

  Monday.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = json['status'].toString();
    }
    open = json['open'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['open'] = this.open;
    data['close'] = this.close;
    return data;
  }
}
