import 'package:demo/controllers/login_controller.dart';

import 'package:get/get.dart';

class LoginScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    // TODO: implement dependencies
  }

}