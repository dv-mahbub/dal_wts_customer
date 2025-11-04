import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wts_customer/api/auth_api_service.dart';
import 'package:wts_customer/api/home_api_service.dart';
import 'package:wts_customer/api/utils/network_info.dart';
import 'package:wts_customer/model/dashboard_info_model.dart';
import 'package:wts_customer/model/login_info_model.dart';

abstract class HomeRepository {
  Future<dynamic> dashboard(Map<String, dynamic> map);
  Future<dynamic> changeProfilePic(int custome_id,String filePath);
  Future<dynamic> getPromotionBanner();
  Future<dynamic> getOffers();

}

class HomeRepositoryImpl implements HomeRepository {
  HomeApiService homeApiService = HomeApiService.create();

  NetworkInfo networkInfo = NetworkInfoImpl(InternetConnectionChecker());

  @override
  Future<dynamic> dashboard(Map<String, dynamic> map) async {
    try {
      var res = await homeApiService.dashBoard(map);

      print("....................login response ${res}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return DashBoardInfoModel.fromJson(res.body['dashboard']);
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res   dashboard    ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> changeProfilePic(int custome_id, String filePath) async {
    try {
      var res = await homeApiService.uploadProfilePic(custome_id,filePath);
      print("....................uploadProfilePic response ${res.error.toString()}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return res.body['customer_info']['image'];
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res   changeProfilePic    ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> getOffers() async {
    try {
      var res = await homeApiService.getOffers();

      print(
          "....................getOffers response ${res}.........................");

      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return res.body['offers'];
        // // String message = res.body['message'];
        //  if(message=="success"){
        //    return UserInfoModel.fromJson(res.body['language']);
        //
        //  }else{
        //    return message;
        //  }
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res  getOffers     ${e}');
      throw throw Exception("Error");
    }
  }


  @override
  Future<dynamic> getPromotionBanner()  async {
    try {
      var res = await homeApiService.getPromotionBanner();

      print(
          "....................getPromotionBanner response ${res}.........................");

      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return res.body['promotion_banners'];
        // // String message = res.body['message'];
        //  if(message=="success"){
        //    return UserInfoModel.fromJson(res.body['language']);
        //
        //  }else{
        //    return message;
        //  }
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res  getPromotionBanner     ${e}');
      throw throw Exception("Error");
    }
  }

}
