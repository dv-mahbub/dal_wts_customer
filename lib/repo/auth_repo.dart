import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wts_customer/api/auth_api_service.dart';
import 'package:wts_customer/api/utils/network_info.dart';
import 'package:wts_customer/model/login_info_model.dart';

abstract class AuthRepository {
  Future<dynamic>? login(Map<String, dynamic> map);
  Future<dynamic> language();
  Future<dynamic> getLanguageWiseContents(Map<String, dynamic> map);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthApiService authApiService = AuthApiService.create();

  NetworkInfo networkInfo = NetworkInfoImpl(InternetConnectionChecker());

  @override
  Future<dynamic>? login(Map<String, dynamic> map) async {
    try {
      var res = await authApiService.login(map);

      print(
          "....................login response ${res.body}.........................");

      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {

        String message = res.body['message'];
        if(message=="success"){
          return UserInfoModel.fromJson(res.body['customer_info']);

        }else{
          return message;
        }
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res   login    ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> language() async {
    try {
      var res = await authApiService.getLanguage();

      print(
          "....................language response ${res}.........................");

      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return res.body['language'];
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
      print('...................res res res res language      ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> getLanguageWiseContents(Map<String, dynamic> map) async {
    try {
      var res = await authApiService.getLanguageWiseContents(map);

      print(
          "....................language response ${res.body}.........................");

      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return res.body['contents'];
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res   getLanguageWiseContents    ${e}');
      throw throw Exception("Error");
    }
  }
}
