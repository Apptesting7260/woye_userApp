class OrdersList {
  String? message;
  List<Orders>? orders;

  OrdersList({this.message, this.orders});

  OrdersList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;
  String? orderId;
  int? customerId;
  String? paymentMethod;
  int? addressId;
  Null? couponId;
  int? restaurantId;
  int? total;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<DecodedAttribute>? decodedAttribute;

  Orders(
      {this.id,
      this.orderId,
      this.customerId,
      this.paymentMethod,
      this.addressId,
      this.couponId,
      this.restaurantId,
      this.total,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.decodedAttribute});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    customerId = json['customer_id'];
    paymentMethod = json['payment_method'];
    addressId = json['address_id'];
    couponId = json['coupon_id'];
    restaurantId = json['restaurant_id'];
    total = json['total'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['decoded_attribute'] != null) {
      decodedAttribute = <DecodedAttribute>[];
      json['decoded_attribute'].forEach((v) {
        decodedAttribute!.add(new DecodedAttribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['customer_id'] = this.customerId;
    data['payment_method'] = this.paymentMethod;
    data['address_id'] = this.addressId;
    data['coupon_id'] = this.couponId;
    data['restaurant_id'] = this.restaurantId;
    data['total'] = this.total;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.decodedAttribute != null) {
      data['decoded_attribute'] =
          this.decodedAttribute!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DecodedAttribute {
  String? productId;
  int? quantity;
  String? price;
  List<Addons>? addons;
  List<Attribute>? attribute;
  String? checked;
  // List<String>? addonName;
  String? productName;
  String? productImage;

  DecodedAttribute(
      {this.productId,
      this.quantity,
      this.price,
      this.addons,
      this.attribute,
      this.checked,
      // this.addonName,
      this.productName,
      this.productImage});

  DecodedAttribute.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(new Addons.fromJson(v));
      });
    }
    if (json['attribute'] != null) {
      attribute = <Attribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(new Attribute.fromJson(v));
      });
    }
    checked = json['checked'];
    // addonName = json['addon_name'].cast<String>();
    productName = json['product_name'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    data['checked'] = this.checked;
    // data['addon_name'] = this.addonName;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    return data;
  }
}

class Addons {
  String? id;
  String? price;
  String? name;

  Addons({this.id, this.price, this.name});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['name'] = this.name;
    return data;
  }
}

class Attribute {
  String? titleId;
  ItemDetails? itemDetails;

  Attribute({this.titleId, this.itemDetails});

  Attribute.fromJson(Map<String, dynamic> json) {
    titleId = json['title_id'];
    itemDetails = json['item_details'] != null
        ? new ItemDetails.fromJson(json['item_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title_id'] = this.titleId;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.toJson();
    }
    return data;
  }
}

class ItemDetails {
  String? itemId;
  String? itemName;
  String? itemPrice;

  ItemDetails({this.itemId, this.itemName, this.itemPrice});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemPrice = json['item_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['item_price'] = this.itemPrice;
    return data;
  }
}
