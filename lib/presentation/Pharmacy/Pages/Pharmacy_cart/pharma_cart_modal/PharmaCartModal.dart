// import 'package:get/get.dart';
//
// class PharmaCartModal {
//   bool? status;
//   String? message;
//   Cart? cart;
//   String? cartContent;
//   Address? address;
//   bool? addressExists;
//   List<Coupon>? coupons;
//   var wallet;
//   String? prescription;
//
//   PharmaCartModal({
//     this.status,
//     this.message,
//     this.cart,
//     this.cartContent,
//     this.address,
//     this.addressExists,
//     this.coupons,
//     this.wallet,
//     this.prescription,
//   });
//
//   factory PharmaCartModal.fromJson(Map<String, dynamic> json) {
//     var cartData = json['cart'];
//     var addressData = json['address'];
//     var couponData = json['coupons'] as List?;
//
//     return PharmaCartModal(
//       status: json['status'],
//       message: json['message'],
//       cart: cartData != null ? Cart.fromJson(cartData) : null,
//       cartContent: json['cartContent'],
//       address: addressData != null ? Address.fromJson(addressData) : null,
//       addressExists: json['address_exists'],
//       coupons: couponData != null
//           ? couponData.map((coupon) => Coupon.fromJson(coupon)).toList()
//           : [],
//       wallet: json['wallet'],
//       prescription: json['prescription'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'cart': cart?.toJson(),
//       'cartContent': cartContent,
//       'address': address?.toJson(),
//       'address_exists': addressExists,
//       'coupons': coupons?.map((e) => e.toJson()).toList() ?? [],
//       'wallet': wallet,
//       'prescription': prescription,
//     };
//   }
// }
//
// class Cart {
//   int? id;
//   int? userId;
//   int? productId;
//   int? pharmaId;
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
//     this.pharmaId,
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
//       pharmaId: json['pharma_id'],
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
//       totalProductsInCart:
//           json['total_products_in_cart'], // Parse the new field
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'product_id': productId,
//       'pharma_id': pharmaId,
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
//   String? productId;
//   int? quantity;
//   var price;
//   List<Attribute>? attribute;
//   String? productName;
//   String? productImage;
//   var totalPrice;
//   Rx<bool> isSelectedLoading = false.obs;
//   Rx<bool> isLoading = false.obs;
//   Rx<bool> isDelete = false.obs;
//   var checked;
//   var count;
//   int? categoryId;
//   String? categoryName;
//
//   DecodedAttribute({
//     this.productId,
//     this.quantity,
//     this.price,
//     this.attribute,
//     this.productName,
//     this.productImage,
//     this.totalPrice,
//     this.checked,
//     this.count,
//     this.categoryId,
//     this.categoryName,
//   });
//
//   factory DecodedAttribute.fromJson(Map<String, dynamic> json) {
//     var attributeList = (json['attribute'] as List?)
//         ?.map((item) => Attribute.fromJson(item))
//         .toList();
//
//     return DecodedAttribute(
//       productId: json['product_id']?.toString(),
//       quantity: json['quantity'],
//       price: json['price'],
//       attribute: attributeList ?? [],
//       productName: json['product_name'],
//       productImage: json['product_image'],
//       totalPrice: json['total_price'],
//       checked: json['checked'],
//       count: json['count'],
//       categoryId: json['category_id'],
//       categoryName: json['category_name'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'product_id': productId,
//       'quantity': quantity,
//       'price': price,
//       'attribute': attribute?.map((e) => e.toJson()).toList() ?? [],
//       'product_name': productName,
//       'product_image': productImage,
//       'total_price': totalPrice,
//       'checked': checked,
//       'count': count,
//       'category_id': categoryId,
//       'category_name': categoryName,
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
//   String? itemPrice;
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
//


import 'package:get/get.dart';

class PharmacySingleCartModel {
  bool? status;
  String? message;
  Cart? cart;
  List<Coupons>? coupons;
  String? wallet;
  Address? address;
  String? prescription;
  bool? addressExists;
  String? cartContent;

  PharmacySingleCartModel({
    this.status,
    this.message,
    this.cart,
    this.coupons,
    this.wallet,
    this.address,
    this.prescription,
    this.addressExists,
    this.cartContent,
  });

  factory PharmacySingleCartModel.fromJson(Map<String, dynamic> json) {
    return PharmacySingleCartModel(
      status: json['status'],
      message: json['message']?.toString(),
      cart: json['cart'] != null ? Cart.fromJson(json['cart']) : null,
      coupons: (json['coupons'] as List<dynamic>?)
          ?.map((e) => Coupons.fromJson(e))
          .toList(),
      wallet: json['wallet']?.toString(),
      address:
      json['address'] != null ? Address.fromJson(json['address']) : null,
      prescription: json['prescription']?.toString(),
      addressExists: json['address_exists'],
      cartContent: json['cartContent']?.toString(),
    );
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


  Cart({
    this.cartId,
    this.subtotal,
    this.couponDiscount,
    this.deliveryCharge,
    this.finalTotal,
    this.couponApplied,
    this.appliedCoupon,
    this.raw,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartId: json['cart_id']?.toString(),
      subtotal: json['subtotal']?.toString(),
      couponDiscount: json['coupon_discount']?.toString(),
      deliveryCharge: json['delivery_charge']?.toString(),
      finalTotal: json['final_total']?.toString(),
      couponApplied: json['coupon_applied'],
      appliedCoupon: json['applied_coupon'] != null
          ? AppliedCouponCode.fromJson(json['applied_coupon'])
          : null,
      raw: json['raw'] != null ? Raw.fromJson(json['raw']) : null,
    );
  }
}

class Raw {
  String? id;
  String? userId;
  String? productId;
  String? pharmaId;
  String? status;
  String? orderId;
  String? bucket;
  String? orderType;
  String? couponId;
  String? createdAt;
  String? updatedAt;
  List<DecodedAttribute>? decodedAttribute;
  String? regularPrice;
  String? saveAmount;
  String? deliveryCharge;
  String? totalPrice;
  String? grandTotalPrice;
  String? totalProductsInCart;
  List<int>? pres;

  Raw({
    this.id,
    this.userId,
    this.productId,
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
    this.totalProductsInCart,
    this.pres,
  });

  factory Raw.fromJson(Map<String, dynamic> json) {
    return Raw(
      id: json['id']?.toString(),
      userId: json['user_id']?.toString(),
      productId: json['product_id']?.toString(),
      pharmaId: json['pharma_id']?.toString(),
      status: json['status']?.toString(),
      orderId: json['order_id']?.toString(),
      bucket: json['bucket']?.toString(),
      orderType: json['order_type']?.toString(),
      couponId: json['coupon_id']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      decodedAttribute: (json['decoded_attribute'] as List<dynamic>?)
          ?.map((e) => DecodedAttribute.fromJson(e))
          .toList(),
      regularPrice: json['regular_price']?.toString(),
      saveAmount: json['save_amount']?.toString(),
      deliveryCharge: json['delivery_charge']?.toString(),
      totalPrice: json['total_price']?.toString(),
      grandTotalPrice: json['grand_total_price']?.toString(),
      totalProductsInCart: json['total_products_in_cart']?.toString(),
      pres: (json['pres'] as List<dynamic>?)?.map((e) => int.tryParse(e.toString()) ?? 0).toList(),
    );
  }
}

class DecodedAttribute {
  String? productId;
  String? quantity;
  String? price;
  String? checked;
  String? count;
  String? productName;
  String? categoryId;
  String? categoryName;
  String? productImage;
  String? newPrice;
  String? totalPrice;
  Rx<bool> isSelectedLoading = false.obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isDelete = false.obs;

  DecodedAttribute({
    this.productId,
    this.quantity,
    this.price,
    this.checked,
    this.count,
    this.productName,
    this.categoryId,
    this.categoryName,
    this.productImage,
    this.newPrice,
    this.totalPrice,
  });

  factory DecodedAttribute.fromJson(Map<String, dynamic> json) {
    return DecodedAttribute(
      productId: json['product_id']?.toString(),
      quantity: json['quantity']?.toString(),
      price: json['price']?.toString(),
      checked: json['checked']?.toString(),
      count: json['count']?.toString(),
      productName: json['product_name']?.toString(),
      categoryId: json['category_id']?.toString(),
      categoryName: json['category_name']?.toString(),
      productImage: json['product_image']?.toString(),
      newPrice: json['new_price']?.toString(),
      totalPrice: json['total_price']?.toString(),
    );
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

  Coupons({
    this.id,
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
    this.status,
  });

  factory Coupons.fromJson(Map<String, dynamic> json) {
    return Coupons(
      id: json['id']?.toString(),
      couponType: json['coupon_type']?.toString(),
      title: json['title']?.toString(),
      code: json['code']?.toString(),
      value: json['value']?.toString(),
      minSpend: json['min_spend']?.toString(),
      category: json['category']?.toString(),
      vendorId: (json['vendor_id'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      geoZone: json['geo_zone']?.toString(),
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      itemQuantity: json['item_quantity']?.toString(),
      minOrders: json['min_orders']?.toString(),
      startDate: json['start_date']?.toString(),
      expireDate: json['expire_date']?.toString(),
      status: json['status']?.toString(),
    );
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
      id: json['id']?.toString(),
      userId: json['user_id']?.toString(),
      fullName: json['full_name']?.toString(),
      phoneNumber: json['phone_number']?.toString(),
      countryCode: json['country_code']?.toString(),
      houseDetails: json['house_details']?.toString(),
      address: json['address']?.toString(),
      addressType: json['address_type']?.toString(),
      isDefault: json['is_default']?.toString(),
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      deliveryInstruction: json['delivery_instruction']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
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
