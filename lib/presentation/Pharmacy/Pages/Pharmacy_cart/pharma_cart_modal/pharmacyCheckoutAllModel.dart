// import 'package:get/get.dart';
//
// class PharmacyCheckOutAllModel {
//   bool? status;
//   String? message;
//   Cart? cart;
//   bool? couponApplied;
//   AppliedCouponCode? appliedCoupon;
//   String? wallet;
//   Address? address;
//   List<Coupons>? coupons;
//   String? prescription;
//   bool? addressExists;
//   String? cartContent;
//
//   PharmacyCheckOutAllModel(
//       {this.status,
//         this.message,
//         this.cart,
//         this.couponApplied,
//         this.appliedCoupon,
//         this.wallet,
//         this.address,
//         this.coupons,
//         this.prescription,
//         this.addressExists,
//         this.cartContent});
//
//   PharmacyCheckOutAllModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message']?.toString();
//     cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
//     couponApplied = json['coupon_applied'];
//     if (json['applied_coupon'] != null) {
//       appliedCoupon = (json['applied_coupon'] != null ? AppliedCouponCode.fromJson(json['applied_coupon']) : null)!;
//     }
//     wallet = json['wallet']?.toString();
//     json['address'] != null ? Address.fromJson(json['address']) : null;
//
//     if (json['coupons'] != null) {
//       coupons = <Coupons>[];
//       json['coupons'].forEach((v) {
//         coupons!.add(Coupons.fromJson(v));
//       });
//     }
//     prescription = json['prescription']?.toString();
//     addressExists = json['address_exists'];
//     cartContent = json['cartContent']?.toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (cart != null) {
//       data['cart'] = cart!.toJson();
//     }
//     if (appliedCoupon != null) {
//       data['appliedCoupon'] = appliedCoupon!.toJson();
//     }
//     data['wallet'] = wallet;
//     data['coupon_applied'] = couponApplied;
//     if (address != null) {
//       data['address'] = address!.toJson();
//     }
//     if (coupons != null) {
//       data['coupons'] = coupons!.map((v) => v.toJson()).toList();
//     }
//     data['prescription'] = prescription;
//     data['address_exists'] = addressExists;
//     data['cartContent'] = cartContent;
//     return data;
//   }
// }
//
// class Cart {
//   String? regularPrice;
//   String? saveAmount;
//   String? deliveryCharge;
//   String? totalPrice;
//   String? couponDiscount;
//   String? grandTotalPrice;
//   String? totalProductsInCart;
//   List<Buckets>? buckets;
//
//   Cart(
//       {this.regularPrice,
//         this.saveAmount,
//         this.deliveryCharge,
//         this.totalPrice,
//         this.couponDiscount,
//         this.grandTotalPrice,
//         this.totalProductsInCart,
//         this.buckets});
//
//   Cart.fromJson(Map<String, dynamic> json) {
//     regularPrice = json['regular_price']?.toString();
//     saveAmount = json['save_amount']?.toString();
//     deliveryCharge = json['delivery_charge']?.toString();
//     totalPrice = json['total_price']?.toString();
//     couponDiscount = json['coupon_discount']?.toString();
//     grandTotalPrice = json['grand_total_price']?.toString();
//     totalProductsInCart = json['total_products_in_cart']?.toString();
//     if (json['buckets'] != null) {
//       buckets = <Buckets>[];
//       json['buckets'].forEach((v) {
//         buckets!.add(Buckets.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['regular_price'] = regularPrice;
//     data['save_amount'] = saveAmount;
//     data['delivery_charge'] = deliveryCharge;
//     data['total_price'] = totalPrice;
//     data['coupon_discount'] = couponDiscount;
//     data['grand_total_price'] = grandTotalPrice;
//     data['total_products_in_cart'] = totalProductsInCart;
//     if (buckets != null) {
//       data['buckets'] = buckets!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Buckets {
//   String? pharmaId;
//   List<Bucket>? bucket;
//   String? cartId;
//   String? vendorName;
//   String? vendorImage;
//   String? vendorAddress;
//   String? specificTotalPrice;
//   String? specificDeliveryCharge;
//   String? grandtotalPrice;
//   String? orderType;
//   Rx<bool> isVendorDelete = false.obs;
//   Rx<bool> isChecked = false.obs;
//   Rx<bool> isDelivery = true.obs;
//
//   Buckets(
//       {this.pharmaId,
//         this.bucket,
//         this.cartId,
//         this.vendorName,
//         this.vendorImage,
//         this.vendorAddress,
//         this.specificTotalPrice,
//         this.specificDeliveryCharge,
//         this.grandtotalPrice,
//         this.orderType,
//       });
//
//   Buckets.fromJson(Map<String, dynamic> json) {
//     pharmaId = json['pharma_id']?.toString() ;
//     if (json['bucket'] != null) {
//       bucket = <Bucket>[];
//       json['bucket'].forEach((v) {
//         bucket!.add(Bucket.fromJson(v));
//       });
//     }
//     cartId = json['cart_id']?.toString();
//     vendorName = json['vendor_name']?.toString();
//     vendorImage = json['vendor_image']?.toString();
//     vendorAddress = json['vendor_address']?.toString();
//     specificTotalPrice = json['specific_total_price']?.toString();
//     specificDeliveryCharge = json['specific_delivery_charge']?.toString();
//     grandtotalPrice = json['grandtotal_price']?.toString();
//     orderType = json['order_type']?.toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['pharma_id'] = pharmaId;
//     if (bucket != null) {
//       data['bucket'] = bucket!.map((v) => v.toJson()).toList();
//     }
//     data['cart_id'] = cartId;
//     data['vendor_name'] = vendorName;
//     data['vendor_image'] = vendorImage;
//     data['vendor_address'] = vendorAddress;
//     data['specific_total_price'] = specificTotalPrice;
//     data['specific_delivery_charge'] = specificDeliveryCharge;
//     data['grandtotal_price'] = grandtotalPrice;
//     data['order_type'] = orderType;
//     return data;
//   }
// }
//
// class Bucket {
//   String? productId;
//   String? quantity;
//   String? price;
//   String? newPrice;
//   String? checked;
//   String? count;
//   String? productName;
//   String? categoryId;
//   String? categoryName;
//   String? productImage;
//   Rx<bool> isLoading = false.obs;
//   Rx<bool> isDelete = false.obs;
//
//   Bucket(
//       {this.productId,
//         this.quantity,
//         this.price,
//         this.newPrice,
//         this.checked,
//         this.count,
//         this.productName,
//         this.categoryId,
//         this.categoryName,
//         this.productImage});
//
//   Bucket.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id']?.toString();
//     quantity = json['quantity']?.toString();
//     price = json['price']?.toString();
//     newPrice = json['new_price']?.toString();
//     checked = json['checked']?.toString();
//     count = json['count']?.toString();
//     productName = json['product_name']?.toString();
//     categoryId = json['category_id']?.toString();
//     categoryName = json['category_name']?.toString();
//     productImage = json['product_image']?.toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['product_id'] = productId;
//     data['quantity'] = quantity;
//     data['price'] = price;
//     data['new_price'] = newPrice;
//     data['checked'] = checked;
//     data['count'] = count;
//     data['product_name'] = productName;
//     data['category_id'] = categoryId;
//     data['category_name'] = categoryName;
//     data['product_image'] = productImage;
//     return data;
//   }
// }
//
// class Address {
//   String? id;
//   String? userId;
//   String? fullName;
//   String? phoneNumber;
//   String? countryCode;
//   String? houseDetails;
//   String? address;
//   String? addressType;
//   String? isDefault;
//   String? latitude;
//   String? longitude;
//   String? deliveryInstruction;
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
//     id = json['id']?.toString();
//     userId = json['user_id']?.toString();
//     fullName = json['full_name']?.toString();
//     phoneNumber = json['phone_number']?.toString();
//     countryCode = json['country_code']?.toString();
//     houseDetails = json['house_details']?.toString();
//     address = json['address']?.toString();
//     addressType = json['address_type']?.toString();
//     isDefault = json['is_default']?.toString();
//     latitude = json['latitude']?.toString();
//     longitude = json['longitude']?.toString();
//     deliveryInstruction = json['delivery_instruction']?.toString();
//     createdAt = json['created_at']?.toString();
//     updatedAt = json['updated_at']?.toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['full_name'] = fullName;
//     data['phone_number'] = phoneNumber;
//     data['country_code'] = countryCode;
//     data['house_details'] = houseDetails;
//     data['address'] = address;
//     data['address_type'] = addressType;
//     data['is_default'] = isDefault;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['delivery_instruction'] = deliveryInstruction;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
//
// class Coupons {
//   String? id;
//   String? couponType;
//   String? title;
//   String? code;
//   String? discountType;
//   String? discountAmount;
//   String? value;
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
//         this.value,
//         this.expireDate,
//         this.expiryStatus});
//
//   Coupons.fromJson(Map<String, dynamic> json) {
//     id = json['id']?.toString();
//     couponType = json['coupon_type']?.toString();
//     title = json['title']?.toString();
//     code = json['code']?.toString();
//     discountType = json['discount_type']?.toString();
//     discountAmount = json['discount_amount']?.toString();
//     value = json['value']?.toString();
//     expireDate = json['expire_date']?.toString();
//     expiryStatus = json['expiry_status']?.toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['coupon_type'] = couponType;
//     data['title'] = title;
//     data['code'] = code;
//     data['discount_type'] = discountType;
//     data['discount_amount'] = discountAmount;
//     data['value'] = value;
//     data['expire_date'] = expireDate;
//     data['expiry_status'] = expiryStatus;
//     return data;
//   }
// }
import 'package:get/get.dart';

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


class PharmacyCheckOutAllModel {
  bool? status;
  String? message;
  Cart? cart;
  List<Coupons>? coupons;
  bool? couponApplied;
  AppliedCouponCode? appliedCoupon;
  String? wallet;
  Address? address;
  String? prescription;
  bool? addressExists;
  String? cartContent;

  PharmacyCheckOutAllModel(
      {this.status,
        this.message,
        this.cart,
        this.coupons,
        this.couponApplied,
        this.appliedCoupon,
        this.wallet,
        this.address,
        this.prescription,
        this.addressExists,
        this.cartContent});

  PharmacyCheckOutAllModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(Coupons.fromJson(v));
      });
    }
    couponApplied = json['coupon_applied'];
    if(json['applied_coupon'] != null) {
      appliedCoupon = json['applied_coupon'] != null
          ? AppliedCouponCode.fromJson(json['applied_coupon'])
          : null;
    }
    wallet = json['wallet'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    prescription = json['prescription']?.toString();
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
    data['coupon_applied'] = couponApplied;
    if (appliedCoupon != null) {
      data['applied_coupon'] = appliedCoupon!.toJson();
    }
    data['wallet'] = wallet;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['prescription'] = prescription;
    data['address_exists'] = addressExists;
    data['cartContent'] = cartContent;
    return data;
  }
}

class Cart {
  String? regularPrice;
  String? saveAmount;
  String? deliveryCharge;
  String? totalPrice;
  String? couponDiscount;
  String? grandTotalPrice;
  String? totalProductsInCart;
  List<int>? pres;
  List<Buckets>? buckets;

  Cart(
      {this.regularPrice,
        this.saveAmount,
        this.deliveryCharge,
        this.totalPrice,
        this.couponDiscount,
        this.grandTotalPrice,
        this.totalProductsInCart,
        this.pres,
        this.buckets});

  Cart.fromJson(Map<String, dynamic> json) {
    regularPrice = json['regular_price']?.toString();
    saveAmount = json['save_amount']?.toString();
    deliveryCharge = json['delivery_charge']?.toString();
    totalPrice = json['total_price']?.toString();
    couponDiscount = json['coupon_discount']?.toString();
    grandTotalPrice = json['grand_total_price']?.toString();
    totalProductsInCart = json['total_products_in_cart']?.toString();
    pres = json['pres'].cast<int>();
    if (json['buckets'] != null) {
      buckets = <Buckets>[];
      json['buckets'].forEach((v) {
        buckets!.add(Buckets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regular_price'] = regularPrice;
    data['save_amount'] = saveAmount;
    data['delivery_charge'] = deliveryCharge;
    data['total_price'] = totalPrice;
    data['coupon_discount'] = couponDiscount;
    data['grand_total_price'] = grandTotalPrice;
    data['total_products_in_cart'] = totalProductsInCart;
    data['pres'] = pres;
    if (buckets != null) {
      data['buckets'] = buckets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Buckets {
  String? pharmaId;
  List<Bucket>? bucket;
  String? cartId;
  String? orderType;
  String? vendorName;
  String? vendorImage;
  String? vendorAddress;
  String? specificTotalPrice;
  String? specificDeliveryCharge;
  String? couponDiscount;
  String? finalTotal;
  String? grandtotalPrice;
  Rx<bool> isVendorDelete = false.obs;
  Rx<bool> isChecked = false.obs;
  Rx<bool> isDelivery = true.obs;

  Buckets(
      {this.pharmaId,
        this.bucket,
        this.cartId,
        this.orderType,
        this.vendorName,
        this.vendorImage,
        this.vendorAddress,
        this.specificTotalPrice,
        this.specificDeliveryCharge,
        this.couponDiscount,
        this.finalTotal,
        this.grandtotalPrice});

  Buckets.fromJson(Map<String, dynamic> json) {
    pharmaId = json['pharma_id']?.toString();
    if (json['bucket'] != null) {
      bucket = <Bucket>[];
      json['bucket'].forEach((v) {
        bucket!.add(Bucket.fromJson(v));
      });
    }
    cartId = json['cart_id']?.toString();
    orderType = json['order_type']?.toString();
    vendorName = json['vendor_name']?.toString();
    vendorImage = json['vendor_image']?.toString();
    vendorAddress = json['vendor_address']?.toString();
    specificTotalPrice = json['specific_total_price']?.toString();
    specificDeliveryCharge = json['specific_delivery_charge']?.toString();
    couponDiscount = json['coupon_discount']?.toString();
    finalTotal = json['final_total']?.toString();
    grandtotalPrice = json['grandtotal_price']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pharma_id'] = pharmaId;
    if (bucket != null) {
      data['bucket'] = bucket!.map((v) => v.toJson()).toList();
    }
    data['cart_id'] = cartId;
    data['order_type'] = orderType;
    data['vendor_name'] = vendorName;
    data['vendor_image'] = vendorImage;
    data['vendor_address'] = vendorAddress;
    data['specific_total_price'] = specificTotalPrice;
    data['specific_delivery_charge'] = specificDeliveryCharge;
    data['coupon_discount'] = couponDiscount;
    data['final_total'] = finalTotal;
    data['grandtotal_price'] = grandtotalPrice;
    return data;
  }
}

class Bucket {
  String? productId;
  String? quantity;
  String? price;
  String? checked;
  String? count;
  String? newPrice;
  String? productName;
  String? categoryId;
  String? categoryName;
  String? productImage;
  String? productTotalPrice;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isDelete = false.obs;

  Bucket(
      {this.productId,
        this.quantity,
        this.price,
        this.checked,
        this.count,
        this.newPrice,
        this.productName,
        this.categoryId,
        this.categoryName,
        this.productImage,
        this.productTotalPrice,
      });

  Bucket.fromJson(Map<String, dynamic> json) {
    productId = json['product_id']?.toString();
    quantity = json['quantity']?.toString();
    price = json['price']?.toString();
    checked = json['checked']?.toString();
    count = json['count']?.toString();
    newPrice = json['new_price']?.toString();
    productName = json['product_name']?.toString();
    categoryId = json['category_id']?.toString();
    categoryName = json['category_name']?.toString();
    productImage = json['product_image']?.toString();
    productTotalPrice = json['product_total_price']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['checked'] = checked;
    data['count'] = count;
    data['new_price'] = newPrice;
    data['product_name'] = productName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['product_image'] = productImage;
    data['product_total_price'] = productTotalPrice;
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
