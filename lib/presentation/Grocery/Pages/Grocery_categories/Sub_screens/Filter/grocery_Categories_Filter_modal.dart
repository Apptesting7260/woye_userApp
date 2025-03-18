import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GroceryCategoriesFilterModal {
  bool? status;
  List<CuisineType>? cuisineType;
  var maxPrice;
  var minPrice;
  String? message;

  GroceryCategoriesFilterModal(
      {this.status,
      this.cuisineType,
      this.maxPrice,
      this.minPrice,
      this.message});

  GroceryCategoriesFilterModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['brand'] != null) {
      cuisineType = <CuisineType>[];
      json['brand'].forEach((v) {
        cuisineType!.add(new CuisineType.fromJson(v));
      });
    }
    maxPrice = json['maxPrice'];
    minPrice = json['minPrice'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.cuisineType != null) {
      data['brand'] = this.cuisineType!.map((v) => v.toJson()).toList();
    }
    data['maxPrice'] = this.maxPrice;
    data['minPrice'] = this.minPrice;
    data['message'] = this.message;
    return data;
  }
}

class CuisineType {
  String? name;
  int? id;
  RxBool isSelected = false.obs;

  CuisineType({this.name, this.id});

  CuisineType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
