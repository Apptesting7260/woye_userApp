class RestaurantCartModal {
  bool? status;
  String? message;
  Cart? cart;

  RestaurantCartModal({this.status, this.message, this.cart});

  factory RestaurantCartModal.fromJson(Map<String, dynamic> json) {
    var cartData = json['cart'];

    return RestaurantCartModal(
      status: json['status'],
      message: json['message'],
      cart: cartData != null ? Cart.fromJson(cartData) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'cart': cart?.toJson(),
    };
  }
}

class Cart {
  int? id;
  int? userId;
  int? productId;
  int? restoId;
  String? status;
  int? orderId;
  String? bucket;
  String? createdAt;
  String? updatedAt;
  List<DecodedAttribute>? decodedAttribute;

  Cart({
    this.id,
    this.userId,
    this.productId,
    this.restoId,
    this.status,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.decodedAttribute,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var decodedAttributeList = (json['decoded_attribute'] as List?)
        ?.map((item) => DecodedAttribute.fromJson(item))
        .toList();

    return Cart(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      restoId: json['resto_id'],
      status: json['status'],
      orderId: json['order_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      decodedAttribute: decodedAttributeList ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'resto_id': restoId,
      'status': status,
      'order_id': orderId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'decoded_attribute': decodedAttribute?.map((e) => e.toJson()).toList() ?? [],
    };
  }
}

class DecodedAttribute {
  String? productId;
  var quantity;
  String? price;
  List<String>? addons;
  List<Attribute>? attribute;
  String? productName;
  List<String>? addonName;
  String? productImage;
  var totalPrice;

  DecodedAttribute({
    this.productId,
    this.quantity,
    this.price,
    this.addons,
    this.attribute,
    this.productName,
    this.addonName,
    this.productImage,
    this.totalPrice,
  });

  factory DecodedAttribute.fromJson(Map<String, dynamic> json) {
    var attributeList = (json['attribute'] as List?)
        ?.map((item) => Attribute.fromJson(item))
        .toList();

    return DecodedAttribute(
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'],
      addons: List<String>.from(json['addons'] ?? []),
      attribute: attributeList ?? [],
      productName: json['product_name'],
      addonName: List<String>.from(json['addon_name'] ?? []),
      productImage: json['product_image'],
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'addons': addons,
      'attribute': attribute?.map((e) => e.toJson()).toList() ?? [],
      'product_name': productName,
      'addon_name': addonName,
      'product_image': productImage,
      'total_price': totalPrice,
    };
  }
}

class Attribute {
  String? titleId;
  ItemDetails? itemDetails;

  Attribute({this.titleId, this.itemDetails});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      titleId: json['title_id'],
      itemDetails: ItemDetails.fromJson(json['item_details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title_id': titleId,
      'item_details': itemDetails?.toJson(),
    };
  }
}

class ItemDetails {
  String? itemId;
  String? itemName;
  String? itemPrice;

  ItemDetails({
    this.itemId,
    this.itemName,
    this.itemPrice,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      itemId: json['item_id'],
      itemName: json['item_name'],
      itemPrice: json['item_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'item_name': itemName,
      'item_price': itemPrice,
    };
  }
}
