class PharmacyAllCartProductModel {
  bool? status;
  bool? buttonCheck;
  List<Carts>? carts;
  String? message;

  PharmacyAllCartProductModel(
      {this.status, this.buttonCheck, this.carts, this.message});

  PharmacyAllCartProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    buttonCheck = json['buttonCheck'];
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(Carts.fromJson(v));
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
  int? id;
  int? pharmaId;
  String? pres;
  Pharmacy? pharmacy;

  Carts({this.id, this.pharmaId, this.pres, this.pharmacy});

  Carts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmaId = json['pharma_id'];
    pres = json['pres'];
    pharmacy = json['pharmacy'] != null
        ? Pharmacy.fromJson(json['pharmacy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pharma_id'] = pharmaId;
    data['pres'] = pres;
    if (pharmacy != null) {
      data['pharmacy'] = pharmacy!.toJson();
    }
    return data;
  }
}

class Pharmacy {
  int? id;
  String? shopimage;
  String? shopName;

  Pharmacy({this.id, this.shopimage, this.shopName});

  Pharmacy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopimage = json['shopimage'];
    shopName = json['shop_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shopimage'] = shopimage;
    data['shop_name'] = shopName;
    return data;
  }
}
