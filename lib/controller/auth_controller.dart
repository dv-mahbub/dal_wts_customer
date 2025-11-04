import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wts_customer/api/auth_api_service.dart';
import 'package:wts_customer/api/utils/network_info.dart';
import 'package:wts_customer/helping/helpers.dart';
import 'package:wts_customer/mixins/print_log_mixin.dart';
import 'package:wts_customer/model/login_info_model.dart';
import 'package:wts_customer/repo/auth_repo.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/static_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/view/screen/home_page.dart';

class AuthController extends GetxController with PrintLogMixin {
  var status = Status.LOADING.obs;
  var isLoading = false.obs;
  var radioValue = 0.obs;
  Rx<String?> loginError = Rx(null);

  final mobileNumberCon = TextEditingController();

  // final AuthApiService _authService = AuthApiService.create();
  //
  // final NetworkInfo networkInfo = NetworkInfoImpl(DataConnectionChecker());
  AuthRepository _authRepo = AuthRepositoryImpl();

  // User get user => _firebaseUser.value;

  //User setUser(User user) => _firebaseUser.value = user;

  @override
  onInit() {
    //  _firebaseUser.bindStream(_fireAuth.authStateChanges());

    getLanguageWiseContents();
  }

  Future<void> login(String phone) async {
    String? token = await FirebaseMessaging.instance.getToken();
   // String? token = "";
    print('..........................token=${token}...............................');
    loginError.value = null;
    isLoading.value = true;
    status.value = Status.LOADING;
    try {
      String? lang = await MySharedPreference.getLanguage();
      Map<String, dynamic> map = {'lang': lang, 'phone': phone, 'token': token};
      var result = await _authRepo.login(map);
      isLoading.value = false;
      if (result is UserInfoModel) {
        loginError.value = null;
        MySharedPreference.setString(
            SharedPrefKey.USER_INFO, (jsonEncode(result)));
        MySharedPreference.setInt(
            SharedPrefKey.USER_ID, (result as UserInfoModel).customer_id ?? 0);
        MySharedPreference.setBoolean(SharedPrefKey.ISLOGIN, true);

        status.value = Status.SUCCESS;
        Get.offAllNamed(HomePage.pageId);
      } else if (result is String) {
        print(
            "...................................${result}...................");
        if (result == "error") {
          loginError.value = "Dear User, Please try to login by your registered mobile number with us, If you can not recognized, please call to the support number: ${StaticKey.SUPPORT_NUMBER}";
          status.value = Status.ERROR;
        } else {
          status.value = Status.SUCCESS;
        }
        Helpers.showSnackbar(title: 'Error', message: "Dear User, Please try to login by your registered mobile number with us, If you can not recognized, please call to the support number: ${StaticKey.SUPPORT_NUMBER}");
      }
    } catch (e) {
      loginError.value = e.toString();
      printLog(e);
      Helpers.showSnackbar(title: 'Error', message: "Dear User, Please try to login by your registered mobile number with us, If you can not recognized, please call to the support number: ${StaticKey.SUPPORT_NUMBER}");
      isLoading.value = false;
      status.value = Status.ERROR;
    }
  }

  Future<bool> getLanguageWiseContents() async {
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {"lang": lang};
    try {
      var res = await _authRepo.getLanguageWiseContents(map);
      if (res is Map<String, dynamic>) {
        print(
            '............................language........${res}...............');
        MySharedPreference.setString(
            SharedPrefKey.LANGUAGE_WISE_CONTENT, (jsonEncode(res)));
        return true;
      } else {
        print(
            '...............................controller language error.....error...............');
      }
    } catch (e) {}
    return false;
  }

  void signOutUser() async {
    try {
      // await Get.find<NotificationController>().fcmUnSubscribe();
      // await _authService.signOutUser();
      // Get.offAllNamed(RootScreen.pageId);
    } catch (e) {
      printLog(e);
      //Helpers.showSnackbar(title: 'Error', message: e.message);
    }
  }
}
