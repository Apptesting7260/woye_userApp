class UserTransactionDetails {
  bool? status;
  String? message;
  var currentBalance;
  List<TransactionDetails>? transactionDetails;

  UserTransactionDetails({this.status, this.message,this.currentBalance, this.transactionDetails});

  UserTransactionDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    currentBalance = json['current_balance'];
    if (json['transactionDetails'] != null) {
      transactionDetails = <TransactionDetails>[];
      json['transactionDetails'].forEach((v) {
        transactionDetails!.add(new TransactionDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['current_balance'] = this.currentBalance;
    if (this.transactionDetails != null) {
      data['transactionDetails'] =
          this.transactionDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionDetails {
  int? id;
  int? userId;
  String? productName;
  String? transactionDate;
  int? vendorId;
  String? type;
  String? amount;
  String? transactionType;
  String? descp;
  String? currentBalance;
  String? createdAt;
  String? updatedAt;

  TransactionDetails(
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

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productName = json['product_name'];
    transactionDate = json['transaction_date'];
    vendorId = json['vendor_id'];
    type = json['type'];
    amount = json['amount'];
    transactionType = json['transaction_type'];
    descp = json['descp'];
    currentBalance = json['current_balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_name'] = this.productName;
    data['transaction_date'] = this.transactionDate;
    data['vendor_id'] = this.vendorId;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['transaction_type'] = this.transactionType;
    data['descp'] = this.descp;
    data['current_balance'] = this.currentBalance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
// class WalletModal {
//   bool? status;
//   String? message;
//   Wallet? wallet;
//
//   WalletModal({this.status, this.message, this.wallet});
//
//   WalletModal.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     wallet =
//     json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.wallet != null) {
//       data['wallet'] = this.wallet!.toJson();
//     }
//     return data;
//   }
// }
//
// class Wallet {
//   int? id;
//   int? userId;
//   String? bankname;
//   String? acHolder;
//   String? acNo;
//   String? acType;
//   String? ifsc;
//   String? currentBalance;
//   String? description;
//   int? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Wallet(
//       {this.id,
//         this.userId,
//         this.bankname,
//         this.acHolder,
//         this.acNo,
//         this.acType,
//         this.ifsc,
//         this.currentBalance,
//         this.description,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   Wallet.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     bankname = json['bankname'];
//     acHolder = json['ac_holder'];
//     acNo = json['ac_no'];
//     acType = json['ac_type'];
//     ifsc = json['ifsc'];
//     currentBalance = json['current_balance'];
//     description = json['description'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['bankname'] = this.bankname;
//     data['ac_holder'] = this.acHolder;
//     data['ac_no'] = this.acNo;
//     data['ac_type'] = this.acType;
//     data['ifsc'] = this.ifsc;
//     data['current_balance'] = this.currentBalance;
//     data['description'] = this.description;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
