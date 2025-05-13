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
class CreateOrder {
  bool? status;
  String? message;
  String? orderNo;

  CreateOrder({
    this.status,
    this.message,
    this.orderNo,
  });

  factory CreateOrder.fromJson(Map<String, dynamic> json) => CreateOrder(
        status: json["status"],
        message: json["message"],
        orderNo: json["order_no"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order_no": orderNo,
      };
}
