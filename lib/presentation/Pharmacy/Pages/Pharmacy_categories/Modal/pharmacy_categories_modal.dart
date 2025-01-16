class PharmacyCategoriesModal {
  bool? status;
  List<Allcategory>? allcategory;
  String? message;

  PharmacyCategoriesModal({this.status, this.allcategory, this.message});

  PharmacyCategoriesModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['Allcategory'] != null) {
      allcategory = <Allcategory>[];
      json['Allcategory'].forEach((v) {
        allcategory!.add(Allcategory.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? image;
  String? parentCategory;
  String? imageUrl;

  Allcategory({
    this.id,
    this.name,
    this.image,
    this.parentCategory,
    this.imageUrl,
  });

  Allcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    parentCategory = json['parent_category'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['parent_category'] = this.parentCategory;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
