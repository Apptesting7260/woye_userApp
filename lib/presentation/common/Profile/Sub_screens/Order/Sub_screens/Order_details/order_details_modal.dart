class OrderDetailsModal {
  bool? status;
  OrderDetails? orderDetails;
  AddressDetails? addressDetails;
  var deliveryCharges;
  var subtotal;
  Review? review;
  String? invoice;

  OrderDetailsModal({
    this.status,
    this.orderDetails,
    this.addressDetails,
    this.deliveryCharges,
    this.subtotal,
    this.review,
    this.invoice,
  });

  OrderDetailsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderDetails = json['orderDetails'] != null
        ? OrderDetails.fromJson(json['orderDetails'])
        : null;
    addressDetails = json['addressDetails'] != null
        ? AddressDetails.fromJson(json['addressDetails'])
        : null;
    deliveryCharges = json['deliveryCharges'];
    subtotal = json['subtotal'];
    review = json['reviews'] != null ? Review.fromJson(json['reviews']) : null;
    invoice = json['invoice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (orderDetails != null) {
      data['orderDetails'] = orderDetails!.toJson();
    }
    if (addressDetails != null) {
      data['addressDetails'] = addressDetails!.toJson();
    }
    data['deliveryCharges'] = deliveryCharges;
    data['subtotal'] = subtotal;
    if (review != null) {
      data['reviews'] = review!.toJson();
    }
    data['invoice'] = invoice;

    return data;
  }
}

class  OrderDetails {
  int? id;
  String? orderId;
  String? trackingId;
  int? customerId;
  String? paymentMethod;
  int? addressId;
  int? couponId;
  Coupon? coupon;
  String? type;
  int? vendorId;
  String? walletUsed;
  String? remainingPayment;
  var total;
  String? status;
  List<String>? drslip;
  String? createdAt;
  String? updatedAt;
  List<DecodedAttribute>? decodedAttribute;
  String? vendorName;
  String? deliveryNotes;
  String? courierTip;
  String? deliverySoon;
  AddressDetails? addressDetails;

  OrderDetails(
      {this.id,
      this.orderId,
      this.trackingId,
      this.customerId,
      this.paymentMethod,
      this.addressId,
      this.couponId,
      this.coupon, // Include coupon in constructor
      this.type,
      this.vendorId,
      this.walletUsed,
      this.remainingPayment,
      this.total,
      this.status,
      this.drslip,
      this.createdAt,
      this.updatedAt,
      this.decodedAttribute,
      this.vendorName,
      this.courierTip,
      this.deliveryNotes,
      this.deliverySoon,
      this.addressDetails});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    trackingId = json['tracking_id'];
    customerId = json['customer_id'];
    paymentMethod = json['payment_method'];
    addressId = json['address_id'];
    couponId = json['coupon_id'];
    coupon = json['coupon'] != null
        ? Coupon.fromJson(json['coupon'])
        : null; // Deserialize coupon
    type = json['type'];
    vendorId = json['vendor_id'];
    walletUsed = json['wallet_used'];
    remainingPayment = json['remaining_payment'];
    total = json['total'];
    status = json['status'];
    if(json['drslip'] != null){
      drslip = json['drslip'].cast<String>();
    }else{
      drslip = <String>[];
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['decoded_attribute'] != null) {
      decodedAttribute = <DecodedAttribute>[];
      json['decoded_attribute'].forEach((v) {
        decodedAttribute!.add(new DecodedAttribute.fromJson(v));
      });
    }
    vendorName = json['vendor_name'];
    deliveryNotes = json['delivery_notes']?.toString();
    courierTip = json['courier_tip']?.toString();
    deliverySoon = json['delivery_soon']?.toString();
    addressDetails = json['address_details'] != null
        ? new AddressDetails.fromJson(json['address_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['order_id'] = orderId;
    data['tracking_id'] = trackingId;
    data['customer_id'] = customerId;
    data['payment_method'] = paymentMethod;
    data['address_id'] = addressId;
    data['coupon_id'] = couponId;
    if (coupon != null) {
      data['coupon'] = coupon!.toJson(); // Serialize coupon
    }
    data['type'] = type;
    data['vendor_id'] = vendorId;
    data['wallet_used'] = walletUsed;
    data['remaining_payment'] = remainingPayment;
    data['total'] = total;
    data['status'] = status;
    data['drslip'] = this.drslip;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (decodedAttribute != null) {
      data['decoded_attribute'] =
          decodedAttribute!.map((v) => v.toJson()).toList();
    }
    data['vendor_name'] = vendorName;
    data['delivery_notes'] = deliveryNotes;
    data['courier_tip'] = courierTip;
    data['delivery_soon'] = deliverySoon;
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
  List<Addons>? addons;
  List<Attribute>? attribute;
  String? checked;
  int? count;
  String? productName;
  String? productImage;
  int? categoryId;
  String? categoryName;

  DecodedAttribute(
      {this.productId,
      this.quantity,
      this.price,
      this.addons,
      this.attribute,
      this.checked,
      this.count,
      this.productName,
      this.productImage,
      this.categoryId,
      this.categoryName});

  DecodedAttribute.fromJson(Map<String, dynamic> json) {
    productId = json['product_id']?.toString();
    quantity = json['quantity'];
    price = json['price']?.toString();
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
    count = json['count'];
    productName = json['product_name']?.toString();
    productImage = json['product_image']?.toString();
    categoryId = json['category_id'];
    categoryName = json['category_name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['count'] = count;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
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

class Coupon {
  int? id;
  String? couponType;
  String? title;
  String? code;

  // int? limitForUser;
  String? discountType;
  String? discountAmount;

  // String? minPurchase;
  // String? maxDiscount;
  // String? startDate;
  // String? expireDate;
  // String? category;
  // List<int>? subCategoryId;
  // List<int>? productId;
  // List<int>? customerId;
  int? status;

  // String? createdAt;
  // String? updatedAt;
  // String? expiryStatus;

  Coupon({
    this.id,
    this.couponType,
    this.title,
    this.code,
    // this.limitForUser,
    this.discountType,
    this.discountAmount,
    // this.minPurchase,
    // this.maxDiscount,
    // this.startDate,
    // this.expireDate,
    // this.category,
    // this.subCategoryId,
    // this.productId,
    // this.customerId,
    this.status,
    // this.createdAt,
    // this.updatedAt,
    // this.expiryStatus,
  });

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponType = json['coupon_type'];
    title = json['title'];
    code = json['code'];
    // limitForUser = json['limit_for_user'];
    discountType = json['discount_type'];
    discountAmount = json['discount_amount'];
    // minPurchase = json['min_purchase'];
    // maxDiscount = json['max_discount'];
    // startDate = json['start_date'];
    // expireDate = json['expire_date'];
    // category = json['category'];
    // subCategoryId = List<int>.from(json['sub_category_id'] ?? []);
    // productId = List<int>.from(json['product_id'] ?? []);
    // customerId = List<int>.from(json['customer_id'] ?? []);
    status = json['status'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // expiryStatus = json['expiry_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['coupon_type'] = couponType;
    data['title'] = title;
    data['code'] = code;
    // data['limit_for_user'] = this.limitForUser;
    data['discount_type'] = discountType;
    data['discount_amount'] = discountAmount;
    // data['min_purchase'] = this.minPurchase;
    // data['max_discount'] = this.maxDiscount;
    // data['start_date'] = this.startDate;
    // data['expire_date'] = this.expireDate;
    // data['category'] = this.category;
    // data['sub_category_id'] = this.subCategoryId;
    // data['product_id'] = this.productId;
    // data['customer_id'] = this.customerId;
    data['status'] = status;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    // data['expiry_status'] = this.expiryStatus;
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
