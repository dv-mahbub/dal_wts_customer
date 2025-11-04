import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wts_customer/api/auth_api_service.dart';
import 'package:wts_customer/api/home_api_service.dart';
import 'package:wts_customer/api/installitiondue_api_service.dart';
import 'package:wts_customer/api/utils/network_info.dart';
import 'package:wts_customer/model/dashboard_info_model.dart';
import 'package:wts_customer/model/installationdue_model.dart';
import 'package:wts_customer/model/login_info_model.dart';

abstract class InstallationDueRepository {
  Future<dynamic> installationDue(Map<String, dynamic> map);
}

class InstallationDueRepositoryImpl implements InstallationDueRepository {
  InstallitiondueApiService installationDueApiService =
      InstallitiondueApiService.create();

  NetworkInfo networkInfo = NetworkInfoImpl(InternetConnectionChecker());

  @override
  Future<dynamic> installationDue(Map<String, dynamic> map) async {
    try {
      var res = await installationDueApiService.installation_dues(map);

      print(
          "....................installation response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        List list = res.body['installation_dues'];
      return  list.map((e) => InstallationDueModel.fromJson(e)).toList();
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res       ${e}');
      throw throw Exception("Error");
    }
  }
}
