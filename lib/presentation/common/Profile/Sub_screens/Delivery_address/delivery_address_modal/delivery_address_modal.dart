import 'package:get/get.dart';

class DeliveryAddressModal {
  bool? status;
  String? message;
  List<Data>? data;

  DeliveryAddressModal({this.status, this.message, this.data});

  DeliveryAddressModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? fullName;
  int? countryCode;
  String? phoneNumber;
  String? houseDetails;
  String? address;
  String? addressType;
  int? isDefault;
  var latitude;
  var longitude;
  String? deliveryInstruction;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.fullName,
      this.countryCode,
      this.phoneNumber,
      this.houseDetails,
      this.address,
      this.addressType,
      this.isDefault,
      this.latitude,
      this.longitude,
      this.deliveryInstruction,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    houseDetails = json['house_details'];
    address = json['address'];
    addressType = json['address_type'];
    isDefault = json['is_default'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deliveryInstruction = json['delivery_instruction'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['house_details'] = this.houseDetails;
    data['address'] = this.address;
    data['address_type'] = this.addressType;
    data['is_default'] = this.isDefault;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['delivery_instruction'] = this.deliveryInstruction;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
