class MaintenanceModel {
  bool? status;
  String? maintenance;
  String? message;

  MaintenanceModel({this.status, this.maintenance, this.message});

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    maintenance = json['maintenance']?.toString();
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['maintenance'] = maintenance;
    data['message'] = message;
    return data;
  }
}
