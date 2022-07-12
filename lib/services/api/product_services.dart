import 'package:dio/dio.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/opname_classes.dart';
import 'package:sikoopi_app/services/api/init_api.dart';
import 'package:sikoopi_app/services/api/opname_services.dart';

class ProductServices {
  Future<ProductResponse?> readAllProduct() async {
    ProductResponse? result;

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.get(
          'read-all-product.php',
        ).then((dioResult) {
          result = ProductResponse.fromJson(dioResult.data);
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }

  Future<bool> updateProduct(int userId, String username, DateTime date, int stockBefore, ProductResponseData product) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'id': product.id,
      'name': product.name,
      'uom': product.uom,
      'price': product.price,
      'stock': product.stock,
    });

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          'update-product.php',
          data: formData,
        ).then((dioResult) async {
          if(dioResult.data['status'] == 1) {
            await OpnameServices().writeOpname(
              OpnameClasses(
                userId: userId,
                username: username,
                date: date,
                productId: int.parse(product.id!),
                productName: product.name,
                qty: int.parse(product.stock!) - stockBefore,
              ),
            ).then((dioResult) {
              if(dioResult) {
                result = true;
              }
            });
          }
        });
      } on DioError catch(_) {

      }
    });

    return result;
  }
}

//------------------------------------------------------------------------------
class ProductResponse {
  int? status;
  String? message;
  List<ProductResponseData>? data;

  ProductResponse({this.status, this.message, this.data});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductResponseData>[];
      json['data'].forEach((v) {
        data!.add(ProductResponseData.fromJson(v));
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

class ProductResponseData {
  String? id;
  String? name;
  String? uom;
  String? price;
  String? imagePath;
  String? stock;
  String? categoryId;
  String? sellCount;
  String? categoryName;

  ProductResponseData({
    this.id,
    this.name,
    this.uom,
    this.price,
    this.imagePath,
    this.stock,
    this.categoryId,
    this.sellCount,
    this.categoryName,
  });

  ProductResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uom = json['uom'];
    price = json['price'];
    imagePath = json['imagePath'];
    stock = json['stock'];
    categoryId = json['categoryId'];
    sellCount = json['sellCount'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['uom'] = uom;
    data['price'] = price;
    data['imagePath'] = imagePath;
    data['stock'] = stock;
    data['categoryId'] = categoryId;
    data['sellCount'] = sellCount;
    data['categoryName'] = categoryName;
    return data;
  }
}