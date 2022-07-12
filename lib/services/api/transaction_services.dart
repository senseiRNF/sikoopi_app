import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/transaction_classes.dart';
import 'package:sikoopi_app/services/api/init_api.dart';

class TransactionServices {
  Future<bool> writeTransaction(TransactionClasses transactions, List<CartClasses> cart) async {
    bool result = false;

    await InitAPI().clientAdapter().then((dio) async {
      try {
        FormData formData = FormData.fromMap({
          'userId': transactions.userId,
          'username': transactions.username,
          'date': DateFormat('yyyy-MM-dd').format(transactions.date!),
          'total': transactions.total,
          'payment': transactions.payment,
          'receipent': transactions.receipent,
          'address': transactions.address,
          'status': 'Waiting',
          'transferReceiptImage': transactions.transferReceiptImage,
        });

        await dio.post(
          'write-transaction.php',
          data: formData,
        ).then((dioResult) async {
          if(dioResult.data!['status'] == 1) {
            bool success = true;

            for(int i = 0; i < cart.length; i++) {
              FormData formData = FormData.fromMap({
                'transactionId': dioResult.data!['transaction_id'],
                'productName': cart[i].name,
                'productUom': cart[i].uom,
                'productPrice': cart[i].price,
                'productImage': cart[i].imagePath,
                'productQty': cart[i].totalQty,
              });

              await InitAPI().clientAdapter().then((dio) async {
                try {
                  await dio.post(
                    'write-transaction-detail.php',
                    data: formData,
                  ).then((dioResult) async {
                    if(dioResult.data!['status'] == 1) {
                      FormData formData = FormData.fromMap({
                        'stock': cart[i].stock - (cart[i].totalQty ?? 0),
                        'sellCount': (cart[i].sellCount ?? 0) + (cart[i].totalQty ?? 0),
                        'id': cart[i].id,
                      });

                      await InitAPI().clientAdapter().then((dio) async {
                        try {
                          await dio.post(
                            'update-product-stock.php',
                            data: formData,
                          ).then((dioResult) async {

                          });
                        } on DioError catch(_) {
                          success = false;
                        }
                      });
                    }
                  });
                } on DioError catch(_) {
                  success = false;
                }
              });
            }

            if(success) {
              result = true;
            }
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<TransactionResponse?> readAllTransaction() async {
    TransactionResponse? result;

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.get(
          'read-all-transaction.php',
        ).then((dioResult) {
          result = TransactionResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<TransactionResponse?> readTransationByUser(int id) async {
    TransactionResponse? result;

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.get(
          'read-all-transaction.php',
          queryParameters: {
            'id': id,
          },
        ).then((dioResult) {
          result = TransactionResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<TransactionDetailResponse?> readTransactionDetail(int id) async {
    TransactionDetailResponse? result;

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.get(
          'read-transaction-detail.php',
          queryParameters: {
            'id': id,
          },
        ).then((dioResult) {
          result = TransactionDetailResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<bool> updateTransactionStatus(int id, String status) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'id': id,
      'status': status,
    });

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          'update-transaction-status.php',
          data: formData,
        ).then((dioResult) {
          if(dioResult.data['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}

//------------------------------------------------------------------------------
class TransactionResponse {
  int? status;
  String? message;
  List<TransactionResponseData>? data;

  TransactionResponse({this.status, this.message, this.data});

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TransactionResponseData>[];
      json['data'].forEach((v) {
        data!.add(TransactionResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionResponseData {
  String? id;
  String? userId;
  String? username;
  String? date;
  String? total;
  String? payment;
  String? receipent;
  String? address;
  String? status;
  String? transferReceiptImage;

  TransactionResponseData({
    this.id,
    this.userId,
    this.username,
    this.date,
    this.total,
    this.payment,
    this.receipent,
    this.address,
    this.status,
    this.transferReceiptImage,
  });

  TransactionResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    username = json['username'];
    date = json['date'];
    total = json['total'];
    payment = json['payment'];
    receipent = json['receipent'];
    address = json['address'];
    status = json['status'];
    transferReceiptImage = json['transferReceiptImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['username'] = username;
    data['date'] = date;
    data['total'] = total;
    data['payment'] = payment;
    data['receipent'] = receipent;
    data['address'] = address;
    data['status'] = status;
    data['transferReceiptImage'] = transferReceiptImage;
    return data;
  }
}

class TransactionDetailResponse {
  int? status;
  String? message;
  List<TransactionDetailResponseData>? data;

  TransactionDetailResponse({this.status, this.message, this.data});

  TransactionDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TransactionDetailResponseData>[];
      json['data'].forEach((v) {
        data!.add(TransactionDetailResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionDetailResponseData {
  String? id;
  String? transactionId;
  String? productName;
  String? productUom;
  String? productPrice;
  String? productImage;
  String? productQty;

  TransactionDetailResponseData(
      {this.id,
        this.transactionId,
        this.productName,
        this.productUom,
        this.productPrice,
        this.productImage,
        this.productQty});

  TransactionDetailResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transactionId'];
    productName = json['productName'];
    productUom = json['productUom'];
    productPrice = json['productPrice'];
    productImage = json['productImage'];
    productQty = json['productQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transactionId'] = transactionId;
    data['productName'] = productName;
    data['productUom'] = productUom;
    data['productPrice'] = productPrice;
    data['productImage'] = productImage;
    data['productQty'] = productQty;
    return data;
  }
}