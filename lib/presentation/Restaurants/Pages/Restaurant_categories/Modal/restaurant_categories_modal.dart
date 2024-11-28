class restaurant_Categories_Modal {
  bool? status;
  List<Allcategory>? allcategory;
  String? message;

  restaurant_Categories_Modal({this.status, this.allcategory, this.message});

  restaurant_Categories_Modal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['Allcategory'] != null) {
      allcategory = <Allcategory>[];
      json['Allcategory'].forEach((v) {
        allcategory!.add(new Allcategory.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.allcategory != null) {
      data['Allcategory'] = this.allcategory!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Allcategory {
  int? id;
  String? name;

  // String? image;
  String? imageUrl;

  Allcategory({
    this.id,
    this.name,
    // this.image,
    this.imageUrl,
  });

  Allcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    // data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
