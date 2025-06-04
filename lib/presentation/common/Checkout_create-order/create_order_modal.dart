// class CreateOrder {
//   bool? status;
//   String? message;
//
//   CreateOrder({
//     this.status,
//     this.message,
//   });
//
//   CreateOrder.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     return data;
//   }
// }
// class CreateOrder {
//   bool? status;
//   String? message;
//   String? orderNo;
//
//   CreateOrder({
//     this.status,
//     this.message,
//     this.orderNo,
//   });
//
//   factory CreateOrder.fromJson(Map<String, dynamic> json) => CreateOrder(
//         status: json["status"],
//         message: json["message"],
//         orderNo: json["order_no"]?.toString(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "order_no": orderNo,
//       };
// }
class RestaurantCreateOrderModel {
  bool? status;
  String? message;
  List<String>? orderIds;
  String? walletUsed;
  String? walletAmount;
  String? paymentMethod;
  String? paymentAmount;

  RestaurantCreateOrderModel(
      {this.status,
        this.message,
        this.orderIds,
        this.walletUsed,
        this.walletAmount,
        this.paymentMethod,
        this.paymentAmount});

  RestaurantCreateOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if(json['order_ids'] != null) {
      orderIds = json['order_ids'].cast<String>();
    }else{
      orderIds = [];
    }
    walletUsed = json['wallet_used']?.toString();
    walletAmount = json['wallet_amount']?.toString();
    paymentMethod = json['payment_method']?.toString();
    paymentAmount = json['payment_amount']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['order_ids'] = orderIds;
    data['wallet_used'] = walletUsed;
    data['wallet_amount'] = walletAmount;
    data['payment_method'] = paymentMethod;
    data['payment_amount'] = paymentAmount;
    return data;
  }
}
