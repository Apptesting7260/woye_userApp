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
    data['message'] = message;

    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    if (waitingOrders != null) {
      data['waiting_orders'] =
          waitingOrders!.map((v) => v.toJson()).toList();
    }
    if (deliveredOrders != null) {
      data['delivered_orders'] =
          deliveredOrders!.map((v) => v.toJson()).toList();
    }
    if (cancelOrders != null) {
      data['cancel_orders'] =
          cancelOrders!.map((v) => v.toJson()).toList();
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
  var total;
  String? ordersSubtotal;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<DecodedAttribute>? decodedAttribute;
  String? vendorName;
  String? discountedTotal;
  dynamic addressDetails;
  Review? review;

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
    this.ordersSubtotal,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.decodedAttribute,
    this.vendorName,
    this.discountedTotal,
    this.addressDetails,
    this.review,
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
    total = json['total'];
    ordersSubtotal = json['ordersubtotal'];
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
    discountedTotal = json['discounted_total']?.toString();
    addressDetails = json['address_details'];
    review = json['reviews'] != null ? Review.fromJson(json['reviews']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['order_id'] = orderId;
    data['tracking_id'] = trackingId;
    data['customer_id'] = customerId;
    data['payment_method'] = paymentMethod;
    data['address_id'] = addressId;
    data['coupon_id'] = couponId;
    data['type'] = type;
    data['vendor_id'] = vendorId;
    data['wallet_used'] = walletUsed;
    data['remaining_payment'] = remainingPayment;
    data['total'] = total;
    data['ordersubtotal'] = ordersSubtotal;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (decodedAttribute != null) {
      data['decoded_attribute'] =
          decodedAttribute!.map((v) => v.toJson()).toList();
    }
    data['vendor_name'] = vendorName;
    data['discounted_total'] = discountedTotal;
    data['address_details'] = addressDetails;
    if (review != null) {
      data['reviews'] = review!.toJson();
    }
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
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    if (addons != null) {
      data['addons'] = addons!.map((v) => v.toJson()).toList();
    }
    if (attribute != null) {
      data['attribute'] = attribute!.map((v) => v.toJson()).toList();
    }
    data['checked'] = checked;
    data['addon_name'] = addonName;
    data['product_name'] = productName;
    data['product_image'] = productImage;
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
    data['id'] = id;
    data['price'] = price;
    data['name'] = name;
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
    data['title_id'] = titleId;
    if (itemDetails != null) {
      data['item_details'] = itemDetails!.toJson();
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
    data['item_id'] = itemId;
    data['item_name'] = itemName;
    data['item_price'] = itemPrice;
    return data;
  }
}

class Review {
  int? id;
  var orderId;
  var userId;
  var vendorId;
  String? type;
  var rating;
  String? review;
  String? reply;
  String? createdAt;
  String? updatedAt;
  User? user;

  Review({
    this.id,
    this.orderId,
    this.userId,
    this.vendorId,
    this.type,
    this.rating,
    this.review,
    this.reply,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      orderId: json['order_id'],
      userId: json['user_id'],
      vendorId: json['vendor_id'],
      type: json['type'],
      rating: json['rating'],
      review: json['review'],
      reply: json['reply'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['vendor_id'] = vendorId;
    data['type'] = type;
    data['rating'] = rating;
    data['review'] = review;
    data['reply'] = reply;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? imageUrl;

  User({this.id, this.firstName, this.lastName, this.imageUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'image_url': imageUrl,
    };
  }
}
