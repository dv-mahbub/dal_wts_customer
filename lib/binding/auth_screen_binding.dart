import 'package:get/get.dart';
import 'package:wts_customer/controller/auth_controller.dart';

class AuthScreenBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<AuthController>(() => AuthController());
  }
}