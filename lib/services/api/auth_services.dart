import 'package:dio/dio.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/user_classes.dart';
import 'package:sikoopi_app/services/api/init_api.dart';
import 'package:sikoopi_app/services/shared_preferences.dart';

class AuthServices {
  Future<bool> loginUser(String email, String pass) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'email': email,
      'pass': pass,
    });

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          'read-login-user.php',
          data: formData,
        ).then((dioResult) async {
          LoginResponse loginResponse = LoginResponse.fromJson(dioResult.data);

          if(loginResponse.data != null && loginResponse.data!.isNotEmpty) {
            await SharedPref().writeAuthorization(
              UserClasses(
                id: int.parse(loginResponse.data![0].id!),
                username: loginResponse.data![0].name,
                phoneNo: loginResponse.data![0].phone,
                address: loginResponse.data![0].address,
                email: loginResponse.data![0].email,
                pass: loginResponse.data![0].pass,
                role: loginResponse.data![0].role,
              ),
            ).then((writeResult) {
              if(writeResult) {
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

  Future<bool> updateUser(UserClasses user) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'id': user.id,
      'name': user.username,
      'phone': user.phoneNo,
      'address': user.address,
    });

    await InitAPI().clientAdapter().then((dio) async {
      try {
        await dio.post(
          'update-user.php',
          data: formData,
        ).then((dioResult) async {
          if(dioResult.data['status'] == 1) {
            await SharedPref().writeAuthorization(
              UserClasses(
                id: user.id,
                username: user.username,
                phoneNo: user.phoneNo,
                address: user.address,
                email: user.email,
                pass: user.pass,
                role: user.role,
              ),
            ).then((writeResult) {
              if(writeResult) {
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
class LoginResponse {
  int? status;
  String? message;
  List<LoginResponseData>? data;

  LoginResponse({this.status, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LoginResponseData>[];
      json['data'].forEach((v) {
        data!.add(LoginResponseData.fromJson(v));
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

class LoginResponseData {
  String? id;
  String? name;
  String? phone;
  String? address;
  String? email;
  String? pass;
  String? role;

  LoginResponseData({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.email,
    this.pass,
    this.role,
  });

  LoginResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    pass = json['pass'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['email'] = email;
    data['pass'] = pass;
    data['role'] = role;
    return data;
  }
}