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

// class Product {
//   int? id;
//   String? title;
//   int? userId;
//   int? categoryId;
//   String? regularPrice;
//   String? salePrice;
//   String? quanInStock;
//   String? description;
//   String? discount;
//   String? cuisineType;
//   int? rating;
//   int? productreview_count;
//   String? image;
//   String? addimg;
//   List<AddOn>? addOn;
//   List<Extra>? extra;
//   int? status;
//   String? createdAt;
//   String? updatedAt;
//   List<String>? urlAddimg;
//   String? urlImage;
//   List<Productreview>? productreview;
//   bool? isInWishlist;
//
//   Product(
//       {this.id,
//       this.title,
//       this.userId,
//       this.categoryId,
//       this.regularPrice,
//       this.salePrice,
//       this.quanInStock,
//       this.description,
//       this.discount,
//       this.cuisineType,
//       this.rating,
//       this.productreview_count,
//       this.image,
//       this.addimg,
//       this.addOn,
//       this.extra,
//       this.status,
//       this.createdAt,
//       this.updatedAt,
//       this.urlAddimg,
//       this.urlImage,
//       this.productreview,
//       this.isInWishlist});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     userId = json['user_id'];
//     categoryId = json['category_id'];
//     regularPrice = json['regular_price'];
//     salePrice = json['sale_price'];
//     quanInStock = json['quan_in_stock'];
//     description = json['description'];
//     discount = json['discount'];
//     cuisineType = json['cuisine_type'];
//     rating = json['rating'];
//     productreview_count = json['productreview_count'];
//     image = json['image'];
//     addimg = json['addimg'];
//     if (json['add_on'] != null) {
//       addOn = <AddOn>[];
//       json['add_on'].forEach((v) {
//         addOn!.add(new AddOn.fromJson(v));
//       });
//     }
//     if (json['extra'] != null) {
//       extra = <Extra>[];
//       json['extra'].forEach((v) {
//         extra!.add(new Extra.fromJson(v));
//       });
//     }
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     urlAddimg = json['url_addimg'].cast<String>();
//     urlImage = json['url_image'];
//     if (json['productreview'] != null) {
//       productreview = <Productreview>[];
//       json['productreview'].forEach((v) {
//         productreview!.add(new Productreview.fromJson(v));
//       });
//     }
//     isInWishlist = json['is_in_wishlist'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['user_id'] = this.userId;
//     data['category_id'] = this.categoryId;
//     data['regular_price'] = this.regularPrice;
//     data['sale_price'] = this.salePrice;
//     data['quan_in_stock'] = this.quanInStock;
//     data['description'] = this.description;
//     data['discount'] = this.discount;
//     data['cuisine_type'] = this.cuisineType;
//     data['rating'] = this.rating;
//     data['productreview_count'] = this.productreview_count;
//     data['image'] = this.image;
//     data['addimg'] = this.addimg;
//     if (this.addOn != null) {
//       data['add_on'] = this.addOn!.map((v) => v.toJson()).toList();
//     }
//     if (this.extra != null) {
//       data['extra'] = this.extra!.map((v) => v.toJson()).toList();
//     }
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['url_addimg'] = this.urlAddimg;
//     data['url_image'] = this.urlImage;
//     if (this.productreview != null) {
//       data['productreview'] =
//           this.productreview!.map((v) => v.toJson()).toList();
//     }
//     data['is_in_wishlist'] = this.isInWishlist;
//     return data;
//   }
// }
class Product {
  int? id;
  String? title;
  int? userId;
  int? categoryId;
  String? regularPrice;
  String? salePrice;
  String? quanInStock;
  String? description;
  String? discount;
  String? cuisineType;
  double? rating;  // Changed to double
  int? productreview_count;
  String? image;
  String? addimg;
  List<AddOn>? addOn;
  List<Extra>? extra;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<String>? urlAddimg;
  String? urlImage;
  List<Productreview>? productreview;
  bool? isInWishlist;

  Product(
      {this.id,
        this.title,
        this.userId,
        this.categoryId,
        this.regularPrice,
        this.salePrice,
        this.quanInStock,
        this.description,
        this.discount,
        this.cuisineType,
        this.rating,  // Changed to double
        this.productreview_count,
        this.image,
        this.addimg,
        this.addOn,
        this.extra,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.urlAddimg,
        this.urlImage,
        this.productreview,
        this.isInWishlist});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    quanInStock = json['quan_in_stock'];
    description = json['description'];
    discount = json['discount'];
    cuisineType = json['cuisine_type'];
    rating = json['rating']?.toDouble();  // Changed to double
    productreview_count = json['productreview_count'];
    image = json['image'];
    addimg = json['addimg'];
    if (json['add_on'] != null) {
      addOn = <AddOn>[];
      json['add_on'].forEach((v) {
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
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['quan_in_stock'] = quanInStock;
    data['description'] = description;
    data['discount'] = discount;
    data['cuisine_type'] = cuisineType;
    data['rating'] = rating;  // Rating is now double
    data['productreview_count'] = productreview_count;
    data['image'] = image;
    data['addimg'] = addimg;
    if (addOn != null) {
      data['add_on'] = addOn!.map((v) => v.toJson()).toList();
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
  RxBool isChecked; // Add this field to track checkbox state

  AddOn({this.name, this.price, bool? isChecked})
      : isChecked = RxBool(isChecked ?? false);

  AddOn.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        isChecked = RxBool(json['isChecked'] ?? false);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'isChecked': isChecked.value,
    };
  }
}

class Extra {
  String? title;
  List<Item>? item;
  RxInt selectedIndex = (0).obs;

  Extra({this.title, this.item});

  Extra.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String? id;
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


// class Productreview {
//   int? id;
//   int? userId;
//   String? username;
//   int? productId;
//   int? rating;
//   String? message;
//   String? createdAt;
//   String? updatedAt;
//   User? user; // New user field
//
//   Productreview(
//       {this.id,
//       this.userId,
//       this.username,
//       this.productId,
//       this.rating,
//       this.message,
//       this.createdAt,
//       this.updatedAt,
//       this.user}); // Include user in the constructor
//
//   Productreview.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     username = json['username'];
//     productId = json['product_id'];
//     rating = json['rating'];
//     message = json['message'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     user =
//         json['user'] != null ? User.fromJson(json['user']) : null; // Parse user
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['username'] = this.username;
//     data['product_id'] = this.productId;
//     data['rating'] = this.rating;
//     data['message'] = this.message;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.user != null) {
//       data['user'] =
//           this.user!.toJson(); // Convert user to JSON if it's not null
//     }
//     return data;
//   }
// }

class Productreview {
  int? id;
  int? userId;
  String? username;
  int? productId;
  double? rating;  // Changed to double
  String? message;
  String? createdAt;
  String? updatedAt;
  User? user;

  Productreview(
      {this.id,
        this.userId,
        this.username,
        this.productId,
        this.rating,  // Changed to double
        this.message,
        this.createdAt,
        this.updatedAt,
        this.user});

  Productreview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
    productId = json['product_id'];
    rating = json['rating']?.toDouble();  // Changed to double
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
    data['rating'] = rating;  // Rating is now double
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
  String? salePrice;
  String? regularPrice;
  String? title;
  String? addimg;
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
      this.addimg,
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
    addimg = json['addimg'];
    userId = json['user_id'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    urlAddimg = json['url_addimg'].cast<String>();
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
    data['addimg'] = this.addimg;
    data['user_id'] = this.userId;
    data['is_in_wishlist'] = this.isInWishlist;
    data['resto_name'] = this.restoName;
    data['url_addimg'] = this.urlAddimg;
    data['url_image'] = this.urlImage;
    return data;
  }
}
