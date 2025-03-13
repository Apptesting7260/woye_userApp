class GroceryModal {
  bool? status;
  String? message;

  GroceryModal({this.status, this.message});

  GroceryModal.fromJson(Map<String, dynamic> json) {
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
