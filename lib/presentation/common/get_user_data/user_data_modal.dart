class UserResponse {
  bool? status;
  String? message;
  User? user;

  UserResponse({
    this.status,
    this.message,
    this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      status: json['status'],
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'user': user?.toJson(),
    };
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? proImg;
  String? image;
  String? imageUrl;
  String? dob;
  String? gender;
  String? countryCode;
  String? phone;
  String? terms;
  String? otp;
  String? fcmToken;
  String? status;
  int? step;
  String? uuid;
  String? facebookId;
  String? appleId;
  String? type;
  String? userType;
  String? mobileVerified;
  String? emailVerified;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.proImg,
    this.image,
    this.imageUrl,
    this.dob,
    this.gender,
    this.countryCode,
    this.phone,
    this.terms,
    this.otp,
    this.fcmToken,
    this.status,
    this.step,
    this.uuid,
    this.facebookId,
    this.appleId,
    this.type,
    this.userType,
    this.mobileVerified,
    this.emailVerified,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      proImg: json['pro_img'],
      image: json['image'],
      imageUrl: json['image_url'],
      dob: json['dob'],
      gender: json['gender'],
      countryCode: json['country_code'],
      phone: json['phone'],
      terms: json['terms'],
      otp: json['otp'],
      fcmToken: json['fcm_token'],
      status: json['status'],
      step: json['step'],
      uuid: json['uuid'],
      facebookId: json['facebook_id'],
      appleId: json['apple_id'],
      type: json['type'],
      userType: json['user_type'],
      mobileVerified: json['mobile_verified'],
      emailVerified: json['email_verified'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'pro_img': proImg,
      'image': image,
      'image_url': imageUrl,
      'dob': dob,
      'gender': gender,
      'country_code': countryCode,
      'phone': phone,
      'terms': terms,
      'otp': otp,
      'fcm_token': fcmToken,
      'status': status,
      'step': step,
      'uuid': uuid,
      'facebook_id': facebookId,
      'apple_id': appleId,
      'type': type,
      'user_type': userType,
      'mobile_verified': mobileVerified,
      'email_verified': emailVerified,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
