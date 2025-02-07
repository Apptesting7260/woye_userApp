class ReviewResponse {
  bool? status;
  List<Review>? reviewAll;
  String? message;

  ReviewResponse({
    this.status,
    this.reviewAll,
    this.message,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      status: json['status'],
      reviewAll: json['reviewAll'] != null
          ? List<Review>.from(json['reviewAll'].map((x) => Review.fromJson(x)))
          : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'reviewAll': reviewAll != null
          ? List<dynamic>.from(reviewAll!.map((x) => x.toJson()))
          : null,
      'message': message,
    };
  }
}

// class Review {
//   int? id;
//   int? userId;
//   String? username;
//   int? restaurantId;
//   int? productId;
//   double? rating; // Changed from int? to double?
//   String? message;
//   String? createdAt;
//   String? updatedAt;
//   User? user;
//
//   Review({
//     this.id,
//     this.userId,
//     this.username,
//     this.restaurantId,
//     this.productId,
//     this.rating,
//     this.message,
//     this.createdAt,
//     this.updatedAt,
//     this.user,
//   });
//
//   factory Review.fromJson(Map<String, dynamic> json) {
//     return Review(
//       id: json['id'],
//       userId: json['user_id'],
//       username: json['username'],
//       restaurantId: json['restaurant_id'],
//       productId: json['product_id'],
//       rating = json['rating']?.toDouble(); // Changed to double      message: json['message'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       user: json['user'] != null ? User.fromJson(json['user']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'username': username,
//       'restaurant_id': restaurantId,
//       'product_id': productId,
//       'rating': rating, // Rating remains as double
//       'message': message,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'user': user?.toJson(),
//     };
//   }
// }

class Review {
  int? id;
  int? userId;
  String? username;
  int? productId;
  double? rating; // Changed to double
  String? message;
  String? createdAt;
  String? updatedAt;
  User? user;

  Review(
      {this.id,
      this.userId,
      this.username,
      this.productId,
      this.rating, // Changed to double
      this.message,
      this.createdAt,
      this.updatedAt,
      this.user});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
    productId = json['product_id'];
    rating = json['rating']?.toDouble(); // Changed to double
    message = json['review'];
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
    data['rating'] = rating; // Rating is now double
    data['review'] = message;
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

  User({
    this.id,
    this.imageUrl,
    this.firstName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      imageUrl: json['image_url'],
      firstName: json['first_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'first_name': firstName,
    };
  }
}
