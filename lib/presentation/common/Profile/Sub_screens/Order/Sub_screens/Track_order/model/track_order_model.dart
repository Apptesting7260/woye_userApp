class TrackOrderRestaurantModel {
  bool? status;
  OrderDetails? orderDetails;
  String? message;

  TrackOrderRestaurantModel({this.status, this.orderDetails, this.message});

  TrackOrderRestaurantModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderDetails = json['orderDetails'] != null
        ? OrderDetails.fromJson(json['orderDetails'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (orderDetails != null) {
      data['orderDetails'] = orderDetails!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class OrderDetails {
  int? id;
  String? orderId;
  String? trackingId;
  int? customerId;
  String? orders;
  String? paymentMethod;
  String? paymentStatus;
  int? addressId;
  dynamic couponId; // changed from Null
  String? type;
  int? vendorId;
  String? walletUsed;
  String? remainingPayment;
  String? total;
  String? status;
  List<String>? drslip;
  String? deliveredAt;
  String? createdAt;
  String? updatedAt;
  List<DecodedAttribute>? decodedAttribute;
  String? vendorName;
  AddressDetails? addressDetails;

  OrderDetails({
    this.id,
    this.orderId,
    this.trackingId,
    this.customerId,
    this.orders,
    this.paymentMethod,
    this.paymentStatus,
    this.addressId,
    this.couponId,
    this.type,
    this.vendorId,
    this.walletUsed,
    this.remainingPayment,
    this.total,
    this.status,
    this.drslip,
    this.deliveredAt,
    this.createdAt,
    this.updatedAt,
    this.decodedAttribute,
    this.vendorName,
    this.addressDetails,
  });

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    trackingId = json['tracking_id'];
    customerId = json['customer_id'];
    orders = json['orders'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    addressId = json['address_id'];
    couponId = json['coupon_id'];
    type = json['type'];
    vendorId = json['vendor_id'];
    walletUsed = json['wallet_used'];
    remainingPayment = json['remaining_payment'];
    total = json['total'];
    status = json['status'];
    if(json['drslip'] != null){
      drslip = json['drslip'].cast<String>();
    }
    deliveredAt = json['delivered_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['decoded_attribute'] != null) {
      decodedAttribute = List<DecodedAttribute>.from(
        json['decoded_attribute'].map((v) => DecodedAttribute.fromJson(v)),
      );
    }
    vendorName = json['vendor_name'];
    addressDetails = json['address_details'] != null
        ? AddressDetails.fromJson(json['address_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['tracking_id'] = trackingId;
    data['customer_id'] = customerId;
    data['orders'] = orders;
    data['payment_method'] = paymentMethod;
    data['payment_status'] = paymentStatus;
    data['address_id'] = addressId;
    data['coupon_id'] = couponId;
    data['type'] = type;
    data['vendor_id'] = vendorId;
    data['wallet_used'] = walletUsed;
    data['remaining_payment'] = remainingPayment;
    data['total'] = total;
    data['status'] = status;
    data['drslip'] = drslip;
    data['delivered_at'] = deliveredAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (decodedAttribute != null) {
      data['decoded_attribute'] =
          decodedAttribute!.map((v) => v.toJson()).toList();
    }
    data['vendor_name'] = vendorName;
    if (addressDetails != null) {
      data['address_details'] = addressDetails!.toJson();
    }
    return data;
  }
}

class DecodedAttribute {
  String? productId;
  int? quantity;
  String? price;
  List<dynamic>? addons; // generic dynamic list
  List<dynamic>? attribute;
  String? checked;
  int? count;
  List<dynamic>? addonName;
  String? productName;
  int? categoryId;
  String? categoryName;
  String? productImage;

  DecodedAttribute({
    this.productId,
    this.quantity,
    this.price,
    this.addons,
    this.attribute,
    this.checked,
    this.count,
    this.addonName,
    this.productName,
    this.categoryId,
    this.categoryName,
    this.productImage,
  });

  DecodedAttribute.fromJson(Map<String, dynamic> json) {
    productId = json['product_id']?.toString();
    quantity = json['quantity'];
    price = json['price']?.toString();
    addons = json['addons'];
    attribute = json['attribute'];
    checked = json['checked']?.toString();
    count = json['count'];
    addonName = json['addon_name'];
    productName = json['product_name']?.toString();
    categoryId = json['category_id'];
    categoryName = json['category_name']?.toString();
    productImage = json['product_image']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['addons'] = addons;
    data['attribute'] = attribute;
    data['checked'] = checked;
    data['count'] = count;
    data['addon_name'] = addonName;
    data['product_name'] = productName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['product_image'] = productImage;
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

  AddressDetails({
    this.id,
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
    this.updatedAt,
  });

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
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['phone_number'] = phoneNumber;
    data['country_code'] = countryCode;
    data['house_details'] = houseDetails;
    data['address'] = address;
    data['address_type'] = addressType;
    data['is_default'] = isDefault;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['delivery_instruction'] = deliveryInstruction;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
