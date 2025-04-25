class PharmacyCheckOutAllModel {
  bool? status;
  String? message;
  Cart? cart;
  String? wallet;
  Address? address;
  List<Coupons>? coupons;
  bool? addressExists;
  String? cartContent;

  PharmacyCheckOutAllModel(
      {this.status,
        this.message,
        this.cart,
        this.wallet,
        this.address,
        this.coupons,
        this.addressExists,
        this.cartContent});

  PharmacyCheckOutAllModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    wallet = json['wallet'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(Coupons.fromJson(v));
      });
    }
    addressExists = json['address_exists'];
    cartContent = json['cartContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (cart != null) {
      data['cart'] = cart!.toJson();
    }
    data['wallet'] = wallet;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (coupons != null) {
      data['coupons'] = coupons!.map((v) => v.toJson()).toList();
    }
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
  int? totalProductsInCart;
  List<Buckets>? buckets;

  Cart(
      {this.regularPrice,
        this.saveAmount,
        this.deliveryCharge,
        this.totalPrice,
        this.couponDiscount,
        this.grandTotalPrice,
        this.totalProductsInCart,
        this.buckets});

  Cart.fromJson(Map<String, dynamic> json) {
    regularPrice = json['regular_price'];
    saveAmount = json['save_amount'];
    deliveryCharge = json['delivery_charge'];
    totalPrice = json['total_price'];
    couponDiscount = json['coupon_discount'];
    grandTotalPrice = json['grand_total_price'];
    totalProductsInCart = json['total_products_in_cart'];
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
    if (buckets != null) {
      data['buckets'] = buckets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Buckets {
  String? pharmaId;
  List<Bucket>? bucket;
  int? cartId;
  String? vendorName;
  String? vendorImage;
  String? vendorAddress;
  String? specificTotalPrice;
  String? specificDeliveryCharge;
  String? grandtotalPrice;

  Buckets(
      {this.pharmaId,
        this.bucket,
        this.cartId,
        this.vendorName,
        this.vendorImage,
        this.vendorAddress,
        this.specificTotalPrice,
        this.specificDeliveryCharge,
        this.grandtotalPrice});

  Buckets.fromJson(Map<String, dynamic> json) {
    pharmaId = json['pharma_id'];
    if (json['bucket'] != null) {
      bucket = <Bucket>[];
      json['bucket'].forEach((v) {
        bucket!.add(Bucket.fromJson(v));
      });
    }
    cartId = json['cart_id'];
    vendorName = json['vendor_name'];
    vendorImage = json['vendor_image'];
    vendorAddress = json['vendor_address'];
    specificTotalPrice = json['specific_total_price'];
    specificDeliveryCharge = json['specific_delivery_charge'];
    grandtotalPrice = json['grandtotal_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pharma_id'] = pharmaId;
    if (bucket != null) {
      data['bucket'] = bucket!.map((v) => v.toJson()).toList();
    }
    data['cart_id'] = cartId;
    data['vendor_name'] = vendorName;
    data['vendor_image'] = vendorImage;
    data['vendor_address'] = vendorAddress;
    data['specific_total_price'] = specificTotalPrice;
    data['specific_delivery_charge'] = specificDeliveryCharge;
    data['grandtotal_price'] = grandtotalPrice;
    return data;
  }
}

class Bucket {
  int? productId;
  int? quantity;
  String? price;
  String? checked;
  int? count;
  String? productName;
  int? categoryId;
  String? categoryName;
  String? productImage;

  Bucket(
      {this.productId,
        this.quantity,
        this.price,
        this.checked,
        this.count,
        this.productName,
        this.categoryId,
        this.categoryName,
        this.productImage});

  Bucket.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    checked = json['checked'];
    count = json['count'];
    productName = json['product_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['checked'] = checked;
    data['count'] = count;
    data['product_name'] = productName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['product_image'] = productImage;
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

class Coupons {
  int? id;
  String? couponType;
  String? title;
  String? code;
  String? discountType;
  String? discountAmount;
  String? expireDate;
  String? expiryStatus;

  Coupons(
      {this.id,
        this.couponType,
        this.title,
        this.code,
        this.discountType,
        this.discountAmount,
        this.expireDate,
        this.expiryStatus});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponType = json['coupon_type'];
    title = json['title'];
    code = json['code'];
    discountType = json['discount_type'];
    discountAmount = json['discount_amount'];
    expireDate = json['expire_date'];
    expiryStatus = json['expiry_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['coupon_type'] = couponType;
    data['title'] = title;
    data['code'] = code;
    data['discount_type'] = discountType;
    data['discount_amount'] = discountAmount;
    data['expire_date'] = expireDate;
    data['expiry_status'] = expiryStatus;
    return data;
  }
}
