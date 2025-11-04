import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:wts_customer/model/dashboard_info_model.dart';
import 'package:wts_customer/model/login_info_model.dart';
import 'package:wts_customer/repo/home_repo.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/status.dart';

class HomeController extends GetxController {
  var status = Status.LOADING.obs;
  var isUser = true.obs;
  var isLoading = false.obs;
  var pageIndex =0.obs;
  Rx<DashBoardInfoModel?> dashBoardInfoModel = Rx(null);

  HomeRepository _homeRepo = HomeRepositoryImpl();

  @override
  void onInit() {
    super.onInit();
    // getUser();
  }


  Future<List<dynamic>> getOffers() async {
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {"lang": lang};
    try {
      var res = await _homeRepo.getOffers();
      if (res is List<dynamic>) {
        print(
            '............................getOffers........${res}...............');

        return res;
      } else {
        print(
            '...............................controller home error.....error...............');
      }
    } catch (e) {}
    return [];
  }
  Future<List<dynamic>> getPromotionBanner() async {
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {"lang": lang};
    try {
      var res = await _homeRepo.getPromotionBanner();
      if (res is List<dynamic>) {
        print(
            '............................getPromotionBanner........${res}...............');

        return res;
      } else {
        print(
            '...............................controller home error.....error...............');
      }
    } catch (e) {}
    return [];
  }

  Future<void> getDashBoardData() async {
    status.value = Status.LOADING;
    isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {'customer_id': customerId, "lang": lang,};
    try {
      var res = await _homeRepo.dashboard(map);
      isLoading.value = false;
      if (res is DashBoardInfoModel) {
        dashBoardInfoModel.value = res;
        status.value = Status.SUCCESS;
      } else {
        status.value = Status.ERROR;
      }
    } catch (e) {
      status.value = Status.ERROR;
      isLoading.value = false;
    }
  }
  Future<String?> changeProfilePic(String filePath) async {
    String? picUrl = null;
    status.value = Status.LOADING;
    isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    try {
      var res = await _homeRepo.changeProfilePic(customerId!, filePath);
      isLoading.value = false;
      if (res is String) {
        picUrl = res;
        String? strUserInfo =
            (await MySharedPreference.getString(SharedPrefKey.USER_INFO));
        UserInfoModel userInfoModel =
            UserInfoModel.fromJson(jsonDecode(strUserInfo ?? ''));
        userInfoModel.image = res;
        MySharedPreference.setString(SharedPrefKey.USER_INFO,jsonEncode(userInfoModel).toString());
        status.value = Status.SUCCESS;
      } else {
        status.value = Status.ERROR;
      }
    } catch (e) {
      status.value = Status.ERROR;
      isLoading.value = false;
    }
    return picUrl;
  }
}
