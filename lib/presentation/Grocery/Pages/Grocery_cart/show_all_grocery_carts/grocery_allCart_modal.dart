class GroceryAllCartModal {
  bool? status;
  bool? buttonCheck;
  List<Carts>? carts;
  String? message;

  GroceryAllCartModal({
    this.status,
    this.buttonCheck = false,
    this.carts,
    this.message,
  });

  GroceryAllCartModal.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['buttonCheck'] = this.buttonCheck;
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Carts {
  int? id;
  int? groceryId;
  Grocery? grocery;

  Carts({this.id, this.groceryId, this.grocery});

  Carts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groceryId = json['grocery_id'];
    grocery =
        json['grocery'] != null ? new Grocery.fromJson(json['grocery']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['grocery_id'] = this.groceryId;
    if (this.grocery != null) {
      data['grocery'] = this.grocery!.toJson();
    }
    return data;
  }
}

class Grocery {
  int? id;
  String? shopimage;
  String? shopName;

  Grocery({this.id, this.shopimage, this.shopName});

  Grocery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopimage = json['shopimage'];
    shopName = json['shop_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shopimage'] = this.shopimage;
    data['shop_name'] = this.shopName;
    return data;
  }
}
