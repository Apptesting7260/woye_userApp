
class UserModel {
  int? step;
  String? token;
  String? loginType;
  bool? isLogin;

  UserModel({
    this.step,
    this.token,
    this.loginType,
    this.isLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    step: json["step"],
    token: json["token"],
    loginType: json["loginType"],
    isLogin: json["islogin"],
  );

  Map<String, dynamic> toJson() => {
    "step": step,
    "token": token,
    "loginType": loginType,
    "islogin": isLogin,
  };

  void clear() {
    step = null;
    token = null;
    loginType = null;
    isLogin = null;
  }

}
