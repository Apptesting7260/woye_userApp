class PharmacyCreateOrderModel {
  bool? status;
  String? message;
  String? walletUsed;
  String? walletAmount;
  String? paymentMethod;
  String? paymentAmount;

  PharmacyCreateOrderModel(
      {this.status,
        this.message,
        this.walletUsed,
        this.walletAmount,
        this.paymentMethod,
        this.paymentAmount});

  PharmacyCreateOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    walletUsed = json['wallet_used']?.toString();
    walletAmount = json['wallet_amount']?.toString();
    paymentMethod = json['payment_method']?.toString();
    paymentAmount = json['payment_amount']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['wallet_used'] = walletUsed;
    data['wallet_amount'] = walletAmount;
    data['payment_method'] = paymentMethod;
    data['payment_amount'] = paymentAmount;
    return data;
  }
}
