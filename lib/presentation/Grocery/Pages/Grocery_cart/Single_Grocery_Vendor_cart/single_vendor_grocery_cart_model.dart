import 'package:get/get.dart';
//
// class SingleVendorGroceryCart {
//   bool? status;
//   String? message;
//   Cart? cart;
//   var wallet;
//   Address? address;
//   List<Coupons>? coupons;
//   bool? addressExists;
//   String? cartContent;
//
//   SingleVendorGroceryCart(
//       {this.status,
//         this.message,
//         this.cart,
//         this.wallet,
//         this.address,
//         this.coupons,
//         this.addressExists,
//         this.cartContent});
//
//   SingleVendorGroceryCart.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
//     wallet = json['wallet'];
//     address =
//     json['address'] != null ? new Address.fromJson(json['address']) : null;
//     if (json['coupons'] != null) {
//       coupons = <Coupons>[];
//       json['coupons'].forEach((v) {
//         coupons!.add(new Coupons.fromJson(v));
//       });
//     }
//     addressExists = json['address_exists'];
//     cartContent = json['cartContent'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.cart != null) {
//       data['cart'] = this.cart!.toJson();
//     }
//     data['wallet'] = this.wallet;
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     if (this.coupons != null) {
//       data['coupons'] = this.coupons!.map((v) => v.toJson()).toList();
//     }
//     data['address_exists'] = this.addressExists;
//     data['cartContent'] = this.cartContent;
//     return data;
//   }
// }
//
// class Cart {
//   int? id;
//   int? userId;
//   var productId;
//   int? groceryId;
//   String? status;
//   var orderId;
//   String? bucket;
//   var couponId;
//   String? createdAt;
//   String? updatedAt;
//   DecodedAttribute? decodedAttribute;
//   var regularPrice;
//   var saveAmount;
//  var deliveryCharge;
//   var totalPrice;
//   var couponDiscount;
//   var grandTotalPrice;
//   var totalProductsInCart;
//
//   Cart(
//       {this.id,
//         this.userId,
//         this.productId,
//         this.groceryId,
//         this.status,
//         this.orderId,
//         this.bucket,
//         this.couponId,
//         this.createdAt,
//         this.updatedAt,
//         this.decodedAttribute,
//         this.regularPrice,
//         this.saveAmount,
//         this.deliveryCharge,
//         this.totalPrice,
//         this.couponDiscount,
//         this.grandTotalPrice,
//         this.totalProductsInCart});
//
//   Cart.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     productId = json['product_id'];
//     groceryId = json['grocery_id'];
//     status = json['status'];
//     orderId = json['order_id'];
//     bucket = json['bucket'];
//     couponId = json['coupon_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     decodedAttribute = json['decoded_attribute'] != null
//         ? new DecodedAttribute.fromJson(json['decoded_attribute'])
//         : null;
//     regularPrice = json['regular_price'];
//     saveAmount = json['save_amount'];
//     deliveryCharge = json['delivery_charge'];
//     totalPrice = json['total_price'];
//     couponDiscount = json['coupon_discount'];
//     grandTotalPrice = json['grand_total_price'];
//     totalProductsInCart = json['total_products_in_cart'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['product_id'] = this.productId;
//     data['grocery_id'] = this.groceryId;
//     data['status'] = this.status;
//     data['order_id'] = this.orderId;
//     data['bucket'] = this.bucket;
//     data['coupon_id'] = this.couponId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.decodedAttribute != null) {
//       data['decoded_attribute'] = this.decodedAttribute!.toJson();
//     }
//     data['regular_price'] = this.regularPrice;
//     data['save_amount'] = this.saveAmount;
//     data['delivery_charge'] = this.deliveryCharge;
//     data['total_price'] = this.totalPrice;
//     data['coupon_discount'] = this.couponDiscount;
//     data['grand_total_price'] = this.grandTotalPrice;
//     data['total_products_in_cart'] = this.totalProductsInCart;
//     return data;
//   }
// }
//
// class DecodedAttribute {
//   String? vendorId;
//   List<Bucket>? bucket;
//
//   DecodedAttribute({this.vendorId, this.bucket});
//
//   DecodedAttribute.fromJson(Map<String, dynamic> json) {
//     vendorId = json['vendor_id'];
//     if (json['bucket'] != null) {
//       bucket = <Bucket>[];
//       json['bucket'].forEach((v) {
//         bucket!.add(new Bucket.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['vendor_id'] = this.vendorId;
//     if (this.bucket != null) {
//       data['bucket'] = this.bucket!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Bucket {
//   int? productId;
//   int? quantity;
//   String? price;
//   Rx<bool> isSelectedLoading = false.obs;
//   String? checked;
//   int? count;
//   String? productName;
//   int? categoryId;
//   String? categoryName;
//   String? productImage;
//   String? totalPrice;
//   Rx<bool> isLoading = false.obs;
//   Rx<bool> isDelete = false.obs;
//
//   Bucket(
//       {this.productId,
//         this.quantity,
//         this.price,
//         this.checked,
//         this.count,
//         this.productName,
//         this.categoryId,
//         this.categoryName,
//         this.productImage,
//         this.totalPrice});
//
//   Bucket.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id'];
//     quantity = json['quantity'];
//     price = json['price'];
//     checked = json['checked'];
//     count = json['count'];
//     productName = json['product_name'];
//     categoryId = json['category_id'];
//     categoryName = json['category_name'];
//     productImage = json['product_image'];
//     totalPrice = json['total_price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['product_id'] = this.productId;
//     data['quantity'] = this.quantity;
//     data['price'] = this.price;
//     data['checked'] = this.checked;
//     data['count'] = this.count;
//     data['product_name'] = this.productName;
//     data['category_id'] = this.categoryId;
//     data['category_name'] = this.categoryName;
//     data['product_image'] = this.productImage;
//     data['total_price'] = this.totalPrice;
//     return data;
//   }
// }
//
// class Address {
//   int? id;
//   int? userId;
//   String? fullName;
//   String? phoneNumber;
//   String? countryCode;
//   String? houseDetails;
//   String? address;
//   String? addressType;
//   int? isDefault;
//   String? latitude;
//   String? longitude;
//   Null? deliveryInstruction;
//   String? createdAt;
//   String? updatedAt;
//
//   Address(
//       {this.id,
//         this.userId,
//         this.fullName,
//         this.phoneNumber,
//         this.countryCode,
//         this.houseDetails,
//         this.address,
//         this.addressType,
//         this.isDefault,
//         this.latitude,
//         this.longitude,
//         this.deliveryInstruction,
//         this.createdAt,
//         this.updatedAt});
//
//   Address.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     fullName = json['full_name'];
//     phoneNumber = json['phone_number'];
//     countryCode = json['country_code'];
//     houseDetails = json['house_details'];
//     address = json['address'];
//     addressType = json['address_type'];
//     isDefault = json['is_default'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     deliveryInstruction = json['delivery_instruction'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['full_name'] = this.fullName;
//     data['phone_number'] = this.phoneNumber;
//     data['country_code'] = this.countryCode;
//     data['house_details'] = this.houseDetails;
//     data['address'] = this.address;
//     data['address_type'] = this.addressType;
//     data['is_default'] = this.isDefault;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['delivery_instruction'] = this.deliveryInstruction;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Coupons {
//   int? id;
//   String? couponType;
//   String? title;
//   String? code;
//   String? discountType;
//   String? discountAmount;
//   String? expireDate;
//   String? expiryStatus;
//
//   Coupons(
//       {this.id,
//         this.couponType,
//         this.title,
//         this.code,
//         this.discountType,
//         this.discountAmount,
//         this.expireDate,
//         this.expiryStatus});
//
//   Coupons.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     couponType = json['coupon_type'];
//     title = json['title'];
//     code = json['code'];
//     discountType = json['discount_type'];
//     discountAmount = json['discount_amount'];
//     expireDate = json['expire_date'];
//     expiryStatus = json['expiry_status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['coupon_type'] = this.couponType;
//     data['title'] = this.title;
//     data['code'] = this.code;
//     data['discount_type'] = this.discountType;
//     data['discount_amount'] = this.discountAmount;
//     data['expire_date'] = this.expireDate;
//     data['expiry_status'] = this.expiryStatus;
//     return data;
//   }
// }




class SingleVendorGroceryCart {
  bool? status;
  String? message;
  Cart? cart;
  List<Coupons>? coupons;
  String? wallet;
  Address? address;
  bool? addressExists;
  String? cartContent;

  SingleVendorGroceryCart(
      {this.status,
        this.message,
        this.cart,
        this.coupons,
        this.wallet,
        this.address,
        this.addressExists,
        this.cartContent});

  SingleVendorGroceryCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(Coupons.fromJson(v));
      });
    }
    wallet = json['wallet']?.toString();
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    addressExists = json['address_exists'];
    cartContent = json['cartContent']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (cart != null) {
      data['cart'] = cart!.toJson();
    }
    if (coupons != null) {
      data['coupons'] = coupons!.map((v) => v.toJson()).toList();
    }
    data['wallet'] = wallet;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['address_exists'] = addressExists;
    data['cartContent'] = cartContent;
    return data;
  }
}

class Cart {
  String? cartId;
  String? subtotal;
  String? couponDiscount;
  String? deliveryCharge;
  String? finalTotal;
  bool? couponApplied;
  AppliedCouponCode? appliedCoupon;
  Raw? raw;

  Cart(
      {this.cartId,
        this.subtotal,
        this.couponDiscount,
        this.deliveryCharge,
        this.finalTotal,
        this.couponApplied,
        this.appliedCoupon,
        this.raw});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id']?.toString();
    subtotal = json['subtotal']?.toString();
    couponDiscount = json['coupon_discount']?.toString();
    deliveryCharge = json['delivery_charge']?.toString();
    finalTotal = json['final_total']?.toString();
    couponApplied = json['coupon_applied'];
    appliedCoupon = json['applied_coupon'] != null
        ? AppliedCouponCode.fromJson(json['applied_coupon'])
        : null;    raw = json['raw'] != null ? Raw.fromJson(json['raw']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['subtotal'] = subtotal;
    data['coupon_discount'] = couponDiscount;
    data['delivery_charge'] = deliveryCharge;
    data['final_total'] = finalTotal;
    data['coupon_applied'] = couponApplied;
    if (appliedCoupon != null) {
      data['applied_coupon'] = appliedCoupon!.toJson();
    }    if (raw != null) {
      data['raw'] = raw!.toJson();
    }
    return data;
  }
}

class Raw {
  String? id;
  String? userId;
  String? productId;
  String? restoId;
  String? pharmaId;
  String? status;
  String? orderId;
  String? bucket;
  String? orderType;
  String? couponId;
  String? createdAt;
  String? updatedAt;
  DecodedAttribute? decodedAttribute;
  String? regularPrice;
  String? saveAmount;
  String? deliveryCharge;
  String? totalPrice;
  String? grandTotalPrice;
  String? totalProductsInCart;

  Raw(
      {this.id,
        this.userId,
        this.productId,
        this.restoId,
        this.pharmaId,
        this.status,
        this.orderId,
        this.bucket,
        this.orderType,
        this.couponId,
        this.createdAt,
        this.updatedAt,
        this.decodedAttribute,
        this.regularPrice,
        this.saveAmount,
        this.deliveryCharge,
        this.totalPrice,
        this.grandTotalPrice,
        this.totalProductsInCart});

  Raw.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    userId = json['user_id']?.toString();
    productId = json['product_id']?.toString();
    restoId = json['resto_id']?.toString();
    pharmaId = json['pharma_id']?.toString();
    status = json['status']?.toString();
    orderId = json['order_id']?.toString();
    bucket = json['bucket']?.toString();
    orderType = json['order_type']?.toString();
    couponId = json['coupon_id']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    decodedAttribute = json['decoded_attribute'] != null
        ? DecodedAttribute.fromJson(json['decoded_attribute'])
        : null;
    regularPrice = json['regular_price']?.toString();
    saveAmount = json['save_amount']?.toString();
    deliveryCharge = json['delivery_charge']?.toString();
    totalPrice = json['total_price']?.toString();
    grandTotalPrice = json['grand_total_price']?.toString();
    totalProductsInCart = json['total_products_in_cart']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['resto_id'] = restoId;
    data['pharma_id'] = pharmaId;
    data['status'] = status;
    data['order_id'] = orderId;
    data['bucket'] = bucket;
    data['order_type'] = orderType;
    data['coupon_id'] = couponId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (decodedAttribute != null) {
      data['decoded_attribute'] = decodedAttribute!.toJson();
    }
    data['regular_price'] = regularPrice;
    data['save_amount'] = saveAmount;
    data['delivery_charge'] = deliveryCharge;
    data['total_price'] = totalPrice;
    data['grand_total_price'] = grandTotalPrice;
    data['total_products_in_cart'] = totalProductsInCart;
    return data;
  }
}

class DecodedAttribute {
  String? vendorId;
  List<Bucket>? bucket;

  DecodedAttribute({this.vendorId, this.bucket});

  DecodedAttribute.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id']?.toString();
    if (json['bucket'] != null) {
      bucket = <Bucket>[];
      json['bucket'].forEach((v) {
        bucket!.add(Bucket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vendor_id'] = vendorId;
    if (bucket != null) {
      data['bucket'] = bucket!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bucket {
  String? productId;
  String? quantity;
  String? price;
  List<dynamic>? addons;
  List<dynamic>? attribute;
  String? checked;
  String? count;
  String? productName;
  String? categoryId;
  String? categoryName;
  String? productImage;
  String? status;
  List<dynamic>? addonName;
  String? totalPrice;
  Rx<bool> isSelectedLoading = false.obs;
  Rx<bool> isLoading = false.obs;

  Bucket(
      {this.productId,
        this.quantity,
        this.price,
        this.addons,
        this.attribute,
        this.checked,
        this.count,
        this.productName,
        this.categoryId,
        this.categoryName,
        this.productImage,
        this.status,
        this.addonName,
        this.totalPrice});

  Bucket.fromJson(Map<String, dynamic> json) {
    productId = json['product_id']?.toString();
    quantity = json['quantity']?.toString();
    price = json['price']?.toString();
    if (json['addons'] != null) {
      addons = <Null>[];
      json['addons'].forEach((v) {
        // addons!.add(new Null.fromJson(v));
      });
    }
    if (json['attribute'] != null) {
      attribute = <Null>[];
      json['attribute'].forEach((v) {
        // attribute!.add(new Null.fromJson(v));
      });
    }
    checked = json['checked']?.toString();
    count = json['count']?.toString();
    productName = json['product_name']?.toString();
    categoryId = json['category_id']?.toString();
    categoryName = json['category_name']?.toString();
    productImage = json['product_image']?.toString();
    status = json['status']?.toString();

    if (json['addon_name'] != null) {
      addonName = <Null>[];
      json['addon_name'].forEach((v) {
        // addonName!.add(new Null.fromJson(v));
      });
    }
    totalPrice = json['total_price']?.toString();
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
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['product_image'] = productImage;
    data['status'] = status;
    if (addonName != null) {
      data['addon_name'] = addonName!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = totalPrice;
    return data;
  }
}

class Coupons {
  String? id;
  String? couponType;
  String? title;
  String? code;
  String? value;
  String? minSpend;
  String? category;
  List<String>? vendorId;
  String? geoZone;
  String? latitude;
  String? longitude;
  String? itemQuantity;
  String? minOrders;
  String? startDate;
  String? expireDate;
  String? status;

  Coupons(
      {this.id,
        this.couponType,
        this.title,
        this.code,
        this.value,
        this.minSpend,
        this.category,
        this.vendorId,
        this.geoZone,
        this.latitude,
        this.longitude,
        this.itemQuantity,
        this.minOrders,
        this.startDate,
        this.expireDate,
        this.status});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    couponType = json['coupon_type']?.toString();
    title = json['title']?.toString();
    code = json['code']?.toString();
    value = json['value']?.toString();
    minSpend = json['min_spend']?.toString();
    category = json['category']?.toString();
    vendorId = json['vendor_id'].cast<String>();
    geoZone = json['geo_zone']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    itemQuantity = json['item_quantity']?.toString();
    minOrders = json['min_orders']?.toString();
    startDate = json['start_date']?.toString();
    expireDate = json['expire_date']?.toString();
    status = json['status']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['coupon_type'] = couponType;
    data['title'] = title;
    data['code'] = code;
    data['value'] = value;
    data['min_spend'] = minSpend;
    data['category'] = category;
    data['vendor_id'] = vendorId;
    data['geo_zone'] = geoZone;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['item_quantity'] = itemQuantity;
    data['min_orders'] = minOrders;
    data['start_date'] = startDate;
    data['expire_date'] = expireDate;
    data['status'] = status;
    return data;
  }
}

class Address {
  String? id;
  String? userId;
  String? fullName;
  String? phoneNumber;
  String? countryCode;
  String? houseDetails;
  String? address;
  String? addressType;
  String? isDefault;
  String? latitude;
  String? longitude;
  String? deliveryInstruction;
  String? createdAt;
  String? updatedAt;

  Address(
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

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    userId = json['user_id']?.toString();
    fullName = json['full_name']?.toString();
    phoneNumber = json['phone_number']?.toString();
    countryCode = json['country_code']?.toString();
    houseDetails = json['house_details']?.toString();
    address = json['address']?.toString();
    addressType = json['address_type']?.toString();
    isDefault = json['is_default']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    deliveryInstruction = json['delivery_instruction']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

class AppliedCouponCode {
  String? id;
  String? couponType;
  String? title;
  String? code;
  String? discountType;
  String? value;
  String? minSpend;
  String? category;
  List<String>? vendorId;
  String? geoZone;
  String? latitude;
  String? longitude;
  String? itemQuantity;
  String? minOrders;
  String? startDate;
  String? expireDate;
  String? status;
  String? createdAt;
  String? updatedAt;

  AppliedCouponCode(
      {this.id,
        this.couponType,
        this.title,
        this.code,
        this.discountType,
        this.value,
        this.minSpend,
        this.category,
        this.vendorId,
        this.geoZone,
        this.latitude,
        this.longitude,
        this.itemQuantity,
        this.minOrders,
        this.startDate,
        this.expireDate,
        this.status,
        this.createdAt,
        this.updatedAt});

  AppliedCouponCode.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    couponType = json['coupon_type']?.toString();
    title = json['title']?.toString();
    code = json['code']?.toString();
    discountType = json['discount_type']?.toString();
    value = json['value']?.toString();
    minSpend = json['min_spend']?.toString();
    category = json['category']?.toString();
    vendorId = json['vendor_id'].cast<String>();
    geoZone = json['geo_zone']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    itemQuantity = json['item_quantity']?.toString();
    minOrders = json['min_orders']?.toString();
    startDate = json['start_date']?.toString();
    expireDate = json['expire_date']?.toString();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['coupon_type'] = couponType;
    data['title'] = title;
    data['code'] = code;
    data['discount_type'] = discountType;
    data['value'] = value;
    data['min_spend'] = minSpend;
    data['category'] = category;
    data['vendor_id'] = vendorId;
    data['geo_zone'] = geoZone;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['item_quantity'] = itemQuantity;
    data['min_orders'] = minOrders;
    data['start_date'] = startDate;
    data['expire_date'] = expireDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
