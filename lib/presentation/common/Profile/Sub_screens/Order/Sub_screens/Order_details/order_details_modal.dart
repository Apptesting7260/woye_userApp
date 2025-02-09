class OrderDetailsModal {
  bool? status;
  OrderDetails? orderDetails;
  AddressDetails? addressDetails;

  OrderDetailsModal({this.status, this.orderDetails, this.addressDetails});

  OrderDetailsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderDetails = json['orderDetails'] != null
        ? new OrderDetails.fromJson(json['orderDetails'])
        : null;
    addressDetails = json['addressDetails'] != null
        ? new AddressDetails.fromJson(json['addressDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.toJson();
    }
    if (this.addressDetails != null) {
      data['addressDetails'] = this.addressDetails!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  int? id;
  String? orderId;
  String? trackingId;
  int? customerId;
  // String? orders;
  String? paymentMethod;
  int? addressId;
  int? couponId;
  String? type;
  int? vendorId;
  String? walletUsed;
  String? remainingPayment;
  int? total;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<DecodedAttribute>? decodedAttribute;
  String? vendorName;
  AddressDetails? addressDetails;

  OrderDetails(
      {this.id,
      this.orderId,
      this.trackingId,
      this.customerId,
      // this.orders,
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
      this.addressDetails});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    trackingId = json['tracking_id'];
    customerId = json['customer_id'];
    // orders = json['orders'];
    paymentMethod = json['payment_method'];
    addressId = json['address_id'];
    couponId = json['coupon_id'];
    type = json['type'];
    vendorId = json['vendor_id'];
    walletUsed = json['wallet_used'];
    remainingPayment = json['remaining_payment'];
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
    vendorName = json['vendor_name'];
    addressDetails = json['address_details'] != null
        ? new AddressDetails.fromJson(json['address_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['tracking_id'] = this.trackingId;
    data['customer_id'] = this.customerId;
    // data['orders'] = this.orders;
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
    if (this.addressDetails != null) {
      data['address_details'] = this.addressDetails!.toJson();
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
  int? count;
  List<String>? addonName;
  String? productName;
  String? productImage;

  DecodedAttribute(
      {this.productId,
      this.quantity,
      this.price,
      this.addons,
      this.attribute,
      this.checked,
      this.count,
      this.addonName,
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
    count = json['count'];
    addonName = json['addon_name'].cast<String>();
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
    data['count'] = this.count;
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

class AddressDetails {
  int? id;
  int? userId;
  String? fullName;
  String? phoneNumber;
  String? countryCode;
  String? houseDetails;
  String? address;
  String? addressType;
  int? isDefault;
  String? latitude;
  String? longitude;
  String? deliveryInstruction;
  String? createdAt;
  String? updatedAt;

  AddressDetails(
      {this.id,
      this.userId,
      this.fullName,
      this.phoneNumber,
      this.countryCode,
      this.houseDetails,
      this.address,
      this.addressType,
      this.isDefault,
      this.latitude,
      this.longitude,
      this.deliveryInstruction,
      this.createdAt,
      this.updatedAt});

  AddressDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    houseDetails = json['house_details'];
    address = json['address'];
    addressType = json['address_type'];
    isDefault = json['is_default'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deliveryInstruction = json['delivery_instruction'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['country_code'] = this.countryCode;
    data['house_details'] = this.houseDetails;
    data['address'] = this.address;
    data['address_type'] = this.addressType;
    data['is_default'] = this.isDefault;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['delivery_instruction'] = this.deliveryInstruction;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
