import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wts_customer/api/auth_api_service.dart';
import 'package:wts_customer/api/complain_api_service.dart';
import 'package:wts_customer/api/home_api_service.dart';
import 'package:wts_customer/api/installitiondue_api_service.dart';
import 'package:wts_customer/api/utils/network_info.dart';
import 'package:wts_customer/model/complain_details_model.dart';
import 'package:wts_customer/model/complain_info_model.dart';
import 'package:wts_customer/model/dashboard_info_model.dart';
import 'package:wts_customer/model/installationdue_model.dart';
import 'package:wts_customer/model/login_info_model.dart';

abstract class ComplainRepository {
  Future<dynamic> complainDue(Map<String, dynamic> map);

  Future<dynamic> complain(Map<String, dynamic> map);

  Future<dynamic> addComplain(Map<String, dynamic> map);

  Future<dynamic> installNotCompleted(Map<String, dynamic> map);

  Future<dynamic> supportNotCompleted(Map<String, dynamic> map);

  Future<dynamic> installCompletedToCustomer(Map<String, dynamic> map);

  Future<dynamic> supportCompletedToCustomer(Map<String, dynamic> map);

  Future<dynamic> evaluation(Map<String, dynamic> map);

  Future<dynamic> submitEvaluation(Map<String, dynamic> map);

  Future<dynamic> complain_details(Map<String, dynamic> map);

  Future<dynamic> install_details(Map<String, dynamic> map);
}

class ComplainRepositoryImpl implements ComplainRepository {
  ComplainApiService complainApiService = ComplainApiService.create();

  NetworkInfo networkInfo = NetworkInfoImpl(InternetConnectionChecker());

  @override
  Future<dynamic> complainDue(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.complain_dues(map);

      print(
          "....................complainDue response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        List list = res.body['complains'];
        return list.map((e) => ComplainModel.fromJson(e)).toList();
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res       ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> complain(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.complains(map);
      print(
          "....................installation response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        List list = res.body['complains'];
        return list.map((e) => ComplainModel.fromJson(e)).toList();
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res       ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> complain_details(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.complain_details(map);
      print(
          "....................complain_details response ${res.error}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return ComplainDetailsModel.fromJson(res.body['complain_details']);
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res       ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> install_details(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.install_details(map);
      print(
          "....................install_details response ${res.error}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return ComplainDetailsModel.fromJson(res.body['complain_details']);
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res       ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> addComplain(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.addComplain(map);
      print(
          "....................addComplain response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return res.body['message'];
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...........exception........ ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> evaluation(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.evaluation(map);
      print(
          "....................evaluation response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        List list = res.body['evaluation'];
        List<Map<String, dynamic>> evList = [];
        list.forEach((e) {
          evList.add(e);
        });
        return evList;
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...................res res res res       ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> installCompletedToCustomer(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.install_completed_to_customer(map);
      print(
          "....................installCompletedToCustomer response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return res.body['message'];
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...........exception........ ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> installNotCompleted(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.install_not_completed(map);
      print(
          "....................install_not_completed response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return res.body['message'];
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...........exception........ ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> submitEvaluation(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.submit_evaluation(map);
      print(
          "....................submitEvaluation response ${res.error}.........................");
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

  @override
  Future supportCompletedToCustomer(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.support_completed_to_customer(map);
      print(
          "....................support_completed_to_customer response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return res.body['message'];
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...........exception........ ${e}');
      throw throw Exception("Error");
    }
  }

  @override
  Future<dynamic> supportNotCompleted(Map<String, dynamic> map) async {
    try {
      var res = await complainApiService.support_not_completed(map);
      print(
          "....................support_not_completed response ${res.body}.........................");
      if (!res.isSuccessful) {
        throw Exception("Error");
      } else if (res.isSuccessful) {
        return res.body['message'];
      } else {
        return throw Exception("Error");
      }
    } catch (e) {
      print('...........exception........ ${e}');
      throw throw Exception("Error");
    }
  }
}
