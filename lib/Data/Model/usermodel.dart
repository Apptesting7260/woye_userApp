
class UserModel {
  int? step;
  String? token;
  String? loginType;
  bool? islogin;

  UserModel({
    this.step,
    this.token,
    this.loginType,
    this.islogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    step: json["step"],
    token: json["token"],
    loginType: json["loginType"],
    islogin: json["islogin"],
  );

  Map<String, dynamic> toJson() => {
    "step": step,
    "token": token,
    "loginType": loginType,
    "islogin": islogin,
  };

  void clear() {
    step = null;
    token = null;
    loginType = null;
    islogin = null;
  }

}
