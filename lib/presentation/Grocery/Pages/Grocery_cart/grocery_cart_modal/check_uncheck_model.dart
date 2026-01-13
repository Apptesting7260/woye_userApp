class CheckUnCheckModel {
  bool? status;
  String? message;

  CheckUnCheckModel({this.status, this.message});

  CheckUnCheckModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
