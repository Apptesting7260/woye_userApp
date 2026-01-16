import 'package:get/get_rx/src/rx_types/rx_types.dart';

class RestaurantCategoryDetailsModal {
  bool? status;
  List<CategoryProduct>? categoryProduct;
  List<CategoryProduct>? filterProduct;
  String? message;

  RestaurantCategoryDetailsModal(
      {this.status, this.categoryProduct, this.message});

  RestaurantCategoryDetailsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categoryProduct'] != null) {
      categoryProduct = <CategoryProduct>[];
      json['categoryProduct'].forEach((v) {
        categoryProduct!.add(CategoryProduct.fromJson(v));
      });
    }
    if (json['filterProduct'] != null) {
      filterProduct = <CategoryProduct>[];
      json['filterProduct'].forEach((v) {
        filterProduct!.add(CategoryProduct.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (categoryProduct != null) {
      data['categoryProduct'] =
          categoryProduct!.map((v) => v.toJson()).toList();
    }
    if (filterProduct != null) {
      data['filterProduct'] =
          filterProduct!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class CategoryProduct {
  String? id;
  String? image;
  String? salePrice;
  String? regularPrice;
  String? title;
  String? preparationTime;
  bool? isInWishlist;
  String? restoName;
  String? urlImage;
  String? vendorId;
  List<AddOns>? addOns;
  List<Options>? options;
  List<ProductAttributes>? productAttributes;
  var rating;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isAddToCart = false.obs;
  Rx<bool> isCartLoading  = false.obs;

  CategoryProduct({
    this.id,
    this.image,
    this.salePrice,
    this.regularPrice,
    this.title,
    this.preparationTime,
    this.isInWishlist,
    this.restoName,
    this.urlImage,
    this.vendorId,
    this.addOns,
    this.options,
    this.productAttributes,
    this.rating,
  }){
    isCartLoading = false.obs;
  }

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    image = json['image_url'].toString();
    salePrice = json['sale_price'].toString();
    regularPrice = json['regular_price'].toString();
    title = json['title'].toString();
    preparationTime = json['preparation_time'].toString();
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'].toString();
    urlImage = json['url_image'];
    vendorId = json['vendor_id']?.toString();
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
    if (json['attributes_grouped'] != null) {
      productAttributes = <ProductAttributes>[];
      json['attributes_grouped'].forEach((v) {
        productAttributes!.add(new ProductAttributes.fromJson(v));
      });
    }
    rating = json['rating'].toString();
    isCartLoading = false.obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['image_url'] = image;
    data['sale_price'] = salePrice;
    data['regular_price'] = regularPrice;
    data['title'] = title;
    data['preparation_time'] = preparationTime;
    data['is_in_wishlist'] = isInWishlist;
    data['resto_name'] = restoName;
    data['url_image'] = urlImage;
    data['vendor_id'] = vendorId;
    if (addOns != null) {
      data['add_ons'] = addOns!.map((v) => v.toJson()).toList();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (productAttributes != null) {
      data['attributes_grouped'] =
          productAttributes!.map((v) => v.toJson()).toList();
    }
    data['rating'] = rating;
    return data;
  }
}

class ProductAttributes {
  String? groupName;
  List<Attributes>? attributes;

  ProductAttributes({this.groupName, this.attributes});

  ProductAttributes.fromJson(Map<String, dynamic> json) {
    groupName = json['group_name'].toString();
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_name'] = groupName;
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  int? id;
  String? name;

  Attributes({this.id, this.name});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
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
    data['id'] = id;
    data['price'] = price;
    data['name'] = name;
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
    data['option_id'] = optionId;
    if (choices != null) {
      data['choices'] = choices!.map((v) => v.toJson()).toList();
    }
    data['option_name'] = optionName;
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
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
