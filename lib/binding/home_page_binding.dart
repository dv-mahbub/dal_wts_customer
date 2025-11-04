import 'package:get/get.dart';
import 'package:wts_customer/controller/auth_controller.dart';
import 'package:wts_customer/controller/complain_controller.dart';
import 'package:wts_customer/controller/home_controller.dart';
import 'package:wts_customer/controller/installation_due_controller.dart';
import 'package:wts_customer/controller/product_controller.dart';

class HomePageBinding extends Bindings{
  @override
  void dependencies() {

   Get.put<HomeController>(HomeController(), permanent: true);
   Get.put<InstallationDueController>(InstallationDueController(), permanent: true);
   Get.put<AuthController>(AuthController(), permanent: true);
   Get.put<ProductController>(ProductController(), permanent: true);
   Get.put<ComplainController>(ComplainController(), permanent: true);
  }
}