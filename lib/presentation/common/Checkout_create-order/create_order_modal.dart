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

  CreateOrder({
    this.status,
    this.message,
  });

  factory CreateOrder.fromJson(Map<String, dynamic> json) => CreateOrder(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
