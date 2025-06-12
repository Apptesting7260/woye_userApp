import 'package:get/get.dart';

class GrocerySpecificProductsModal {
  bool? status;
  Product? product;
  List<MoreProducts>? moreProducts;
  String? message;

  GrocerySpecificProductsModal(
      {this.status, this.product, this.moreProducts, this.message});

  GrocerySpecificProductsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['moreProducts'] != null) {
      moreProducts = <MoreProducts>[];
      json['moreProducts'].forEach((v) {
        moreProducts!.add(new MoreProducts.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (moreProducts != null) {
      data['moreProducts'] = moreProducts!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Product {
  int? id;
  String? title;
  var slug;
  int? userId;
  int? categoryId;
  int? consumeId;
  String? expire;
  var regularPrice;
  var salePrice;
  bool? isInWishlist;
  var quanInStock;
  int? packagingId;
  var packagingValue;
  String? description;
  String? image;
  String? addimg;
    Category? category;

  List<Variant>? variant;
  int? prescription;
  String? use;
  String? missedDose;
  String? overdose;
  String? interactions;
  String? sideEffect;
  String? advice;
  String? notUse;
  String? warnings;
  String? otherDetails;
  int? status;
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  String? pharmaName;
  String? pharmaImage;
  List<String>? urlAddimg;
  String? urlImage;
  Unit? unit;

  // New fields
  String? shelfLifeType;
  int? shelfLifeValue;

  Product(
      {this.id,
        this.title,
        this.slug,
        this.userId,
        this.categoryId,
        this.consumeId,
        this.expire,
        this.regularPrice,
        this.salePrice,
        this.isInWishlist,
        this.quanInStock,
        this.packagingId,
        this.packagingValue,
        this.description,
        this.image,
        this.addimg,
        this.variant,
        this.prescription,
        this.use,
        this.missedDose,
        this.overdose,
        this.interactions,
        this.sideEffect,
        this.advice,
        this.notUse,
        this.warnings,
        this.otherDetails,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.pharmaName,
        this.pharmaImage,
        this.urlAddimg,
        this.urlImage,
        this.unit,
        this.shelfLifeType, // Add to constructor
        this.shelfLifeValue,
        this.category,
      }); // Add to constructor

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    consumeId = json['consume_id'];
    expire = json['expire'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    isInWishlist = json['is_in_wishlist'];
    quanInStock = json['quan_in_stock'];
    packagingId = json['packaging_id'];
    packagingValue = json['unit_value'];
    description = json['description'];
    image = json['image'];
    addimg = json['addimg'];
    if (json['variant'] != null) {
      variant = <Variant>[];
      json['variant'].forEach((v) {
        variant!.add(Variant.fromJson(v));
      });
    }
    prescription = json['prescription'];
    use = json['use'];
    missedDose = json['missed_dose'];
    overdose = json['overdose'];
    interactions = json['interactions'];
    sideEffect = json['side_effect'];
    advice = json['advice'];
    notUse = json['not_use'];
    warnings = json['warnings'];
    otherDetails = json['other_details'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    pharmaName = json['grocery_name'];
    pharmaImage = json['grocery_image'];
    urlAddimg = json['url_addimg'].cast<String>();
    urlImage = json['url_image'];
    if (json['unit'] != null) {
      unit = Unit.fromJson(json['unit']);
    }

    // Parse new fields
    shelfLifeType = json['shelf_life_type']; // Add parsing for shelf_life_type
    shelfLifeValue = json['shelf_life_value']; // Add parsing for shelf_life_value
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['consume_id'] = consumeId;
    data['expire'] = expire;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['is_in_wishlist'] = isInWishlist;
    data['quan_in_stock'] = quanInStock;
    data['packaging_id'] = packagingId;
    data['unit_value'] = packagingValue;
    data['description'] = description;
    data['image'] = image;
    data['addimg'] = addimg;
    if (variant != null) {
      data['variant'] = variant!.map((v) => v.toJson()).toList();
    }
    data['prescription'] = prescription;
    data['use'] = use;
    data['missed_dose'] = missedDose;
    data['overdose'] = overdose;
    data['interactions'] = interactions;
    data['side_effect'] = sideEffect;
    data['advice'] = advice;
    data['not_use'] = notUse;
    data['warnings'] = warnings;
    data['other_details'] = otherDetails;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['grocery_name'] = pharmaName;
    data['grocery_image'] = pharmaImage;
    data['url_addimg'] = urlAddimg;
    data['url_image'] = urlImage;

    if (unit != null) {
      data['unit'] = unit!.toJson();
    }

    // Add new fields to JSON
    data['shelf_life_type'] = shelfLifeType; // Add shelf_life_type to JSON
    data['shelf_life_value'] = shelfLifeValue; // Add shelf_life_value to JSON
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? imageUrl;

  Category({this.id, this.name, this.imageUrl});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    return data;
  }
}

class Unit {
  int? id;
  String? name;

  Unit({this.id, this.name});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Variant {
  String? name;
  String? productId;
  var price;
  int? categoryId;
  String? category_name;

  Variant({
    this.name,
    this.productId,
    this.price,
    this.categoryId,
    this.category_name,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      name: json['name'],
      productId: json['product_id'],
      price: json['price'],
      categoryId: json['category_id'],
      category_name: json['category_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'product_id': productId,
      'price': price,
      'category_id': categoryId,
      'category_name': category_name,
    };
  }
}

class Item {
  var id;
  String? name;
  var price;

  Item({this.id, this.name, this.price});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class MoreProducts {
  int? id;
  String? title;
  var regularPrice;
  var salePrice;
  String? packagingValue;
  int? categoryId;
  bool? isInWishlist;
  var shopName;
  String? urlImage;
  String? categoryName;
  Rx<bool> isLoading = false.obs;

  MoreProducts({
    this.id,
    this.title,
    this.regularPrice,
    this.salePrice,
    this.packagingValue,
    this.categoryId,
    this.isInWishlist,
    this.shopName,
    this.urlImage,
    this.categoryName,
  });

  MoreProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    packagingValue = json['packaging_value'];
    categoryId = json['category_id'];
    isInWishlist = json['is_in_wishlist'];
    shopName = json['shop_name'];
    urlImage = json['url_image'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['packaging_value'] = packagingValue;
    data['category_id'] = categoryId;
    data['is_in_wishlist'] = isInWishlist;
    data['shop_name'] = shopName;
    data['url_image'] = urlImage;
    data['category_name'] = categoryName;
    return data;
  }
}
