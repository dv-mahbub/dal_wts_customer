import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wts_customer/model/complain_details_model.dart';
import 'package:wts_customer/model/complain_info_model.dart';
import 'package:wts_customer/repo/complain_repo.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/status.dart';

class ComplainController extends GetxController {
  var status = Status.LOADING.obs;
  var isLoading = false.obs;
  Rx<List<ComplainModel>?> complainList = Rx(null);
  Rx<List<ComplainModel>?> complainDueList = Rx(null);
  Rx<ComplainDetailsModel?> complainDetailsModel = Rx(null);
  ComplainRepository _complainRepo = ComplainRepositoryImpl();

  String? selectedItemId = null;
  int selectedTab = 0;

  @override
  void onInit() {
    super.onInit();
    // getUser();
  }

  addComplain(String product_id, String product_code, String service_note) async {
    status.value = Status.LOADING;
    isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {
      'customer_id': customerId,
      'product_id': product_id,
      'product_code': product_code,
      'service_note': service_note,
      "lang": lang
    };
    try {
      var res = await _complainRepo.addComplain(map);
      isLoading.value = false;
      if (res == 'success') {
        print('....................................${res}...............');

        status.value = Status.SUCCESS;
      } else {
        status.value = Status.ERROR;
      }
      Fluttertoast.showToast(msg: res);
    } catch (e) {
      status.value = Status.ERROR;
      isLoading.value = false;
    }
  }

  submitEvaluation(String mainMap,String? support_id,String? support_engineer) async {
    status.value = Status.LOADING;
    isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {
      'customer_id': customerId,
      'support_id': support_id,
      'evaluation': mainMap,
      'support_engineer': support_engineer,
      "lang": lang
    };
    try {
      var res = await _complainRepo.submitEvaluation(map);
      isLoading.value = false;
      if (res == 'success') {
        print('....................................${res}...............');

        status.value = Status.SUCCESS;
      } else {
        status.value = Status.ERROR;
      }
      Fluttertoast.showToast(msg: res);
    } catch (e) {
      status.value = Status.ERROR;
      isLoading.value = false;
    }
  }

  Future<dynamic> installCompletedToCustomer(String ticket_id) async {
    // status.value = Status.LOADING;
     //isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    print(
        '..........................evaluation..ticket_id.........${ticket_id}...................');
    Map<String, dynamic> map = {'customer_id': customerId,'ticket_id': ticket_id, "lang": lang};
    try {
      var res = await _complainRepo.installCompletedToCustomer(map);
      if (res == 'success') {
        var evaRes = await _complainRepo.evaluation(map);
       // isLoading.value = false;

        print('..................evaResevaResevaRes..................${evaRes}...............');
        if (evaRes is List<Map<String,dynamic>>) {
        //  status.value = Status.SUCCESS;
          return evaRes;
        }else{
        //  status.value = Status.ERROR;
        }
      } else {
       // isLoading.value = false;
       // status.value = Status.ERROR;
      }
      Fluttertoast.showToast(msg: res);
    } catch (e) {
     // status.value = Status.ERROR;
    //  isLoading.value = false;
    }
  }

  Future<dynamic> supportCompletedToCustomer(String ticket_id) async {
    // status.value = Status.LOADING;
     //isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    print(
        '..........................evaluation..ticket_id.........${ticket_id}...................');
    Map<String, dynamic> map = {'customer_id': customerId,'ticket_id': ticket_id, "lang": lang};
    try {
      var res = await _complainRepo.supportCompletedToCustomer(map);
      if (res == 'success') {
        var evaRes = await _complainRepo.evaluation(map);
       // isLoading.value = false;

        print('..................evaResevaResevaRes..................${evaRes}...............');
        if (evaRes is List<Map<String,dynamic>>) {
        //  status.value = Status.SUCCESS;
          return evaRes;
        }else{
        //  status.value = Status.ERROR;
        }
      } else {
       // isLoading.value = false;
       // status.value = Status.ERROR;
      }
      Fluttertoast.showToast(msg: res);
    } catch (e) {
     // status.value = Status.ERROR;
    //  isLoading.value = false;
    }
  }
  Future<dynamic> evaluation(String ticket_id) async {
    // status.value = Status.LOADING;
     //isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    print(
        '..........................evaluation..ticket_id.........${ticket_id}...................');
    Map<String, dynamic> map = {'customer_id': customerId,'ticket_id': ticket_id, "lang": lang};
    try {
        var evaRes = await _complainRepo.evaluation(map);
       // isLoading.value = false;

        print('..................evaResevaResevaRes..................${evaRes}...............');
        if (evaRes is List<Map<String,dynamic>>) {
        //  status.value = Status.SUCCESS;
          Fluttertoast.showToast(msg: 'success');
          return evaRes;
        }else{
        //  status.value = Status.ERROR;
        }
    //  Fluttertoast.showToast(msg: 'success');
    } catch (e) {
     // status.value = Status.ERROR;
    //  isLoading.value = false;
    }
  }

  Future<dynamic> installNotCompleted(String ticket_id, String note) async {
     status.value = Status.LOADING;
     isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {
      'customer_id': customerId,
      'ticket_id': ticket_id,
      'note': note,
      "lang": lang
    };
    try {
      var res = await _complainRepo.installNotCompleted(map);
      isLoading.value = false;
      if (res == 'success') {
        print('....................................${res}...............');

       status.value = Status.SUCCESS;
      } else {
        status.value = Status.ERROR;
      }
      Fluttertoast.showToast(msg: res);
    } catch (e) {
      status.value = Status.ERROR;
      isLoading.value = false;
    }
  }

  Future<dynamic> supportNotCompleted(String ticket_id, String note) async {
     status.value = Status.LOADING;
     isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {
      'customer_id': customerId,
      'ticket_id': ticket_id,
      'note': note,
      "lang": lang
    };
    try {
      var res = await _complainRepo.supportNotCompleted(map);
      isLoading.value = false;
      if (res == 'success') {
        print('....................................${res}...............');

       status.value = Status.SUCCESS;
      } else {
        status.value = Status.ERROR;
      }
      Fluttertoast.showToast(msg: res);
    } catch (e) {
      status.value = Status.ERROR;
      isLoading.value = false;
    }
  }

  Future<void> getComplainDueData(String? itemId) async {
    status.value = Status.LOADING;
    isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());

    Map<String, dynamic> map = {};
    itemId != null
        ? map = {'customer_id': customerId, "lang": lang, 'item_id': itemId}
        : map = {'customer_id': customerId, "lang": lang};

    try {
      var res = await _complainRepo.complainDue(map);
      isLoading.value = false;
      if (res is List<ComplainModel>) {
        print(
            '....................................${res.length}...............');
        complainDueList.value = res;
        status.value = Status.SUCCESS;
      } else {
        status.value = Status.ERROR;
      }
    } catch (e) {
      status.value = Status.ERROR;
      isLoading.value = false;
    }
  }

  Future<void> getComplainData(String? itemId) async {
    status.value = Status.LOADING;
    isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {};
    itemId != null
        ? map = {'customer_id': customerId, "lang": lang, 'item_id': itemId}
        : map = {'customer_id': customerId, "lang": lang};
    try {
      var res = await _complainRepo.complain(map);
      isLoading.value = false;
      if (res is List<ComplainModel>) {
        print(
            '....................................${res.length}...............');
        complainList.value = res;
        status.value = Status.SUCCESS;
      } else {
        status.value = Status.ERROR;
      }
    } catch (e) {
      status.value = Status.ERROR;
      isLoading.value = false;
    }
  }

  Future<dynamic> getComplainDetails(String ticketId) async {
   // status.value = Status.LOADING;
  //  isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {'ticket_id': ticketId, "lang": lang};
    try {
      var res = await _complainRepo.complain_details(map);
     // isLoading.value = false;
      if (res is ComplainDetailsModel) {
        print('....................................${res}...............');
        complainDetailsModel.value = res;
        return res;
      //  status.value = Status.SUCCESS;
      } else {
       // status.value = Status.ERROR;
      }
    } catch (e) {
     // status.value = Status.ERROR;
     // isLoading.value = false;
    }
  }

  Future<dynamic> getInstallDetails(String ticketId) async {
  //  status.value = Status.LOADING;
  //  isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {'ticket_id': ticketId, "lang": lang};
    try {
      var res = await _complainRepo.install_details(map);
     // isLoading.value = false;
      if (res is ComplainDetailsModel) {
        print('....................................${res}...............');
        complainDetailsModel.value = res;
        return res;
       // status.value = Status.SUCCESS;
      } else {
       // status.value = Status.ERROR;
      }
    } catch (e) {
     // status.value = Status.ERROR;
     // isLoading.value = false;
    }
  }
}
