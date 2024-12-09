class all_restaurant_modal {
  bool? status;
  List<Restaurants>? restaurants;
  String? message;

  all_restaurant_modal({this.status, this.restaurants, this.message});

  all_restaurant_modal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(new Restaurants.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Restaurants {
  int? id;
  String? rating;
  String? avgPrice;
  String? shopName;
  String? shopDes;
  String? currentStatus;
  String? shopimage;
  bool? isInWishlist;

  Restaurants(
      {this.id,
        this.rating,
        this.avgPrice,
        this.shopName,
        this.shopDes,
        this.currentStatus,
        this.shopimage,
        this.isInWishlist});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    avgPrice = json['avg_price'];
    shopName = json['shop_name'];
    shopDes = json['shop_des'];
    currentStatus = json['current_status'];
    shopimage = json['shopimage'];
    isInWishlist = json['is_in_wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['avg_price'] = this.avgPrice;
    data['shop_name'] = this.shopName;
    data['shop_des'] = this.shopDes;
    data['current_status'] = this.currentStatus;
    data['shopimage'] = this.shopimage;
    data['is_in_wishlist'] = this.isInWishlist;
    return data;
  }
}
