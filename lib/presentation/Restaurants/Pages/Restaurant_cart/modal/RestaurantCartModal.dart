import 'package:get/get.dart';

class RestaurantCartModal {
  bool? status;
  String? message;
  Cart? cart;
  String? cartContent;
  Address? address;
  bool? addressExists;
  List<Coupon>? coupons;

  RestaurantCartModal({
    this.status,
    this.message,
    this.cart,
    this.cartContent,
    this.address,
    this.addressExists,
    this.coupons,
  });

  factory RestaurantCartModal.fromJson(Map<String, dynamic> json) {
    var cartData = json['cart'];
    var addressData = json['address'];
    var couponData = json['coupons'] as List?;

    return RestaurantCartModal(
      status: json['status'],
      message: json['message'],
      cart: cartData != null ? Cart.fromJson(cartData) : null,
      cartContent: json['cartContent'],
      address: addressData != null ? Address.fromJson(addressData) : null,
      addressExists: json['address_exists'],
      coupons: couponData != null
          ? couponData.map((coupon) => Coupon.fromJson(coupon)).toList()
          : [], // Map coupons to a list of Coupon objects
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
      // Add coupons to JSON
    };
  }
}

// class Cart {
//   int? id;
//   int? userId;
//   int? productId;
//   int? restoId;
//   String? status;
//   int? orderId;
//   String? bucket;
//   String? createdAt;
//   String? updatedAt;
//   List<DecodedAttribute>? decodedAttribute;
//   int? regularPrice;
//   int? saveAmount;
//   int? deliveryCharge;
//   int? totalPrice;
//
//   Cart({
//     this.id,
//     this.userId,
//     this.productId,
//     this.restoId,
//     this.status,
//     this.orderId,
//     this.bucket,
//     this.createdAt,
//     this.updatedAt,
//     this.decodedAttribute,
//     this.regularPrice,
//     this.saveAmount,
//     this.deliveryCharge,
//     this.totalPrice,
//   });
//
//   factory Cart.fromJson(Map<String, dynamic> json) {
//     var decodedAttributeList = (json['decoded_attribute'] as List?)
//         ?.map((item) => DecodedAttribute.fromJson(item))
//         .toList();
//
//     return Cart(
//       id: json['id'],
//       userId: json['user_id'],
//       productId: json['product_id'],
//       restoId: json['resto_id'],
//       status: json['status'],
//       orderId: json['order_id'],
//       bucket: json['bucket'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       decodedAttribute: decodedAttributeList ?? [],
//       regularPrice: json['regular_price'],
//       saveAmount: json['save_amount'],
//       deliveryCharge: json['delivery_charge'],
//       totalPrice: json['total_price'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'product_id': productId,
//       'resto_id': restoId,
//       'status': status,
//       'order_id': orderId,
//       'bucket': bucket,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'decoded_attribute':
//           decodedAttribute?.map((e) => e.toJson()).toList() ?? [],
//       'regular_price': regularPrice,
//       'save_amount': saveAmount,
//       'delivery_charge': deliveryCharge,
//       'total_price': totalPrice,
//     };
//   }
// }
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
  int? regularPrice;
  int? saveAmount;
  int? deliveryCharge;
  int? totalPrice;
  int? couponId;
  int? couponDiscount;
  CouponApplied? couponApplied;

  Cart({
    this.id,
    this.userId,
    this.productId,
    this.restoId,
    this.status,
    this.orderId,
    this.bucket,
    this.createdAt,
    this.updatedAt,
    this.decodedAttribute,
    this.regularPrice,
    this.saveAmount,
    this.deliveryCharge,
    this.totalPrice,
    this.couponId,
    this.couponDiscount,
    this.couponApplied,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var decodedAttributeList = (json['decoded_attribute'] as List?)
        ?.map((item) => DecodedAttribute.fromJson(item))
        .toList();

    var couponApplied = json['coupon_applied'] != null
        ? CouponApplied.fromJson(json['coupon_applied'])
        : null;

    return Cart(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      restoId: json['resto_id'],
      status: json['status'],
      orderId: json['order_id'],
      bucket: json['bucket'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      decodedAttribute: decodedAttributeList ?? [],
      regularPrice: json['regular_price'],
      saveAmount: json['save_amount'],
      deliveryCharge: json['delivery_charge'],
      totalPrice: json['total_price'],
      couponId: json['coupon_id'],
      couponDiscount: json['coupon_discount'],
      couponApplied: couponApplied,
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
      'bucket': bucket,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'decoded_attribute':
          decodedAttribute?.map((e) => e.toJson()).toList() ?? [],
      'regular_price': regularPrice,
      'save_amount': saveAmount,
      'delivery_charge': deliveryCharge,
      'total_price': totalPrice,
      'coupon_id': couponId,
      'coupon_discount': couponDiscount,
      'coupon_applied': couponApplied?.toJson(),
    };
  }
}

class CouponApplied {
  int? id;
  String? couponType;
  String? title;
  String? code;
  String? limitForUser;
  String? discountType;
  String? discountAmount;
  String? minPurchase;
  String? maxDiscount;
  String? startDate;
  String? expireDate;
  String? category;
  List<String>? subCategoryId;
  List<String>? productId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? expiryStatus;

  CouponApplied({
    this.id,
    this.couponType,
    this.title,
    this.code,
    // this.limitForUser,
    this.discountType,
    this.discountAmount,
    this.minPurchase,
    this.maxDiscount,
    this.startDate,
    this.expireDate,
    this.category,
    this.subCategoryId,
    this.productId,
    // this.status,
    this.createdAt,
    this.updatedAt,
    this.expiryStatus,
  });

  factory CouponApplied.fromJson(Map<String, dynamic> json) {
    return CouponApplied(
      id: json['id'],
      couponType: json['coupon_type'],
      title: json['title'],
      code: json['code'],
      // limitForUser: json['limit_for_user'],
      discountType: json['discount_type'],
      discountAmount: json['discount_amount'],
      minPurchase: json['min_purchase'],
      maxDiscount: json['max_discount'],
      startDate: json['start_date'],
      expireDate: json['expire_date'],
      category: json['category'],
      subCategoryId: List<String>.from(json['sub_category_id'] ?? []),
      productId: List<String>.from(json['product_id'] ?? []),
      // status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      expiryStatus: json['expiry_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coupon_type': couponType,
      'title': title,
      'code': code,
      // 'limit_for_user': limitForUser,
      'discount_type': discountType,
      'discount_amount': discountAmount,
      'min_purchase': minPurchase,
      'max_discount': maxDiscount,
      'start_date': startDate,
      'expire_date': expireDate,
      'category': category,
      'sub_category_id': subCategoryId,
      'product_id': productId,
      // 'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'expiry_status': expiryStatus,
    };
  }
}

// class DecodedAttribute {
//   String? productId;
//   int? quantity;
//   String? price;
//   List<String>? addons;
//   List<Attribute>? attribute;
//   String? productName;
//   String? productImage;
//   int? totalPrice;
//   List<String>? addonName;
//   Rx<bool> isSelected = true.obs;
//   Rx<bool> isLoading = false.obs;
//   Rx<bool> isDelete = false.obs;
//
//   DecodedAttribute({
//     this.productId,
//     this.quantity,
//     this.price,
//     this.addons,
//     this.attribute,
//     this.productName,
//     this.productImage,
//     this.totalPrice,
//     this.addonName,
//   });
//
//   factory DecodedAttribute.fromJson(Map<String, dynamic> json) {
//     var attributeList = (json['attribute'] as List?)
//         ?.map((item) => Attribute.fromJson(item))
//         .toList();
//
//     return DecodedAttribute(
//       productId: json['product_id'],
//       quantity: json['quantity'],
//       price: json['price'],
//       addons: List<String>.from(json['addons'] ?? []),
//       attribute: attributeList ?? [],
//       productName: json['product_name'],
//       productImage: json['product_image'],
//       totalPrice: json['total_price'],
//       addonName:
//           List<String>.from(json['addon_name'] ?? []), // Handle addon names
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'product_id': productId,
//       'quantity': quantity,
//       'price': price,
//       'addons': addons,
//       'attribute': attribute?.map((e) => e.toJson()).toList() ?? [],
//       'product_name': productName,
//       'product_image': productImage,
//       'total_price': totalPrice,
//       'addon_name': addonName,
//     };
//   }
// }
class DecodedAttribute {
  String? productId;
  int? quantity;
  String? price;
  List<String>? addons;
  List<Attribute>? attribute;
  String? productName;
  String? productImage;
  int? totalPrice;
  List<String>? addonName;
  Rx<bool> isSelectedLoading = false.obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isDelete = false.obs;
  var checked;

  DecodedAttribute({
    this.productId,
    this.quantity,
    this.price,
    this.addons,
    this.attribute,
    this.productName,
    this.productImage,
    this.totalPrice,
    this.addonName,
    this.checked,
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
      productImage: json['product_image'],
      totalPrice: json['total_price'],
      addonName: List<String>.from(json['addon_name'] ?? []),
      checked: json['checked'],
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
      'product_image': productImage,
      'total_price': totalPrice,
      'addon_name': addonName,
      'checked': checked,
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
