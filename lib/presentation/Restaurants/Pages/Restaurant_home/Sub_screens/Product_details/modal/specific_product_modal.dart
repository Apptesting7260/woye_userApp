/*
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class specificProduct {
  bool? status;
  Product? product;
  List<MoreProducts>? moreProducts;
  String? message;

  specificProduct({this.status, this.product, this.moreProducts, this.message});

  specificProduct.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.moreProducts != null) {
      data['moreProducts'] = this.moreProducts!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Product {
  int? id;
  String? title;
  int? restaurantId;
  int? categoryId;
  var regularPrice;
  var salePrice;
  String? quanInStock;
  String? description;
  String? discount;
  double? rating;
  int? productreview_count;
  String? image;
  List<AddOn>? addOn;
  List<Extra>? extra;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<String>? urlAddimg;
  String? urlImage;
  List<Productreview>? productreview;
  bool? isInWishlist;
  String? restoImage; // New field
  String? restoName;  // New field

  Product({
    this.id,
    this.title,
    this.restaurantId,
    this.categoryId,
    this.regularPrice,
    this.salePrice,
    this.quanInStock,
    this.description,
    this.discount,
    this.rating,
    this.productreview_count,
    this.image,
    this.addOn,
    this.extra,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.urlAddimg,
    this.urlImage,
    this.productreview,
    this.isInWishlist,
    this.restoImage,  // New field
    this.restoName,   // New field
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    restaurantId = json['user_id'];
    categoryId = json['category_id'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    quanInStock = json['quan_in_stock'];
    description = json['description'];
    discount = json['discount'];
    rating = json['rating']?.toDouble();
    productreview_count = json['productreview_count'];
    image = json['image'];

    // Parsing new fields
    restoImage = json['resto_image'];
    restoName = json['resto_name'];

    if (json['add_on_with_names'] != null) {
      addOn = <AddOn>[];
      json['add_on_with_names'].forEach((v) {
        addOn!.add(AddOn.fromJson(v));
      });
    }
    if (json['extra'] != null) {
      extra = <Extra>[];
      json['extra'].forEach((v) {
        extra!.add(Extra.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    urlAddimg = List<String>.from(json['url_addimg'] ?? []);
    urlImage = json['url_image'];
    if (json['productreview'] != null) {
      productreview = <Productreview>[];
      json['productreview'].forEach((v) {
        productreview!.add(Productreview.fromJson(v));
      });
    }
    isInWishlist = json['is_in_wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['user_id'] = restaurantId;
    data['category_id'] = categoryId;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['quan_in_stock'] = quanInStock;
    data['description'] = description;
    data['discount'] = discount;
    data['rating'] = rating;
    data['productreview_count'] = productreview_count;
    data['image'] = image;

    // Adding new fields to the JSON data
    data['resto_image'] = restoImage;
    data['resto_name'] = restoName;

    if (addOn != null) {
      data['add_on_with_names'] = addOn!.map((v) => v.toJson()).toList();
    }
    if (extra != null) {
      data['extra'] = extra!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['url_addimg'] = urlAddimg;
    data['url_image'] = urlImage;
    if (productreview != null) {
      data['productreview'] = productreview!.map((v) => v.toJson()).toList();
    }
    data['is_in_wishlist'] = isInWishlist;
    return data;
  }
}


class AddOn {
  String? name;
  String? price;
  String? id;
  RxBool isChecked;

  AddOn({this.name, this.price, bool? isChecked})
      : isChecked = RxBool(isChecked ?? false);

  AddOn.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        price = json['price'],
        isChecked = RxBool(json['isChecked'] ?? false);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'price': price,
      'isChecked': isChecked.value,
    };
  }
}

class Extra {
  String? title;
  String? titleid;
  List<Item>? item;
  RxInt selectedIndex = (-1).obs;

  Extra({this.title, this.titleid, this.item});

  Extra.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    titleid = json['titleid'];
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['titleid'] = this.titleid;
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  var id;
  String? name;
  String? price;

  Item({this.id, this.name, this.price});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

class Productreview {
  int? id;
  int? userId;
  String? username;
  int? productId;
  double? rating; // Changed to double
  String? message;
  String? createdAt;
  String? updatedAt;
  User? user;

  Productreview(
      {this.id,
      this.userId,
      this.username,
      this.productId,
      this.rating, // Changed to double
      this.message,
      this.createdAt,
      this.updatedAt,
      this.user});

  Productreview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
    productId = json['product_id'];
    rating = json['rating']?.toDouble(); // Changed to double
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['username'] = username;
    data['product_id'] = productId;
    data['rating'] = rating;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? imageUrl;
  String? firstName;

  User({this.id, this.imageUrl, this.firstName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['first_name'] = this.firstName;
    return data;
  }
}

class MoreProducts {
  int? id;
  String? image;
  int? rating;
  var salePrice;
  var regularPrice;
  String? title;
  int? userId;
  bool? isInWishlist;
  String? restoName;
  List<String>? urlAddimg;
  String? urlImage;
  Rx<bool> isLoading = false.obs;

  MoreProducts(
      {this.id,
      this.image,
      this.rating,
      this.salePrice,
      this.regularPrice,
      this.title,
      this.userId,
      this.isInWishlist,
      this.restoName,
      this.urlAddimg,
      this.urlImage});

  MoreProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    rating = json['rating'];
    salePrice = json['sale_price'];
    regularPrice = json['regular_price'];
    title = json['title'];
    userId = json['user_id'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    urlAddimg = List<String>.from(json['url_addimg'] ?? []);
    urlImage = json['url_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['sale_price'] = this.salePrice;
    data['regular_price'] = this.regularPrice;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    data['is_in_wishlist'] = this.isInWishlist;
    data['resto_name'] = this.restoName;
    data['url_addimg'] = this.urlAddimg;
    data['url_image'] = this.urlImage;
    return data;
  }
}
*/

import 'package:get/get_rx/src/rx_types/rx_types.dart';

/*class specificProduct {
  bool? status;
  Product? product;
  List<MoreProducts>? moreProducts;
  String? message;

  specificProduct({this.status, this.product, this.moreProducts, this.message});

  specificProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['moreProducts'] != null) {
      moreProducts = <MoreProducts>[];
      json['moreProducts'].forEach((v) {
        moreProducts!.add(new MoreProducts.fromJson(v));
      });
    }
    message = json['message'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.moreProducts != null) {
      data['moreProducts'] = this.moreProducts!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Product {
  String? id;
  String? title;
  String? slug;
  String? sku;
  String? description;
  String? image;
  String? addimg;
  String? vendorId;
  String? categoryId;
  String? cuisineId;
  String? brandId;
  String? packagingId;
  String? applicationId;
  String? ndcNumber;
  String? strength;
  String? department;
  String? shelfLifeType;
  String? shelfLifeValue;
  String? menuSection;
  String? regularPrice;
  String? salePrice;
  String? discount;
  String? quantityInStock;
  String? prescription;
  String? preparationTime;
  String? rating;
  List<Addons>? addOns;
  List<Options>? options;
  List<AttributeIds>? productAttributes;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? isInWishlist;
  String? restoName;
  String? restoImage;
  List<String>? addimgUrl;
  String? imageUrl;
  String? categoryName;
  String? cuisineName;
  String? brandName;
  String? packagingName;
  String? applicationName;
  Category? category;
  Cuisine? cuisine;
  String? brand;
  String? packaging;
  String? application;

  Product(
      {this.id,
        this.title,
        this.slug,
        this.sku,
        this.description,
        this.image,
        this.addimg,
        this.vendorId,
        this.categoryId,
        this.cuisineId,
        this.brandId,
        this.packagingId,
        this.applicationId,
        this.ndcNumber,
        this.strength,
        this.department,
        this.shelfLifeType,
        this.shelfLifeValue,
        this.menuSection,
        this.regularPrice,
        this.salePrice,
        this.discount,
        this.quantityInStock,
        this.prescription,
        this.preparationTime,
        this.rating,
        this.addOns,
        this.options,
        this.productAttributes,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isInWishlist,
        this.restoName,
        this.restoImage,
        this.addimgUrl,
        this.imageUrl,
        this.categoryName,
        this.cuisineName,
        this.brandName,
        this.packagingName,
        this.applicationName,
        this.category,
        this.cuisine,
        this.brand,
        this.packaging,
        this.application});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    slug = json['slug'].toString();
    sku = json['sku'].toString();
    description = json['description'].toString();
    image = json['image'].toString();
    addimg = json['addimg'].toString();
    vendorId = json['vendor_id'].toString();
    categoryId = json['category_id'].toString();
    cuisineId = json['cuisine_id'].toString();
    brandId = json['brand_id'].toString();
    packagingId = json['packaging_id'].toString();
    applicationId = json['application_id'].toString();
    ndcNumber = json['ndc_number'].toString();
    strength = json['strength'].toString();
    department = json['department'].toString();
    shelfLifeType = json['shelf_life_type'].toString();
    shelfLifeValue = json['shelf_life_value'];
    menuSection = json['menu_section'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    discount = json['discount'].toString();
    quantityInStock = json['quantity_in_stock'].toString();
    prescription = json['prescription'].toString();
    preparationTime = json['preparation_time'];
    rating = json['rating'];
    if (json['add_ons'] != null) {
      addOns = <Addons>[];
      json['add_ons'].forEach((v) {
        addOns!.add(new Addons.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    if (json['product_attributes'] != null) {
      productAttributes = <AttributeIds>[];
      json['product_attributes'].forEach((v) {
        productAttributes!.add(new AttributeIds.fromJson(v));
      });
    }
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    restoImage = json['resto_image'];
    addimgUrl = json['addimg_url'].cast<String>();
    imageUrl = json['image_url'];
    categoryName = json['category_name'];
    cuisineName = json['cuisine_name'];
    brandName = json['brand_name'];
    packagingName = json['packaging_name'];
    applicationName = json['application_name'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    cuisine =
    json['cuisine'] != null ? new Cuisine.fromJson(json['cuisine']) : null;
    brand = json['brand'];
    packaging = json['packaging'];
    application = json['application'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['sku'] = this.sku;
    data['description'] = this.description;
    data['image'] = this.image;
    data['addimg'] = this.addimg;
    data['vendor_id'] = this.vendorId;
    data['category_id'] = this.categoryId;
    data['cuisine_id'] = this.cuisineId;
    data['brand_id'] = this.brandId;
    data['packaging_id'] = this.packagingId;
    data['application_id'] = this.applicationId;
    data['ndc_number'] = this.ndcNumber;
    data['strength'] = this.strength;
    data['department'] = this.department;
    data['shelf_life_type'] = this.shelfLifeType;
    data['shelf_life_value'] = this.shelfLifeValue;
    data['menu_section'] = this.menuSection;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['discount'] = this.discount;
    data['quantity_in_stock'] = this.quantityInStock;
    data['prescription'] = this.prescription;
    data['preparation_time'] = this.preparationTime;
    data['rating'] = this.rating;
    if (this.addOns != null) {
      data['add_ons'] = this.addOns!.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.productAttributes != null) {
      data['product_attributes'] =
          this.productAttributes!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['is_in_wishlist'] = this.isInWishlist;
    data['resto_name'] = this.restoName;
    data['resto_image'] = this.restoImage;
    data['addimg_url'] = this.addimgUrl;
    data['image_url'] = this.imageUrl;
    data['category_name'] = this.categoryName;
    data['cuisine_name'] = this.cuisineName;
    data['brand_name'] = this.brandName;
    data['packaging_name'] = this.packagingName;
    data['application_name'] = this.applicationName;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.cuisine != null) {
      data['cuisine'] = this.cuisine!.toJson();
    }
    data['brand'] = this.brand;
    data['packaging'] = this.packaging;
    data['application'] = this.application;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? parentCategory;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  int? productsCount;

  Category(
      {this.id,
        this.name,
        this.slug,
        this.image,
        this.parentCategory,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.imageUrl,
        this.productsCount});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    parentCategory = json['parent_category'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
    productsCount = json['products_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['parent_category'] = this.parentCategory;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    data['products_count'] = this.productsCount;
    return data;
  }
}

class Cuisine {
  int? id;
  String? name;
  String? description;
  Null? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Cuisine(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.imageUrl});

  Cuisine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class MoreProducts {
  String? id;
  String? image;
  String? rating;
  var salePrice;
  var regularPrice;
  String? title;
  int? userId;
  bool? isInWishlist;
  String? restoName;
  List<String>? urlAddimg;
  String? urlImage;
  Rx<bool> isLoading = false.obs;

  MoreProducts(
      {this.id,
        this.image,
        this.rating,
        this.salePrice,
        this.regularPrice,
        this.title,
        this.userId,
        this.isInWishlist,
        this.restoName,
        this.urlAddimg,
        this.urlImage});

  MoreProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    rating = json['rating'];
    salePrice = json['sale_price'];
    regularPrice = json['regular_price'];
    title = json['title'];
    userId = json['user_id'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    urlAddimg = List<String>.from(json['url_addimg'] ?? []);
    urlImage = json['url_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['sale_price'] = this.salePrice;
    data['regular_price'] = this.regularPrice;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    data['is_in_wishlist'] = this.isInWishlist;
    data['resto_name'] = this.restoName;
    data['url_addimg'] = this.urlAddimg;
    data['url_image'] = this.urlImage;
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
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Addons {
  String? id;
  String? name;
  String? description;
  String? categoryId;
  String? type;
  String? price;
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
        this.price,
        this.status,
        this.createdAt,
        this.updatedAt});

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    categoryId = json['category_id'].toString();
    type = json['type'].toString();
    price = json['price'].toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['type'] = this.type;
    data['price'] = this.price;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}*/


class specificProduct {
  bool? status;
  Product? product;
  List<MoreProducts>? moreProducts;
  String? message;

  specificProduct({this.status, this.product, this.moreProducts, this.message});

  specificProduct.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.moreProducts != null) {
      data['moreProducts'] = this.moreProducts!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Product {
  String? id;
  String? title;
  String? slug;
  String? sku;
  String? description;
  String? image;
  String? addimg;
  String? vendorId;
  String? categoryId;
  String? cuisineId;
  String? brandId;
  String? packagingId;
  String? applicationId;
  String? ndcNumber;
  String? strength;
  String? department;
  String? shelfLifeType;
  String? shelfLifeValue;
  String? menuSection;
  String? regularPrice;
  String? salePrice;
  String? discount;
  String? quantityInStock;
  String? prescription;
  String? preparationTime;
  String? rating;
  List<AddOns>? addOns;
  List<Options>? options;
  List<String>? productAttributes;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? isInWishlist;
  String? restoName;
  String? restoImage;
  List<String>? addimgUrl;
  String? imageUrl;
  String? categoryName;
  String? cuisineName;
  String? brandName;
  String? packagingName;
  String? applicationName;
  Category? category;
  Cuisine? cuisine;
  String? brand;
  String? packaging;
  String? application;

  Product(
      {this.id,
        this.title,
        this.slug,
        this.sku,
        this.description,
        this.image,
        this.addimg,
        this.vendorId,
        this.categoryId,
        this.cuisineId,
        this.brandId,
        this.packagingId,
        this.applicationId,
        this.ndcNumber,
        this.strength,
        this.department,
        this.shelfLifeType,
        this.shelfLifeValue,
        this.menuSection,
        this.regularPrice,
        this.salePrice,
        this.discount,
        this.quantityInStock,
        this.prescription,
        this.preparationTime,
        this.rating,
        this.addOns,
        this.options,
        this.productAttributes,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isInWishlist,
        this.restoName,
        this.restoImage,
        this.addimgUrl,
        this.imageUrl,
        this.categoryName,
        this.cuisineName,
        this.brandName,
        this.packagingName,
        this.applicationName,
        this.category,
        this.cuisine,
        this.brand,
        this.packaging,
        this.application});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    slug = json['slug'].toString();
    sku = json['sku'].toString();
    description = json['description'].toString();
    image = json['image'].toString();
    addimg = json['addimg'];
    vendorId = json['vendor_id'].toString();
    categoryId = json['category_id'].toString();
    cuisineId = json['cuisine_id'].toString();
    brandId = json['brand_id'].toString();
    packagingId = json['packaging_id'].toString();
    applicationId = json['application_id'].toString();
    ndcNumber = json['ndc_number'];
    strength = json['strength'];
    department = json['department'];
    shelfLifeType = json['shelf_life_type'];
    shelfLifeValue = json['shelf_life_value'];
    menuSection = json['menu_section'];
    regularPrice = json['regular_price'].toString();
    salePrice = json['sale_price'].toString();
    discount = json['discount'].toString();
    quantityInStock = json['quantity_in_stock'].toString();
    prescription = json['prescription'].toString();
    preparationTime = json['preparation_time'].toString();
    rating = json['rating'];
    if (json['add_ons'] != null) {
      addOns = <AddOns>[];
      json['add_ons'].forEach((v) {
        addOns!.add(new AddOns.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    productAttributes = json['product_attributes'].cast<String>();
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    restoImage = json['resto_image'];
    addimgUrl = json['addimg_url'].cast<String>();
    imageUrl = json['image_url'];
    categoryName = json['category_name'];
    cuisineName = json['cuisine_name'];
    brandName = json['brand_name'];
    packagingName = json['packaging_name'];
    applicationName = json['application_name'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    cuisine =
    json['cuisine'] != null ? new Cuisine.fromJson(json['cuisine']) : null;
    brand = json['brand'];
    packaging = json['packaging'];
    application = json['application'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['sku'] = this.sku;
    data['description'] = this.description;
    data['image'] = this.image;
    data['addimg'] = this.addimg;
    data['vendor_id'] = this.vendorId;
    data['category_id'] = this.categoryId;
    data['cuisine_id'] = this.cuisineId;
    data['brand_id'] = this.brandId;
    data['packaging_id'] = this.packagingId;
    data['application_id'] = this.applicationId;
    data['ndc_number'] = this.ndcNumber;
    data['strength'] = this.strength;
    data['department'] = this.department;
    data['shelf_life_type'] = this.shelfLifeType;
    data['shelf_life_value'] = this.shelfLifeValue;
    data['menu_section'] = this.menuSection;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['discount'] = this.discount;
    data['quantity_in_stock'] = this.quantityInStock;
    data['prescription'] = this.prescription;
    data['preparation_time'] = this.preparationTime;
    data['rating'] = this.rating;
    if (this.addOns != null) {
      data['add_ons'] = this.addOns!.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['product_attributes'] = this.productAttributes;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['is_in_wishlist'] = this.isInWishlist;
    data['resto_name'] = this.restoName;
    data['resto_image'] = this.restoImage;
    data['addimg_url'] = this.addimgUrl;
    data['image_url'] = this.imageUrl;
    data['category_name'] = this.categoryName;
    data['cuisine_name'] = this.cuisineName;
    data['brand_name'] = this.brandName;
    data['packaging_name'] = this.packagingName;
    data['application_name'] = this.applicationName;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.cuisine != null) {
      data['cuisine'] = this.cuisine!.toJson();
    }
    data['brand'] = this.brand;
    data['packaging'] = this.packaging;
    data['application'] = this.application;
    return data;
  }
}

class AddOns {
  String? id;
  String? price;
  String? name;
  RxBool isSelected = false.obs;

  AddOns({this.id, this.price, this.name});

  AddOns.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    price = json['price'].toString();
    name = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['name'] = this.name;
    return data;
  }
}

class Options {
  String? optionId;
  List<Choices>? choices;
  String? optionName;

  Options({this.optionId, this.choices, this.optionName});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
    optionName = json['option_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    data['option_name'] = this.optionName;
    return data;
  }
}

class Choices {
  String? name;
  String? price;

  Choices({this.name, this.price});

  Choices.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    price = json['price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? slug;
  String? image;
  String? parentCategory;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  String? productsCount;

  Category(
      {this.id,
        this.name,
        this.slug,
        this.image,
        this.parentCategory,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.imageUrl,
        this.productsCount});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    slug = json['slug'].toString();
    image = json['image'].toString();
    parentCategory = json['parent_category'].toString();
    description = json['description'].toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    imageUrl = json['image_url'].toString();
    productsCount = json['products_count'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['parent_category'] = this.parentCategory;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    data['products_count'] = this.productsCount;
    return data;
  }
}

class Cuisine {
  String? id;
  String? name;
  String? description;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Cuisine(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.imageUrl});

  Cuisine.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    image = json['image'].toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class MoreProducts {
  int? id;
  String? image;
  String? rating;
  int? salePrice;
  String? regularPrice;
  String? title;
  String? addimg;
  int? vendorId;
  bool? isInWishlist;
  String? restoName;
  List<String>? addimgUrl;
  String? imageUrl;
  String? categoryName;
  String? cuisineName;
  String? brandName;
  String? packagingName;
  String? applicationName;
  String? category;
  String? cuisine;
  String? brand;
  String? packaging;
  String? application;
  Rx<bool> isLoading = false.obs;

  MoreProducts(
      {this.id,
        this.image,
        this.rating,
        this.salePrice,
        this.regularPrice,
        this.title,
        this.addimg,
        this.vendorId,
        this.isInWishlist,
        this.restoName,
        this.addimgUrl,
        this.imageUrl,
        this.categoryName,
        this.cuisineName,
        this.brandName,
        this.packagingName,
        this.applicationName,
        this.category,
        this.cuisine,
        this.brand,
        this.packaging,
        this.application});

  MoreProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    rating = json['rating'];
    salePrice = json['sale_price'];
    regularPrice = json['regular_price'];
    title = json['title'];
    addimg = json['addimg'];
    vendorId = json['vendor_id'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    addimgUrl = json['addimg_url'].cast<String>();
    imageUrl = json['image_url'];
    categoryName = json['category_name'];
    cuisineName = json['cuisine_name'];
    brandName = json['brand_name'];
    packagingName = json['packaging_name'];
    applicationName = json['application_name'];
    category = json['category'];
    cuisine = json['cuisine'];
    brand = json['brand'];
    packaging = json['packaging'];
    application = json['application'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['sale_price'] = this.salePrice;
    data['regular_price'] = this.regularPrice;
    data['title'] = this.title;
    data['addimg'] = this.addimg;
    data['vendor_id'] = this.vendorId;
    data['is_in_wishlist'] = this.isInWishlist;
    data['resto_name'] = this.restoName;
    data['addimg_url'] = this.addimgUrl;
    data['image_url'] = this.imageUrl;
    data['category_name'] = this.categoryName;
    data['cuisine_name'] = this.cuisineName;
    data['brand_name'] = this.brandName;
    data['packaging_name'] = this.packagingName;
    data['application_name'] = this.applicationName;
    data['category'] = this.category;
    data['cuisine'] = this.cuisine;
    data['brand'] = this.brand;
    data['packaging'] = this.packaging;
    data['application'] = this.application;
    return data;
  }
}


