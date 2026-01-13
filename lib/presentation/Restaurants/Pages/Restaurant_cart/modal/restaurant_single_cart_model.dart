
import 'package:get/get.dart';

class Addons {
  String? id;
  String? price;
  String? name;

  Addons({this.id, this.price, this.name});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    price = json['price']?.toString();
    name = json['name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
        ? ItemDetails.fromJson(json['item_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  int? itemPrice;

  ItemDetails({this.itemId, this.itemName, this.itemPrice});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id']?.toString();
    itemName = json['item_name']?.toString();
    itemPrice = json['item_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['item_name'] = itemName;
    data['item_price'] = itemPrice;
    return data;
  }
}

//////////////////////////////////

class RestaurantSingleCartModel {
  bool? status;
  String? message;
  Cart? cart;
  List<Coupons>? coupons;
  String? wallet;
  Address? address;
  bool? addressExists;
  String? cartContent;

  RestaurantSingleCartModel(
      {this.status,
        this.message,
        this.cart,
        this.coupons,
        this.wallet,
        this.address,
        this.addressExists,
        this.cartContent});

  RestaurantSingleCartModel.fromJson(Map<String, dynamic> json) {
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
  Rx<bool> isDelivery = true.obs;

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
  List<Addons>? addons;
  List<Attribute>? attribute;
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
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add( Addons.fromJson(v));
      });
    }
    if (json['attribute'] != null) {
      attribute = <Attribute>[];
      json['attribute'].forEach((v) {
        attribute!.add( Attribute.fromJson(v));
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
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name']?.toString();
    phoneNumber = json['phone_number']?.toString();
    countryCode = json['country_code']?.toString();
    houseDetails = json['house_details']?.toString();
    address = json['address']?.toString();
    addressType = json['address_type']?.toString();
    isDefault = json['is_default'];
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
