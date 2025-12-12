class PharmaAddToCart {
  bool? status;
  String? message;

  PharmaAddToCart({
    this.status,
    this.message,
  });

  PharmaAddToCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

/////////////////////////////////////
class PharmaAddToCartModel {
  bool? status;
  String? message;
  String? cartId;

  PharmaAddToCartModel({
    this.status,
    this.message,
    this.cartId,
  });

  PharmaAddToCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cartId = json['cart_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['cart_id'] = cartId;
    return data;
  }
}
