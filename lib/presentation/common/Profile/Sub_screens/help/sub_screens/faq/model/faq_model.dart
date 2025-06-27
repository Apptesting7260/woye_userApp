class FAQModel {
  bool? status;
  List<Data>? data;

  FAQModel({this.status, this.data});

  FAQModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? que;
  String? ans;

  Data({this.que, this.ans});

  Data.fromJson(Map<String, dynamic> json) {
    que = json['que']?.toString();
    ans = json['ans']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['que'] = que;
    data['ans'] = ans;
    return data;
  }
}
