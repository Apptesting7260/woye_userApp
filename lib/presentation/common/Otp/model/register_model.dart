// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  bool? status;
  String? message;
  Data? data;
  String? token;

  RegisterModel({
    this.status,
    this.message,
    this.data,
    this.token,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "token": token,
      };
}

class Data {
  int? id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic password;
  dynamic plainPassword;
  dynamic proImg;
  dynamic dob;
  dynamic gender;
  String? phone;
  dynamic terms;
  dynamic otp;
  String? fcmToken;
  dynamic status;
  String? step;
  String? type;
  String? mobileVerified;
  String? emailVerified;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.plainPassword,
    this.proImg,
    this.dob,
    this.gender,
    this.phone,
    this.terms,
    this.otp,
    this.fcmToken,
    this.status,
    this.step,
    this.type,
    this.mobileVerified,
    this.emailVerified,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        plainPassword: json["plain_password"],
        proImg: json["pro_img"],
        dob: json["dob"],
        gender: json["gender"],
        phone: json["phone"],
        terms: json["terms"],
        otp: json["otp"],
        fcmToken: json["fcm_token"],
        status: json["status"],
        step: json["step"],
        type: json["type"],
        mobileVerified: json["mobile_verified"],
        emailVerified: json["email_verified"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "plain_password": plainPassword,
        "pro_img": proImg,
        "dob": dob,
        "gender": gender,
        "phone": phone,
        "terms": terms,
        "otp": otp,
        "fcm_token": fcmToken,
        "status": status,
        "step": step,
        "type": type,
        "mobile_verified": mobileVerified,
        "email_verified": emailVerified,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
