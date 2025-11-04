import 'package:get/get.dart';
import 'package:wts_customer/model/dashboard_info_model.dart';
import 'package:wts_customer/model/installationdue_model.dart';
import 'package:wts_customer/repo/home_repo.dart';
import 'package:wts_customer/repo/installationdue_repo.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/view/screen/login_screen.dart';

class InstallationDueController extends GetxController {
  var status = Status.LOADING.obs;
  var isLoading = false.obs;
  Rx<List<InstallationDueModel>?> installationDueList = Rx(null);
  InstallationDueRepository _installationDueRepo =
      InstallationDueRepositoryImpl();

  @override
  void onInit() {
    super.onInit();
    // getUser();
  }

  Future<void> getInstallationDueData() async {
    status.value = Status.LOADING;
    isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {'customer_id': customerId, "lang": lang};
    try {
      var res = await _installationDueRepo.installationDue(map);
      isLoading.value = false;
      if (res is List<InstallationDueModel>) {
        print(
            '....................................${res.length}...............');
        installationDueList.value = res;
        status.value = Status.SUCCESS;
      } else {
        status.value = Status.ERROR;
      }
    } catch (e) {
      status.value = Status.ERROR;
      isLoading.value = false;
    }
  }
}
