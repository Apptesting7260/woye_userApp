class AllPharmaShopsModal {
  bool? status;
  List<Shops>? shops;
  String? message;

  AllPharmaShopsModal({this.status, this.shops, this.message});

  AllPharmaShopsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['shops'] != null) {
      shops = <Shops>[];
      json['shops'].forEach((v) {
        shops!.add(new Shops.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Shops {
  int? id;
  String? name;
  String? rating;
  String? avgPrice;
  String? shopimage;
  String? shopName;
  String? shopAddress;
  String? shopDes;

  Shops(
      {this.id,
        this.name,
        this.rating,
        this.avgPrice,
        this.shopimage,
        this.shopName,
        this.shopAddress,
        this.shopDes});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
    avgPrice = json['avg_price'];
    shopimage = json['shopimage'];
    shopName = json['shop_name'];
    shopAddress = json['shop_address'];
    shopDes = json['shop_des'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['avg_price'] = this.avgPrice;
    data['shopimage'] = this.shopimage;
    data['shop_name'] = this.shopName;
    data['shop_address'] = this.shopAddress;
    data['shop_des'] = this.shopDes;
    return data;
  }
}
