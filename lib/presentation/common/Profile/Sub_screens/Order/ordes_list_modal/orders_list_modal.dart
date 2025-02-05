// class OrdersList {
//   String? message;
//   List<Orders>? orders;
//
//   OrdersList({this.message, this.orders});
//
//   OrdersList.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     if (json['orders'] != null) {
//       orders = <Orders>[];
//       json['orders'].forEach((v) {
//         orders!.add(new Orders.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.orders != null) {
//       data['orders'] = this.orders!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
class OrdersList {
  String? message;
  List<Orders>? orders;
  List<Orders>? waitingOrders; // Added waiting orders
  List<Orders>? deliveredOrders; // Added delivered orders
  List<Orders>? cancelOrders; // Added canceled orders

  OrdersList({
    this.message,
    this.orders,
    this.waitingOrders,
    this.deliveredOrders,
    this.cancelOrders,
  });

  OrdersList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    // Handling all orders
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    // Handling waiting orders
    if (json['waiting_orders'] != null) {
      waitingOrders = <Orders>[];
      json['waiting_orders'].forEach((v) {
        waitingOrders!.add(Orders.fromJson(v));
      });
    }
    // Handling delivered orders
    if (json['delivered_orders'] != null) {
      deliveredOrders = <Orders>[];
      json['delivered_orders'].forEach((v) {
        deliveredOrders!.add(Orders.fromJson(v));
      });
    }
    // Handling canceled orders
    if (json['cancel_orders'] != null) {
      cancelOrders = <Orders>[];
      json['cancel_orders'].forEach((v) {
        cancelOrders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;

    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    if (this.waitingOrders != null) {
      data['waiting_orders'] =
          this.waitingOrders!.map((v) => v.toJson()).toList();
    }
    if (this.deliveredOrders != null) {
      data['delivered_orders'] =
          this.deliveredOrders!.map((v) => v.toJson()).toList();
    }
    if (this.cancelOrders != null) {
      data['cancel_orders'] =
          this.cancelOrders!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Orders {
  int? id;
  String? orderId;
  String? trackingId;
  int? customerId;
  String? paymentMethod;
  int? addressId;
  int? couponId;
  String? type;
  int? vendorId;
  String? walletUsed;
  String? remainingPayment;
  double? total;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<DecodedAttribute>? decodedAttribute;
  String? vendorName;
  dynamic addressDetails;

  Orders({
    this.id,
    this.orderId,
    this.trackingId,
    this.customerId,
    this.paymentMethod,
    this.addressId,
    this.couponId,
    this.type,
    this.vendorId,
    this.walletUsed,
    this.remainingPayment,
    this.total,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.decodedAttribute,
    this.vendorName,
    this.addressDetails,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    trackingId = json['tracking_id'];
    customerId = json['customer_id'];
    paymentMethod = json['payment_method'];
    addressId = json['address_id'];
    couponId = json['coupon_id'];
    type = json['type'];
    vendorId = json['vendor_id'];
    walletUsed = json['wallet_used'];
    remainingPayment = json['remaining_payment'];
    total = json['total']
        ?.toDouble(); // Total is a number, so we need to convert it to a double if necessary
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['decoded_attribute'] != null) {
      decodedAttribute = <DecodedAttribute>[];
      json['decoded_attribute'].forEach((v) {
        decodedAttribute!.add(new DecodedAttribute.fromJson(v));
      });
    }
    vendorName = json['vendor_name'];
    addressDetails = json['address_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['tracking_id'] = this.trackingId;
    data['customer_id'] = this.customerId;
    data['payment_method'] = this.paymentMethod;
    data['address_id'] = this.addressId;
    data['coupon_id'] = this.couponId;
    data['type'] = this.type;
    data['vendor_id'] = this.vendorId;
    data['wallet_used'] = this.walletUsed;
    data['remaining_payment'] = this.remainingPayment;
    data['total'] = this.total;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.decodedAttribute != null) {
      data['decoded_attribute'] =
          this.decodedAttribute!.map((v) => v.toJson()).toList();
    }
    data['vendor_name'] = this.vendorName;
    data['address_details'] = this.addressDetails;
    return data;
  }
}

class DecodedAttribute {
  var productId;
  var quantity;
  var price;
  List<Addons>? addons;
  List<Attribute>? attribute;
  String? checked;
  List<String>? addonName;
  String? productName;
  String? productImage;

  DecodedAttribute({
    this.productId,
    this.quantity,
    this.price,
    this.addons,
    this.attribute,
    this.checked,
    this.addonName,
    this.productName,
    this.productImage,
  });

  DecodedAttribute.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(Addons.fromJson(v));
      });
    }
    if (json['attribute'] != null) {
      attribute = <Attribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(Attribute.fromJson(v));
      });
    }
    checked = json['checked'];
    addonName =
        json['addon_name'] != null ? List<String>.from(json['addon_name']) : [];
    productName = json['product_name'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['addon_name'] = this.addonName;
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
