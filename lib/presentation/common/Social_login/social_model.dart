
class SocialModel {
  bool? status;
  String? message;
  int? step;
  String? token;
  String? loginType;
  String? type;

  SocialModel({
    this.status,
    this.message,
    this.step,
    this.token,
    this.loginType,
    this.type,
  });

  factory SocialModel.fromJson(Map<String, dynamic> json) => SocialModel(
    status: json["status"],
    message: json["message"],
    step: json["step"],
    token: json["token"],
    loginType: json["loginType"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "step": step,
    "token": token,
    "loginType": loginType,
    "type": type,
  };
}
