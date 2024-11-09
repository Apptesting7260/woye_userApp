
class LoginModel {
  bool? status;
  String? message;
  String? token;
  int? step;
  String? loginType;

  LoginModel({
    this.status,
    this.message,
    this.token,
    this.step,
    this.loginType,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    token: json["token"],
    step: json["step"],
    loginType: json["loginType"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": token,
    "step": step,
    "loginType": loginType,
  };
}
