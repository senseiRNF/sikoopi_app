import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/opname_classes.dart';
import 'package:sikoopi_app/services/api/init_api.dart';

class OpnameServices {
  Future<bool> writeOpname(OpnameClasses opname) async {
    bool result = false;

    await InitAPI().clientAdapter().then((dio) async {
      try {
        FormData formData = FormData.fromMap({
          'userId': opname.userId,
          'username': opname.username,
          'date': DateFormat('yyyy-MM-dd').format(opname.date!),
          'productId': opname.productId,
          'productName': opname.productName,
          'qty': opname.qty,
        });

        await dio.post(
          'write-opname.php',
          data: formData,
        ).then((dioResult) async {
          if(dioResult.data!['status'] == 1) {
            result = true;
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<OpnameResponse?> readOpnameProduct(int id) async {
    OpnameResponse? result;

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.get(
          'read-opname-product.php',
          queryParameters: {
            'id': id,
          },
        ).then((dioResult) {
          result = OpnameResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}

//------------------------------------------------------------------------------
class OpnameResponse {
  int? status;
  String? message;
  List<OpnameResponseData>? data;

  OpnameResponse({this.status, this.message, this.data});

  OpnameResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OpnameResponseData>[];
      json['data'].forEach((v) {
        data!.add(OpnameResponseData.fromJson(v));
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

class OpnameResponseData {
  String? id;
  String? date;
  String? userId;
  String? username;
  String? productId;
  String? productName;
  String? qty;

  OpnameResponseData({
    this.id,
    this.date,
    this.userId,
    this.username,
    this.productId,
    this.productName,
    this.qty,
  });

  OpnameResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    userId = json['userId'];
    username = json['username'];
    productId = json['productId'];
    productName = json['productName'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['userId'] = userId;
    data['username'] = username;
    data['productId'] = productId;
    data['productName'] = productName;
    data['qty'] = qty;
    return data;
  }
}