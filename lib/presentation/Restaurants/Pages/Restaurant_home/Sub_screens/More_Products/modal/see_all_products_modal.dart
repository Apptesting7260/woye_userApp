import 'package:get/get.dart';

class seeAllProductsModal {
  bool? status;
  List<MoreProducts>? moreProducts;
  String? message;

  seeAllProductsModal({this.status, this.moreProducts, this.message});

  seeAllProductsModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    if (this.moreProducts != null) {
      data['moreProducts'] = this.moreProducts!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
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
  String? addimg;
  int? userId;
  int? categoryId;
  bool? isInWishlist;
  String? restoName;
  String? categoryName;
  int? productreviewCount;
  List<String>? urlAddimg;
  String? urlImage;
  List<ProductReview>? productreview;
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
        this.categoryId,
        this.isInWishlist,
        this.restoName,
        this.categoryName,
        this.productreviewCount,
        this.urlAddimg,
        this.urlImage,
        this.productreview});

  MoreProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    rating = json['rating'];
    salePrice = json['sale_price'];
    regularPrice = json['regular_price'];
    title = json['title'];
    addimg = json['addimg'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    isInWishlist = json['is_in_wishlist'];
    restoName = json['resto_name'];
    categoryName = json['category_name'];
    productreviewCount = json['productreview_count'];
    urlAddimg = List<String>.from(json['url_addimg'] ?? []);
    urlImage = json['url_image'];

    if (json['productreview'] != null) {
      productreview = [];
      json['productreview'].forEach((v) {
        productreview!.add(ProductReview.fromJson(v)); // Deserialize ProductReview
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['sale_price'] = this.salePrice;
    data['regular_price'] = this.regularPrice;
    data['title'] = this.title;
    data['addimg'] = this.addimg;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['is_in_wishlist'] = this.isInWishlist;
    data['resto_name'] = this.restoName;
    data['category_name'] = this.categoryName;
    data['productreview_count'] = this.productreviewCount;
    data['url_addimg'] = this.urlAddimg;
    data['url_image'] = this.urlImage;

    if (this.productreview != null) {
      data['productreview'] = this.productreview!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductReview {
  int? rating;
  String? review;

  ProductReview({this.rating, this.review});

  ProductReview.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}
