class pharmacy_add_product_wishlist_modal {
  bool? status;
  String? message;

  pharmacy_add_product_wishlist_modal({this.status, this.message});

  pharmacy_add_product_wishlist_modal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
