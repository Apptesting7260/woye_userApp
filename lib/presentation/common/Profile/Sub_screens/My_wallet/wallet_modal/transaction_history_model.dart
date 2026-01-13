class UserTransactionHistoryModel {
  bool? status;
  List<Transactions>? transactions;

  UserTransactionHistoryModel({this.status, this.transactions});


  UserTransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? id;
  String? userId;
  String? productName;
  String? transactionDate;
  String? vendorId;
  String? type;
  String? amount;
  String? transactionType;
  String? descp;
  String? currentBalance;
  String? createdAt;
  String? updatedAt;

  Transactions(
      {this.id,
        this.userId,
        this.productName,
        this.transactionDate,
        this.vendorId,
        this.type,
        this.amount,
        this.transactionType,
        this.descp,
        this.currentBalance,
        this.createdAt,
        this.updatedAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    userId = json['user_id']?.toString();
    productName = json['product_name']?.toString();
    transactionDate = json['transaction_date']?.toString();
    vendorId = json['vendor_id']?.toString();
    type = json['type']?.toString();
    amount = json['amount']?.toString();
    transactionType = json['transaction_type']?.toString();
    descp = json['descp']?.toString();
    currentBalance = json['current_balance']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_name'] = productName;
    data['transaction_date'] = transactionDate;
    data['vendor_id'] = vendorId;
    data['type'] = type;
    data['amount'] = amount;
    data['transaction_type'] = transactionType;
    data['descp'] = descp;
    data['current_balance'] = currentBalance;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
