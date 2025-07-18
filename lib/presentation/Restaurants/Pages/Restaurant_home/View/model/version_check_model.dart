class VersionCheckModel {
  bool? status;
  String? appVersion;
  String? message;

  VersionCheckModel({this.status, this.appVersion, this.message});

  VersionCheckModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    appVersion = json['app_version'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['app_version'] = appVersion;
    data['message'] = message;
    return data;
  }
}
