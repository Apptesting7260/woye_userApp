class VersionCheckModel {
  bool? status;
  String? userAppVersion;
  String? message;

  VersionCheckModel(
      {this.status, this.userAppVersion, this.message});

  VersionCheckModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userAppVersion = json['user_app_version']?.toString();
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['user_app_version'] = userAppVersion;
    data['message'] = message;
    return data;
  }
}
