import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wts_customer/model/dashboard_info_model.dart';
import 'package:wts_customer/model/installationdue_model.dart';
import 'package:wts_customer/model/product_info_model.dart';
import 'package:wts_customer/repo/home_repo.dart';
import 'package:wts_customer/repo/installationdue_repo.dart';
import 'package:wts_customer/repo/product_repo.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/util/shared_pref_key.dart';
import 'package:wts_customer/util/status.dart';
import 'package:wts_customer/view/screen/login_screen.dart';

class ProductController extends GetxController {
  var status = Status.LOADING.obs;
  var isLoading = false.obs;
  Rx<List<ProductInfoModel>?> productList = Rx(null);
  ProductRepository _productRepo = ProductRepositoryImpl();
  int selectedTab = 0;

  @override
  void onInit() {
    super.onInit();
    // getUser();
  }

  submitPreparetion(String? product_id, String? product_code) async {
    status.value = Status.LOADING;
    isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {
      'product_id': product_id,
      'product_code': product_code,
      'customer_id': customerId,
      "lang": lang
    };
    try {
      var res = await _productRepo.submitPreparetion(map);
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

  Future<void> getProductList() async {
    status.value = Status.LOADING;
    isLoading.value = true;
    int? customerId = (await MySharedPreference.getInt(SharedPrefKey.USER_ID));
    String? lang = (await MySharedPreference.getLanguage());
    Map<String, dynamic> map = {'customer_id': customerId, "lang": lang};
    try {
      var res = await _productRepo.products(map);
      isLoading.value = false;
      if (res is List<ProductInfoModel>) {
        print(
            ' product....................................${res.length}...............');
        productList.value = res;
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
