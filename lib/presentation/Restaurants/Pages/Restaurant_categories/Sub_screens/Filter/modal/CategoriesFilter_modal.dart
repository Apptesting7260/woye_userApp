/*
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CategoriesFilter_modal {
  bool? status;
  List<CuisineType>? cuisineType;
  int? maxPrice;
  int? minPrice;
  String? message;

  CategoriesFilter_modal(
      {this.status,
      this.cuisineType,
      this.maxPrice,
      this.minPrice,
      this.message});

  CategoriesFilter_modal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['cuisine_id'] != null) {
      cuisineType = <CuisineType>[];
      json['cuisine_id'].forEach((v) {
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
      data['cuisine_id'] = this.cuisineType!.map((v) => v.toJson()).toList();
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

  CuisineType({this.name});

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
*/



import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CategoriesFilter_modal {
  bool? status;
  String? categoryId;
  List<CuisineId>? cuisineId;
  List<AttributeIds>? attributeIds;
  List<Addons>? addons;
  List<Options>? options;
  late final double? maxPrice;
  late final double? minPrice;
  String? message;

  CategoriesFilter_modal(
      {this.status,
        this.categoryId,
        this.cuisineId,
        this.attributeIds,
        this.addons,
        this.options,
        this.maxPrice,
        this.minPrice,
        this.message});

  CategoriesFilter_modal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoryId = json['category_id'].toString();
    if (json['cuisine_id'] != null) {
      cuisineId = <CuisineId>[];
      json['cuisine_id'].forEach((v) {
        cuisineId!.add(new CuisineId.fromJson(v));
      });
    }
    if (json['attribute_ids'] != null) {
      attributeIds = <AttributeIds>[];
      json['attribute_ids'].forEach((v) {
        attributeIds!.add(new AttributeIds.fromJson(v));
      });
    }
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(new Addons.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    maxPrice = json['maxPrice'].toDouble();
    minPrice = json['minPrice'].toDouble();
    message = json['message'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['category_id'] = categoryId;
    if (cuisineId != null) {
      data['cuisine_id'] = cuisineId!.map((v) => v.toJson()).toList();
    }
    if (attributeIds != null) {
      data['attribute_ids'] =
          attributeIds!.map((v) => v.toJson()).toList();
    }
    if (addons != null) {
      data['addons'] = addons!.map((v) => v.toJson()).toList();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['maxPrice'] = maxPrice;
    data['minPrice'] = minPrice;
    data['message'] = message;
    return data;
  }
}

class CuisineId {
  String? id;
  String? name;
  String? imageUrl;
  RxBool isSelected = false.obs;

  CuisineId({this.id, this.name, this.imageUrl});

  CuisineId.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    return data;
  }
}

class AttributeIds {
  String? id;
  String? name;
  RxBool isSelected = false.obs;

  AttributeIds({this.id, this.name});

  AttributeIds.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Addons {
  String? id;
  String? name;
  String? description;
  String? categoryId;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  RxBool isSelected = false.obs;

  Addons(
      {this.id,
        this.name,
        this.description,
        this.categoryId,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    categoryId = json['category_id'].toString();
    type = json['type'].toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Options {
  String? id;
  String? name;
  String? description;
  String? categoryId;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  RxBool isSelected = false.obs;

  Options(
      {this.id,
        this.name,
        this.description,
        this.categoryId,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    categoryId = json['category_id'].toString();
    type = json['type'].toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
