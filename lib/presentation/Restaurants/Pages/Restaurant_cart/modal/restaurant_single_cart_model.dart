//
// import 'package:get/get_rx/get_rx.dart';
//
// class RestaurantSingleCartModal {
//   bool? status;
//   String? message;
//   Cart? cart;
//   String? cartContent;
//   var wallet;
//   Address? address;
//   bool? addressExists;
//   List<Coupon>? coupons;
//
//   RestaurantSingleCartModal({
//     this.status,
//     this.message,
//     this.cart,
//     this.cartContent,
//     this.wallet,
//     this.address,
//     this.addressExists,
//     this.coupons,
//   });
//
//   factory RestaurantSingleCartModal.fromJson(Map<String, dynamic> json) {
//     var cartData = json['cart'];
//     var addressData = json['address'];
//     var couponData = json['coupons'] as List?;
//
//     return RestaurantSingleCartModal(
//       status: json['status'],
//       message: json['message'],
//       cart: cartData != null ? Cart.fromJson(cartData) : null,
//       cartContent: json['cartContent'],
//       wallet: json['wallet'],
//       address: addressData != null ? Address.fromJson(addressData) : null,
//       addressExists: json['address_exists'],
//       coupons: couponData != null
//           ? couponData.map((coupon) => Coupon.fromJson(coupon)).toList()
//           : [],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'cart': cart?.toJson(),
//       'cartContent': cartContent,
//       'wallet': wallet,
//       'address': address?.toJson(),
//       'address_exists': addressExists,
//       'coupons': coupons?.map((e) => e.toJson()).toList() ?? [],
//     };
//   }
// }
//
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
//   var regularPrice;
//   var saveAmount;
//   var deliveryCharge;
//   var totalPrice;
//   var grandTotalPrice;
//   var couponId;
//   var couponDiscount;
//   CouponApplied? couponApplied;
//   var totalProductsInCart;
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
//     this.grandTotalPrice,
//     this.couponId,
//     this.couponDiscount,
//     this.couponApplied,
//     this.totalProductsInCart = 0,
//   });
//
//   factory Cart.fromJson(Map<String, dynamic> json) {
//     var decodedAttributeList = (json['decoded_attribute'] as List?)
//         ?.map((item) => DecodedAttribute.fromJson(item))
//         .toList();
//
//     var couponApplied = json['coupon_applied'] != null
//         ? CouponApplied.fromJson(json['coupon_applied'])
//         : null;
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
//       grandTotalPrice: json['grand_total_price'],
//       couponId: json['coupon_id'],
//       couponDiscount: json['coupon_discount'],
//       couponApplied: couponApplied,
//       totalProductsInCart: json['total_products_in_cart'],
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
//       'grand_total_price': grandTotalPrice,
//       'coupon_id': couponId,
//       'coupon_discount': couponDiscount,
//       'coupon_applied': couponApplied?.toJson(),
//       'total_products_in_cart': totalProductsInCart,
//       // Add the new field to the JSON
//     };
//   }
// }
//
// // class Cart {
// //   int? id;
// //   int? userId;
// //   int? productId;
// //   int? restoId;
// //   String? status;
// //   int? orderId;
// //   String? bucket;
// //   String? createdAt;
// //   String? updatedAt;
// //   List<DecodedAttribute>? decodedAttribute;
// //   var regularPrice;
// //   var saveAmount;
// //   var deliveryCharge;
// //   var totalPrice;
// //   var grandTotalPrice;
// //   var couponId;
// //   var couponDiscount;
// //   CouponApplied? couponApplied;
// //
// //   Cart({
// //     this.id,
// //     this.userId,
// //     this.productId,
// //     this.restoId,
// //     this.status,
// //     this.orderId,
// //     this.bucket,
// //     this.createdAt,
// //     this.updatedAt,
// //     this.decodedAttribute,
// //     this.regularPrice,
// //     this.saveAmount,
// //     this.deliveryCharge,
// //     this.totalPrice,
// //     this.grandTotalPrice,
// //     this.couponId,
// //     this.couponDiscount,
// //     this.couponApplied,
// //   });
// //
// //   factory Cart.fromJson(Map<String, dynamic> json) {
// //     var decodedAttributeList = (json['decoded_attribute'] as List?)
// //         ?.map((item) => DecodedAttribute.fromJson(item))
// //         .toList();
// //
// //     var couponApplied = json['coupon_applied'] != null
// //         ? CouponApplied.fromJson(json['coupon_applied'])
// //         : null;
// //
// //     return Cart(
// //       id: json['id'],
// //       userId: json['user_id'],
// //       productId: json['product_id'],
// //       restoId: json['resto_id'],
// //       status: json['status'],
// //       orderId: json['order_id'],
// //       bucket: json['bucket'],
// //       createdAt: json['created_at'],
// //       updatedAt: json['updated_at'],
// //       decodedAttribute: decodedAttributeList ?? [],
// //       regularPrice: json['regular_price'],
// //       saveAmount: json['save_amount'],
// //       deliveryCharge: json['delivery_charge'],
// //       totalPrice: json['total_price'],
// //       grandTotalPrice: json['grand_total_price'],
// //       couponId: json['coupon_id'],
// //       couponDiscount: json['coupon_discount'],
// //       couponApplied: couponApplied,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     return {
// //       'id': id,
// //       'user_id': userId,
// //       'product_id': productId,
// //       'resto_id': restoId,
// //       'status': status,
// //       'order_id': orderId,
// //       'bucket': bucket,
// //       'created_at': createdAt,
// //       'updated_at': updatedAt,
// //       'decoded_attribute':
// //           decodedAttribute?.map((e) => e.toJson()).toList() ?? [],
// //       'regular_price': regularPrice,
// //       'save_amount': saveAmount,
// //       'delivery_charge': deliveryCharge,
// //       'total_price': totalPrice,
// //       'grand_total_price': grandTotalPrice,
// //       'coupon_id': couponId,
// //       'coupon_discount': couponDiscount,
// //       'coupon_applied': couponApplied?.toJson(),
// //     };
// //   }
// // }
//
// class CouponApplied {
//   int? id;
//   String? couponType;
//   String? title;
//   String? code;
//   String? limitForUser;
//   String? discountType;
//   String? discountAmount;
//   String? minPurchase;
//   String? maxDiscount;
//   String? startDate;
//   String? expireDate;
//   String? category;
//   List<String>? subCategoryId;
//   List<String>? productId;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   String? expiryStatus;
//
//   CouponApplied({
//     this.id,
//     this.couponType,
//     this.title,
//     this.code,
//     this.discountType,
//     this.discountAmount,
//     this.minPurchase,
//     this.maxDiscount,
//     this.startDate,
//     this.expireDate,
//     this.category,
//     this.subCategoryId,
//     this.productId,
//     this.createdAt,
//     this.updatedAt,
//     this.expiryStatus,
//   });
//
//   factory CouponApplied.fromJson(Map<String, dynamic> json) {
//     return CouponApplied(
//       id: json['id'],
//       couponType: json['coupon_type'],
//       title: json['title'],
//       code: json['code'],
//       discountType: json['discount_type'],
//       discountAmount: json['discount_amount'],
//       minPurchase: json['min_purchase'],
//       maxDiscount: json['max_discount'],
//       startDate: json['start_date'],
//       expireDate: json['expire_date'],
//       category: json['category'],
//       subCategoryId: List<String>.from(json['sub_category_id'] ?? []),
//       productId: List<String>.from(json['product_id'] ?? []),
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       expiryStatus: json['expiry_status'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'coupon_type': couponType,
//       'title': title,
//       'code': code,
//       'discount_type': discountType,
//       'discount_amount': discountAmount,
//       'min_purchase': minPurchase,
//       'max_discount': maxDiscount,
//       'start_date': startDate,
//       'expire_date': expireDate,
//       'category': category,
//       'sub_category_id': subCategoryId,
//       'product_id': productId,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'expiry_status': expiryStatus,
//     };
//   }
// }
//
// class DecodedAttribute {
//   var productId;
//   var count;
//   int? quantity;
//   String? price;
//   List<Addon>? addons;
//   List<Attribute>? attribute;
//   String? productName;
//   String? productImage;
//   var totalPrice;
//   Rx<bool> isSelectedLoading = false.obs;
//   Rx<bool> isLoading = false.obs;
//   Rx<bool> isDelete = false.obs;
//   var checked;
//   int? categoryId;
//   String? categoryName;
//   String? status;
//
//   DecodedAttribute({
//     this.productId,
//     this.count,
//     this.quantity,
//     this.price,
//     this.addons,
//     this.attribute,
//     this.productName,
//     this.productImage,
//     this.totalPrice,
//     this.checked,
//     this.categoryId,
//     this.categoryName,
//     this.status,
//   });
//
//   factory DecodedAttribute.fromJson(Map<String, dynamic> json) {
//     var addonList =
//         (json['addons'] as List?)?.map((item) => Addon.fromJson(item)).toList();
//
//     var attributeList = (json['attribute'] as List?)
//         ?.map((item) => Attribute.fromJson(item))
//         .toList();
//
//     return DecodedAttribute(
//       productId: json['product_id'],
//       count: json['count'],
//       quantity: json['quantity'],
//       price: json['price'],
//       addons: addonList ?? [],
//       attribute: attributeList ?? [],
//       productName: json['product_name'],
//       productImage: json['product_image'],
//       totalPrice: json['total_price'],
//       checked: json['checked'],
//       categoryId: json['category_id'],
//       categoryName: json['category_name'],
//       status: json['status']?.toString(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'product_id': productId,
//       'count': count,
//       'quantity': quantity,
//       'price': price,
//       'addons': addons?.map((e) => e.toJson()).toList() ?? [],
//       'attribute': attribute?.map((e) => e.toJson()).toList() ?? [],
//       'product_name': productName,
//       'product_image': productImage,
//       'total_price': totalPrice,
//       'checked': checked,
//       'category_id': categoryId, // Added to toJson
//       'category_name': categoryName, // Added to toJson
//     };
//   }
// }
//
// class Addon {
//   String? id;
//   String? price;
//   String? name;
//
//   Addon({this.id, this.price, this.name});
//
//   factory Addon.fromJson(Map<String, dynamic> json) {
//     return Addon(
//       id: json['id'],
//       price: json['price'],
//       name: json['name'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'price': price,
//       'name': name,
//     };
//   }
// }
//
// class Attribute {
//   String? titleId;
//   ItemDetails? itemDetails;
//
//   Attribute({this.titleId, this.itemDetails});
//
//   factory Attribute.fromJson(Map<String, dynamic> json) {
//     return Attribute(
//       titleId: json['title_id'],
//       itemDetails: ItemDetails.fromJson(json['item_details']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'title_id': titleId,
//       'item_details': itemDetails?.toJson(),
//     };
//   }
// }
//
// class ItemDetails {
//   String? itemId;
//   String? itemName;
//   var itemPrice;
//
//   ItemDetails({
//     this.itemId,
//     this.itemName,
//     this.itemPrice,
//   });
//
//   factory ItemDetails.fromJson(Map<String, dynamic> json) {
//     return ItemDetails(
//       itemId: json['item_id'],
//       itemName: json['item_name'],
//       itemPrice: json['item_price'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'item_id': itemId,
//       'item_name': itemName,
//       'item_price': itemPrice,
//     };
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
//   bool? isDefault;
//   String? latitude;
//   String? longitude;
//   String? deliveryInstruction;
//   String? createdAt;
//   String? updatedAt;
//
//   Address({
//     this.id,
//     this.userId,
//     this.fullName,
//     this.phoneNumber,
//     this.countryCode,
//     this.houseDetails,
//     this.address,
//     this.addressType,
//     this.isDefault,
//     this.latitude,
//     this.longitude,
//     this.deliveryInstruction,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       id: json['id'],
//       userId: json['user_id'],
//       fullName: json['full_name'],
//       phoneNumber: json['phone_number'],
//       countryCode: json['country_code'],
//       houseDetails: json['house_details'],
//       address: json['address'],
//       addressType: json['address_type'],
//       isDefault: json['is_default'] == 1,
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       deliveryInstruction: json['delivery_instruction'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'full_name': fullName,
//       'phone_number': phoneNumber,
//       'country_code': countryCode,
//       'house_details': houseDetails,
//       'address': address,
//       'address_type': addressType,
//       'is_default': isDefault == true ? 1 : 0,
//       'latitude': latitude,
//       'longitude': longitude,
//       'delivery_instruction': deliveryInstruction,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }
// }
//
// class Coupon {
//   int? id;
//   String? couponType;
//   String? title;
//   String? code;
//   String? discountType;
//   var discountAmount;
//   String? expireDate;
//   String? expiryStatus;
//
//   Coupon({
//     this.id,
//     this.couponType,
//     this.title,
//     this.code,
//     this.discountType,
//     this.discountAmount,
//     this.expireDate,
//     this.expiryStatus,
//   });
//
//   factory Coupon.fromJson(Map<String, dynamic> json) {
//     return Coupon(
//       id: json['id'],
//       couponType: json['coupon_type'],
//       title: json['title'],
//       code: json['code'],
//       discountType: json['discount_type'],
//       discountAmount: json['discount_amount'],
//       expireDate: json['expire_date'],
//       expiryStatus: json['expiry_status'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'coupon_type': couponType,
//       'title': title,
//       'code': code,
//       'discount_type': discountType,
//       'discount_amount': discountAmount,
//       'expire_date': expireDate,
//       'expiry_status': expiryStatus,
//     };
//   }
// }

import 'package:get/get.dart';

class RestaurantSingleCartModel {
  bool? status;
  String? message;
  Cart? cart;
  Address? address;
  String? wallet;
  String? cartContent;
  List<Coupons>? coupons;
  bool? addressExists;

  RestaurantSingleCartModel(
      {this.status,
        this.message,
        this.cart,
        this.address,
        this.wallet,
        this.cartContent,
        this.coupons,
        this.addressExists});

  RestaurantSingleCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    wallet = json['wallet'];
    cartContent = json['cartContent'];
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(Coupons.fromJson(v));
      });
    }
    addressExists = json['address_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (cart != null) {
      data['cart'] = cart!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['wallet'] = wallet;
    data['cartContent'] = cartContent;
    if (coupons != null) {
      data['coupons'] = coupons!.map((v) => v.toJson()).toList();
    }
    data['address_exists'] = addressExists;
    return data;
  }
}

class Cart {
  String? id;
  String? userId;
  String? productId;
  String? restoId;
  String? pharmaId;
  String? status;
  String? orderId;
  String? bucket;
  String? couponId;
  String? createdAt;
  String? updatedAt;
  DecodedAttribute? decodedAttribute;
  String? regularPrice;
  String? saveAmount;
  String? deliveryCharge;
  String? totalPrice;
  String? couponDiscount;
  String? grandTotalPrice;
  String? totalProductsInCart;
  String? couponApplied;

  Cart(
      {this.id,
        this.userId,
        this.productId,
        this.restoId,
        this.pharmaId,
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
        this.totalProductsInCart,
        this.couponApplied});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    userId = json['user_id']?.toString();
    productId = json['product_id']?.toString();
    restoId = json['resto_id']?.toString();
    pharmaId = json['pharma_id']?.toString();
    status = json['status']?.toString();
    orderId = json['order_id']?.toString();
    bucket = json['bucket']?.toString();
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
    couponDiscount = json['coupon_discount']?.toString();
    grandTotalPrice = json['grand_total_price']?.toString();
    totalProductsInCart = json['total_products_in_cart']?.toString();
    couponApplied = json['coupon_applied']?.toString();
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
    data['coupon_discount'] = couponDiscount;
    data['grand_total_price'] = grandTotalPrice;
    data['total_products_in_cart'] = totalProductsInCart;
    data['coupon_applied'] = couponApplied;
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
  List<String>? addonName;
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
    price = json['price'];
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
    checked = json['checked']?.toString();
    count = json['count']?.toString();
    productName = json['product_name']?.toString();
    categoryId = json['category_id']?.toString();
    categoryName = json['category_name']?.toString();
    productImage = json['product_image']?.toString();
    status = json['status']?.toString();
    if(json['addon_name'] != null){
      addonName = json['addon_name'].cast<String>();
    }else{
      addonName = [];
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
    data['addon_name'] = addonName;
    data['total_price'] = totalPrice;
    return data;
  }
}

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
  String? itemPrice;

  ItemDetails({this.itemId, this.itemName, this.itemPrice});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id']?.toString();
    itemName = json['item_name']?.toString();
    itemPrice = json['item_price']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['item_name'] = itemName;
    data['item_price'] = itemPrice;
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

class Coupons {
  String? id;
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
    id = json['id']?.toString();
    couponType = json['coupon_type']?.toString();
    title = json['title']?.toString();
    code = json['code']?.toString();
    discountType = json['discount_type']?.toString();
    discountAmount = json['discount_amount']?.toString();
    expireDate = json['expire_date']?.toString();
    expiryStatus = json['expiry_status']?.toString();
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
