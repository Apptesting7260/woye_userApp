class RestaurantAllCartDataModel {
  bool? status;
  bool? buttonCheck;
  List<Carts>? carts;
  String? message;

  RestaurantAllCartDataModel(
      {this.status, this.buttonCheck, this.carts, this.message});

  RestaurantAllCartDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    buttonCheck = json['buttonCheck'];
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(new Carts.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['buttonCheck'] = buttonCheck;
    if (carts != null) {
      data['carts'] = carts!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Carts {
  String? id;
  String? restoId;
  Resto? resto;

  Carts({this.id, this.restoId, this.resto});

  Carts.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    restoId = json['resto_id']?.toString();
    resto = json['resto'] != null ? new Resto.fromJson(json['resto']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['resto_id'] = restoId;
    if (resto != null) {
      data['resto'] = resto!.toJson();
    }
    return data;
  }
}

class Resto {
  String? id;
  String? shopimage;
  String? coverPhotoUrl;
  String? shopName;

  Resto({this.id, this.shopimage, this.shopName});

  Resto.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    shopimage = json['logo_url']?.toString();
    coverPhotoUrl = json['cover_photo_url']?.toString();
    shopName = json['shop_name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['logo_url'] = shopimage;
    data['cover_photo_url'] = coverPhotoUrl;
    data['shop_name'] = shopName;
    return data;
  }
}
