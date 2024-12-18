

class RegisterModel {
  bool? status;
  String? message;
  int? step;
  String? token;
  String? loginType;

  RegisterModel({
    this.status,
    this.message,
    this.step,
    this.token,
    this.loginType,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"],
    message: json["message"],
    step: json["step"],
    token: json["token"],
    loginType: json["loginType"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "step": step,
    "token": token,
    "loginType": loginType,
  };
}
