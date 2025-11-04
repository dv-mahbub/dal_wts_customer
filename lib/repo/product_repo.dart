import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wts_customer/api/auth_api_service.dart';
import 'package:wts_customer/api/home_api_service.dart';
import 'package:wts_customer/api/installitiondue_api_service.dart';
import 'package:wts_customer/api/product_api_service.dart';
import 'package:wts_customer/api/utils/network_info.dart';
import 'package:wts_customer/model/dashboard_info_model.dart';
import 'package:wts_customer/model/installationdue_model.dart';
import 'package:wts_customer/model/login_info_model.dart';
import 'package:wts_customer/model/product_info_model.dart';

abstract class ProductRepository {
  Future<dynamic> products(Map<String, dynamic> map);

  Future<dynamic> submitPreparetion(Map<String, dynamic> map);
}

class ProductRepositoryImpl implements ProductRepository {
  ProductApiService productApiService = ProductApiService.create();

  NetworkInfo networkInfo = NetworkInfoImpl(InternetConnectionChecker());

  @override
  Future<dynamic> products(Map<String, dynamic> map) async {
    try {
      var res = await productApiService.products(map);

      print(
          "....................products response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        List list = res.body['products'];
        return list.map((e) => ProductInfoModel.fromJson(e)).toList();
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res    products   ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> submitPreparetion(Map<String, dynamic> map) async {
    try {
      var res = await productApiService.submitPreparetion(map);
      print(
          "....................submitPreparetion response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw res.body;
      } else if (res.isSuccessful) {
        return res.body['message'];
      } else {
        return res.error;
      }
    } catch (e) {
      print('...........exception........ ${e}');
      throw throw Exception("Error");
    }
  }
}
