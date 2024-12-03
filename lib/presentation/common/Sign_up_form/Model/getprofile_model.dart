
class ProfileModel {
  bool? status;
  String? message;
  Data? data;
  int? step;

  ProfileModel({
    this.status,
    this.message,
    this.data,
    this.step,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    step: json["step"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "step": step,
  };
}

class Data {
  int? id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic plainPassword;
  dynamic imageUrl;
  var dob;
  dynamic gender;
  String? phone;
  String? countryCode;
  dynamic terms;
  dynamic otp;
  String? fcmToken;
  dynamic status;
  int? step;
  dynamic uuid;
  String? type;
  dynamic userType;
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
    this.plainPassword,
    this.imageUrl,
    this.dob,
    this.gender,
    this.phone,
    this.countryCode,
    this.terms,
    this.otp,
    this.fcmToken,
    this.status,
    this.step,
    this.uuid,
    this.type,
    this.userType,
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
    plainPassword: json["plain_password"],
    imageUrl: json["image_url"],
    dob: json["dob"],
    gender: json["gender"],
    phone: json["phone"],
    countryCode: json["country_code"],
    terms: json["terms"],
    otp: json["otp"],
    fcmToken: json["fcm_token"],
    status: json["status"],
    step: json["step"],
    uuid: json["uuid"],
    type: json["type"],
    userType: json["user_type"],
    mobileVerified: json["mobile_verified"],
    emailVerified: json["email_verified"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "plain_password": plainPassword,
    "pro_img": imageUrl,
    "dob": dob,
    "gender": gender,
    "phone": phone,
    "country_code": countryCode,
    "terms": terms,
    "otp": otp,
    "fcm_token": fcmToken,
    "status": status,
    "step": step,
    "uuid": uuid,
    "type": type,
    "user_type": userType,
    "mobile_verified": mobileVerified,
    "email_verified": emailVerified,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
