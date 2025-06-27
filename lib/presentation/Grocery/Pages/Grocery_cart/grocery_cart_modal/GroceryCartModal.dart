import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GroceryCartModal {
  bool? status;
  Cart? cart;
  String? message;
  String? cartContent;
  Address? address;
  bool? addressExists;
  List<Coupon>? coupons;
  var wallet;

  GroceryCartModal({
    this.status,
    this.cart,
    this.message,
    this.cartContent,
    this.address,
    this.addressExists,
    this.coupons,
    this.wallet,
  });
  factory GroceryCartModal.fromJson(Map<String, dynamic> json) {
    var cartData = json['cart'];
    var addressData = json['address'];
    var couponData = json['coupons'] as List?;

    return GroceryCartModal(
      status: json['status'],
      message: json['message'],
      cart: cartData != null ? Cart.fromJson(cartData) : null,
      cartContent: json['cartContent'],
      address: addressData != null ? Address.fromJson(addressData) : null,
      addressExists: json['address_exists'],
      coupons: couponData != null
          ? couponData.map((coupon) => Coupon.fromJson(coupon)).toList()
          : [],
      wallet: json['wallet'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'cart': cart?.toJson(),
      'cartContent': cartContent,
      'address': address?.toJson(),
      'address_exists': addressExists,
      'coupons': coupons?.map((e) => e.toJson()).toList() ?? [],
      'wallet': wallet,
    };
  }
}

class Cart {
  var regularPrice;
  var saveAmount;
  var deliveryCharge;
  var totalPrice;
  var couponDiscount;
  var grandTotalPrice;
  var totalProductsInCart;
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
        buckets!.add(new Buckets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  String? vendorId;
  List<Bucket>? bucket;
  String? vendorName;
  String? vendorImage;
  String? vendorAddress;
  int? cartId;
  String? specificTotalPrice;
  String? specificDeliveryCharge;
  Rx<bool> isVendorDelete = false.obs;
  Rx<bool> isChecked = false.obs;
  Rx<bool> isDelivery = true.obs;

  Buckets({
    this.vendorId,
    this.bucket,
    this.vendorName,
    this.vendorImage,
    this.vendorAddress,
    this.cartId,
    this.specificTotalPrice,
    this.specificDeliveryCharge,
  });

  Buckets.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    if (json['bucket'] != null) {
      bucket = <Bucket>[];
      json['bucket'].forEach((v) {
        bucket!.add(Bucket.fromJson(v));
      });
    }
    vendorName = json['vendor_name'];
    vendorImage = json['vendor_image'];
    vendorAddress = json['vendor_address'];
    cartId = json['cart_id'];
    specificTotalPrice = json['specific_total_price'];
    specificDeliveryCharge = json['specific_delivery_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = vendorId;
    if (bucket != null) {
      data['bucket'] = bucket!.map((v) => v.toJson()).toList();
    }
    data['vendor_name'] = vendorName;
    data['vendor_image'] = vendorImage;
    data['vendor_address'] = vendorAddress;
    data['cart_id'] = cartId; // Add cart_id to the output JSON
    data['specific_total_price'] = specificTotalPrice;
    data['specific_delivery_charge'] = specificDeliveryCharge;
    return data;
  }
}



class Bucket {
  int? productId;
  int? quantity;
  String? price;
  String? newPrice;
  String? checked;
  int? count;
  String? productName;
  int? categoryId;
  String? categoryName;
  String? productImage;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isDelete = false.obs;

  Bucket(
      {this.productId,
      this.quantity,
      this.price,
      this.newPrice,
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
    newPrice = json['new_price'];
    checked = json['checked'];
    count = json['count'];
    productName = json['product_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['new_price'] = newPrice;
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
  bool? isDefault;
  String? latitude;
  String? longitude;
  String? deliveryInstruction;
  String? createdAt;
  String? updatedAt;

  Address({
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

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      userId: json['user_id'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      countryCode: json['country_code'],
      houseDetails: json['house_details'],
      address: json['address'],
      addressType: json['address_type'],
      isDefault: json['is_default'] == 1,
      latitude: json['latitude'],
      longitude: json['longitude'],
      deliveryInstruction: json['delivery_instruction'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'country_code': countryCode,
      'house_details': houseDetails,
      'address': address,
      'address_type': addressType,
      'is_default': isDefault == true ? 1 : 0,
      'latitude': latitude,
      'longitude': longitude,
      'delivery_instruction': deliveryInstruction,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Coupon {
  int? id;
  String? couponType;
  String? title;
  String? code;
  String? discountType;
  var discountAmount;
  String? expireDate;
  String? expiryStatus;

  Coupon({
    this.id,
    this.couponType,
    this.title,
    this.code,
    this.discountType,
    this.discountAmount,
    this.expireDate,
    this.expiryStatus,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      couponType: json['coupon_type'],
      title: json['title'],
      code: json['code'],
      discountType: json['discount_type'],
      discountAmount: json['discount_amount'],
      expireDate: json['expire_date'],
      expiryStatus: json['expiry_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coupon_type': couponType,
      'title': title,
      'code': code,
      'discount_type': discountType,
      'discount_amount': discountAmount,
      'expire_date': expireDate,
      'expiry_status': expiryStatus,
    };
  }
}