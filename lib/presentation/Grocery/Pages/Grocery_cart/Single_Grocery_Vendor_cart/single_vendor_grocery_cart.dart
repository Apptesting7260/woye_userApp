import 'package:get/get.dart';

class SingleVendorGroceryCart {
  bool? status;
  String? message;
  Cart? cart;
  var wallet;
  Address? address;
  List<Coupons>? coupons;
  bool? addressExists;
  String? cartContent;

  SingleVendorGroceryCart(
      {this.status,
        this.message,
        this.cart,
        this.wallet,
        this.address,
        this.coupons,
        this.addressExists,
        this.cartContent});

  SingleVendorGroceryCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    wallet = json['wallet'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(new Coupons.fromJson(v));
      });
    }
    addressExists = json['address_exists'];
    cartContent = json['cartContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    data['wallet'] = this.wallet;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.coupons != null) {
      data['coupons'] = this.coupons!.map((v) => v.toJson()).toList();
    }
    data['address_exists'] = this.addressExists;
    data['cartContent'] = this.cartContent;
    return data;
  }
}

class Cart {
  int? id;
  int? userId;
  var productId;
  int? groceryId;
  String? status;
  var orderId;
  String? bucket;
  var couponId;
  String? createdAt;
  String? updatedAt;
  DecodedAttribute? decodedAttribute;
  var regularPrice;
  var saveAmount;
 var deliveryCharge;
  var totalPrice;
  var couponDiscount;
  var grandTotalPrice;
  var totalProductsInCart;

  Cart(
      {this.id,
        this.userId,
        this.productId,
        this.groceryId,
        this.status,
        this.orderId,
        this.bucket,
        this.couponId,
        this.createdAt,
        this.updatedAt,
        this.decodedAttribute,
        this.regularPrice,
        this.saveAmount,
        this.deliveryCharge,
        this.totalPrice,
        this.couponDiscount,
        this.grandTotalPrice,
        this.totalProductsInCart});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    groceryId = json['grocery_id'];
    status = json['status'];
    orderId = json['order_id'];
    bucket = json['bucket'];
    couponId = json['coupon_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    decodedAttribute = json['decoded_attribute'] != null
        ? new DecodedAttribute.fromJson(json['decoded_attribute'])
        : null;
    regularPrice = json['regular_price'];
    saveAmount = json['save_amount'];
    deliveryCharge = json['delivery_charge'];
    totalPrice = json['total_price'];
    couponDiscount = json['coupon_discount'];
    grandTotalPrice = json['grand_total_price'];
    totalProductsInCart = json['total_products_in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['grocery_id'] = this.groceryId;
    data['status'] = this.status;
    data['order_id'] = this.orderId;
    data['bucket'] = this.bucket;
    data['coupon_id'] = this.couponId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.decodedAttribute != null) {
      data['decoded_attribute'] = this.decodedAttribute!.toJson();
    }
    data['regular_price'] = this.regularPrice;
    data['save_amount'] = this.saveAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['total_price'] = this.totalPrice;
    data['coupon_discount'] = this.couponDiscount;
    data['grand_total_price'] = this.grandTotalPrice;
    data['total_products_in_cart'] = this.totalProductsInCart;
    return data;
  }
}

class DecodedAttribute {
  String? vendorId;
  List<Bucket>? bucket;

  DecodedAttribute({this.vendorId, this.bucket});

  DecodedAttribute.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    if (json['bucket'] != null) {
      bucket = <Bucket>[];
      json['bucket'].forEach((v) {
        bucket!.add(new Bucket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    if (this.bucket != null) {
      data['bucket'] = this.bucket!.map((v) => v.toJson()).toList();
    }
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
  String? totalPrice;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isDelete = false.obs;

  Bucket(
      {this.productId,
        this.quantity,
        this.price,
        this.checked,
        this.count,
        this.productName,
        this.categoryId,
        this.categoryName,
        this.productImage,
        this.totalPrice});

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
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['checked'] = this.checked;
    data['count'] = this.count;
    data['product_name'] = this.productName;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['product_image'] = this.productImage;
    data['total_price'] = this.totalPrice;
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
  Null? deliveryInstruction;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupon_type'] = this.couponType;
    data['title'] = this.title;
    data['code'] = this.code;
    data['discount_type'] = this.discountType;
    data['discount_amount'] = this.discountAmount;
    data['expire_date'] = this.expireDate;
    data['expiry_status'] = this.expiryStatus;
    return data;
  }
}
